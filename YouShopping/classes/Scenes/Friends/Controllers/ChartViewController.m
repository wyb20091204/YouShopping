//
//  ChartViewController.m
//  YouShopping
//
//  Created by Yibo呀 on 16/7/26.
//  Copyright © 2016年 ooiaeiig. All rights reserved.
//

#import "ChartViewController.h"
#import "FriendChartCell.h"
#import "MineChartCell.h"
#import "PictureCell.h"
#import "ChartManager.h"
#import "MessageModel.h"

@interface ChartViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    EMChatManagerDelegate,
    UITextViewDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (strong,nonatomic)NSMutableArray *chartMuArr;
@property (strong,nonatomic)UITableView *chartTableView;

@property (strong,nonatomic)UITextView *textView;
@property (strong,nonatomic)ChartMessage *chartMessage;
@property (strong,nonatomic)UIImageView *butomImgView;
@property (strong,nonatomic)UIButton *smellButton;
@property (strong,nonatomic)UIButton *sendButton;

@end

@implementation ChartViewController

- (NSMutableArray *)chartMuArr{
    if (!_chartMuArr) {
        _chartMuArr = [NSMutableArray new];
    }
    return _chartMuArr;
}

- (UITableView *)chartTableView{
    if (!_chartTableView) {
        _chartTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _chartTableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.friendID;
    
    [self getTableView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backHot"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    [self drawButtonView];
    
    // 消息检索
    EMConversation *conversation = [[ChartManager shareChartManger] getConversationWithID:self.friendID type:EMConversationTypeChat];
    self.chartMuArr = [conversation loadMoreMessagesContain:nil before:-1 limit:20 from:nil direction:EMMessageSearchDirectionUp].mutableCopy;
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    _chartMessage = [[ChartMessage alloc] init];
}
#pragma mark ****** 给chartTableView添加代理 *******

- (void)getTableView{
    self.chartTableView.delegate = self;
    self.chartTableView.dataSource = self;
    
    // 注册cell
    [self.chartTableView registerClass:[MineChartCell class] forCellReuseIdentifier:MineChartCell_Identify];
    [self.chartTableView registerClass:[FriendChartCell class] forCellReuseIdentifier:FriendChatCell_Identify];
    [self.chartTableView registerClass:[PictureCell class] forCellReuseIdentifier:PictrueCell_Identify];
    
    self.chartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.chartTableView];
    
  
}

#pragma mark ****** 返回按钮 ******

- (void)backAction:(UIBarButtonItem *)barButtonItem{
    
    MessageModel *messageModel = [MessageModel new];
    // 获取每行的消息
    EMMessage *message = self.chartMuArr.lastObject;
    // 收到的文字消息
    EMMessageBody *msgBody = message.body;
    
    messageModel.friendID = self.friendID;
    messageModel.timestamp = message.timestamp;

    if (msgBody.type == EMMessageBodyTypeImage) {
        messageModel.lastMessage = @"[图片]";
    } else if (msgBody.type == EMMessageBodyTypeText){
        EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
        messageModel.lastMessage = textBody.text;
    }
    
    
    // 发送通知让消息列表添加新数组
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getMessageArr" object:nil userInfo:@{@"messageM":messageModel}];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ****** 画底部视图 ******

- (void)drawButtonView{
    self.butomImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 45, kScreenWidth, 45)];
    self.butomImgView.image = [UIImage imageNamed:@"toolbar_bottom_bar"];
    self.butomImgView.userInteractionEnabled = YES;
    [self.view addSubview:self.butomImgView];
    
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceButton setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateNormal];
    voiceButton.frame = CGRectMake(5, 5, 37, 40);
    [voiceButton addTarget:self action:@selector(voiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.butomImgView addSubview:voiceButton];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(47, 6, kScreenWidth - 47 - 95, 32)];
    self.textView.layer.cornerRadius = 6;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.delegate = self;
    [self.butomImgView addSubview:self.textView];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"chat_bottom_up_press"] forState:UIControlStateHighlighted];
    moreButton.frame = CGRectMake(kScreenWidth - 92, 0, 45, 45);
    [moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.butomImgView addSubview:moreButton];
    
    self.smellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.smellButton setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    self.smellButton.frame = CGRectMake(kScreenWidth - 45, 0, 45, 45);
    [self.smellButton addTarget:self action:@selector(semllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.butomImgView addSubview:self.smellButton];
    
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.backgroundColor = [UIColor greenColor];
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTintColor:[UIColor greenColor]];
    self.sendButton.frame = self.smellButton.frame;
    self.sendButton.hidden = YES;
    [self.sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.butomImgView addSubview:self.sendButton];
}

#pragma mark ****** 发送语音 ******

- (void)voiceButtonAction:(UIButton *)button{
    NSLog(@"send Voice");
}

#pragma mark ****** 加 ******

- (void)moreButtonAction:(UIButton *)button{
    NSLog(@"more");
    
    UIAlertController *imgViewAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 相机按钮
    UIAlertAction *camareAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 判断是否有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 初始化picker
            UIImagePickerController *picker = [UIImagePickerController new];
            // 设置类型
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 设置是否可以编辑
            picker.allowsEditing = YES;
            // 设置代理
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    [imgViewAlert addAction:camareAction];
    
    // 相册按钮
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            // 初始化picker
            UIImagePickerController *picker = [UIImagePickerController new];
            // 设置类型
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 设置是否可以编辑
            picker.allowsEditing = YES;
            // 设置代理
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    [imgViewAlert addAction:photoAction];
    
    // 取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [imgViewAlert addAction:cancelAction];
    
    [self presentViewController:imgViewAlert animated:YES completion:nil];
    
}

#pragma mark --- 拍照 或者 相册 选择完图片执行的方法 ---
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    __weak typeof(self)weakSelf = self;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:data displayName:@"image.png"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    //生成Message
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.friendID from:from to:self.friendID body:body ext:nil];
    message.chatType = EMChatTypeChat;// 设置为单聊消息
    
    [[EMClient sharedClient].chatManager asyncSendMessage:message
                                                 progress:nil
                                               completion:^(EMMessage *message, EMError *error) {
                                                   
                                                   [weakSelf.chartMuArr addObject:message];
                                                   // 刷新UI
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       [weakSelf.chartTableView reloadData];
                                                       [weakSelf scrollviewToButtom];
                                                   });
                                               }];
    NSLog(@"fasong tupian");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ****** 发送表情 ******

- (void)semllButtonAction:(UIButton *)button{
    NSLog(@"smell");
}

#pragma mark ****** 发送消息 ******

- (void)sendButtonAction:(UIButton *)button{
    NSLog(@"send");
    
    __weak typeof(self)weakSelf = self;
    
    if (self.textView.text.length > 0) {
        
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.textView.text];
        NSString *from = [[EMClient sharedClient] currentUsername];
        
        //生成Message
        EMMessage *message = [[EMMessage alloc] initWithConversationID:self.friendID from:from to:self.friendID body:body ext:nil];

        
        [[EMClient sharedClient].chatManager asyncSendMessage:message
                                                     progress:nil
                                                   completion:^(EMMessage *message, EMError *error) {
                                                       
                                                       [weakSelf.chartMuArr addObject:message];
                                                       // 刷新UI
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [weakSelf.chartTableView reloadData];
                                                           [weakSelf scrollviewToButtom];
                                                           weakSelf.textView.text = @"";
                                                       });
                                                       
                                                   }];

    }
    
    
}



/*!
 @method
 @brief 接收到一条消息
 */
- (void)didReceiveMessages:(NSArray *)aMessages{
    
    for (EMMessage *message in aMessages) {
        // 判断
        if ([message.conversationId isEqualToString:self.friendID]) {
            [self.chartMuArr addObject:message];
        }
    }
    [self.chartTableView reloadData];
    [self scrollviewToButtom];
}

#pragma mark ****** chartTableView代理方法 ******

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chartMuArr.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 获取每行的消息
    EMMessage *message = self.chartMuArr[indexPath.row];
    // 收到的文字消息
    EMMessageBody *msgBody = message.body;
    
    if (msgBody.type == EMMessageBodyTypeImage) {
        
        EMImageMessageBody *body = (EMImageMessageBody *)msgBody;
        NSLog(@"大图local路径 -- %@" ,body.localPath);
        PictureCell *pCell = [tableView dequeueReusableCellWithIdentifier:PictrueCell_Identify forIndexPath:indexPath];
        if (message.direction == EMMessageDirectionSend) {
            pCell.image = [UIImage imageWithContentsOfFile:body.localPath];
            return pCell;
        } else if (message.direction == EMMessageDirectionReceive){
            pCell.resaveUrl = body.remotePath;
            return  pCell;
        }
    } else if (msgBody.type == EMMessageBodyTypeText) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
        // 发送方
        if (message.direction == EMMessageDirectionSend) {
            
            MineChartCell *mCell = [tableView dequeueReusableCellWithIdentifier:MineChartCell_Identify forIndexPath:indexPath];
            
            _chartMessage = [[ChartMessage alloc] init];
            _chartMessage.content = textBody.text;
            mCell.chartMessage = self.chartMessage;
            return mCell;
            // 接收方
        } else if (message.direction == EMMessageDirectionReceive){
            FriendChartCell *fCell = [tableView dequeueReusableCellWithIdentifier:FriendChatCell_Identify forIndexPath:indexPath];
            
            _chartMessage = [[ChartMessage alloc] init];
            _chartMessage.content = textBody.text;
            fCell.chartMessage = self.chartMessage;
            
            return fCell;
        }
    } else {
        return nil;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取每行的消息
    EMMessage *message = self.chartMuArr[indexPath.row];
    // 收到的消息
    EMMessageBody *msgBody = message.body;
    if (msgBody.type == EMMessageBodyTypeText) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
        _chartMessage = [[ChartMessage alloc] init];
        _chartMessage.content = textBody.text;
        CGFloat height = _chartMessage.frame.size.height;
        return height + 50;
    } else if (msgBody.type == EMMessageBodyTypeImage) {
        return 120;
    }
    
    return 0;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.sendButton.hidden = NO;
    self.smellButton.hidden = YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return [textView resignFirstResponder];
}

#pragma mark - 单机窗口键盘隐藏
//说明：其实是选中到单元格了
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath = %ld",indexPath.row);
    [_textView resignFirstResponder];
}

#pragma mark - 滑动窗口时，键盘隐藏
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_textView resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //表视图滚动至底部。
    [UIView animateWithDuration:0.5 animations:^{
        
        _chartTableView.frame  = CGRectMake(0, - keyBoardFrame.size.height, kScreenWidth, kScreenHeight );
        _butomImgView.frame = CGRectMake(0, kScreenHeight - 45 - keyBoardFrame.size.height, kScreenWidth, 45);
    }];
}


-(void)keyboardWillBeHidden:(NSNotification*)aNotification{
    
    _butomImgView.frame = CGRectMake(0, kScreenHeight - 45, kScreenWidth, 45);
    _chartTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_chartTableView reloadData];
    
}


- (void)scrollviewToButtom{
    if (self.chartMuArr.count < 1) {
        return;
    }
    // 获取cell最后一行row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chartMuArr.count - 1 inSection:0];
    /**
     *  滑到最后一行的最下面
     *
     *  @param NSIndexPath 获取到的indexPath
     滑动到最下面
     *
     *
     */
    [self.chartTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
