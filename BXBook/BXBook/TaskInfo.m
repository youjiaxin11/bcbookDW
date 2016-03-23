//
//  TaskInfo.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "TaskInfo.h"
#import "Cheats.h"
#import "PlayMusicImpl.h"
#import <AVFoundation/AVFoundation.h>

@interface TaskInfo()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件
@property(nonatomic,assign)int currentIndex1;//用三个int型的属性来记录当前的索引
@property(nonatomic,assign)int currentIndex2;//用三个int型的属性来记录当前的索引
@property(nonatomic,assign)int currentIndex3;//用三个int型的属性来记录当前的索引

@end

@implementation TaskInfo

User* userTaskinfo;
Task* taskTaskinfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设定位置和大小
    CGRect frame = CGRectMake(0,0,0,0);
    frame.size = [UIImage imageNamed:@"兔爷－评价标准GIF.gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"兔爷－评价标准GIF" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    userTaskinfo = self.user;
    taskTaskinfo = [TaskDao findTaskByTaskId:_taskChoiceId];
    [self musicEnsure];
    NSLog(@"%d,%d,%d,%d",taskTaskinfo.taskId,_currentIndex1,_currentIndex2,_currentIndex3);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskinfo.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"TaskInfo-(void)viewDidLoad-任务id:%d", _taskChoiceId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    //[_taskMessageText setText:taskTaskinfo.taskMessage];
    //[_taskEvaluationText setText:taskTaskinfo.taskEvaluation];
//    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(250, 545, 150, 30) numberOfStars:taskTaskinfo.taskRank];
//    self.starRateView.scorePercent = 1;
//    self.starRateView.allowIncompleteStar = NO;
//    self.starRateView.hasAnimation = YES;
//    [self.view addSubview:self.starRateView];
    
    //    textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 27;// 字体的行间距
//
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
    //_taskMessageText.attributedText = [[NSAttributedString alloc] initWithString:taskTaskinfo.taskMessage attributes:attributes];
    //_taskEvaluationText.attributedText = [[NSAttributedString alloc] initWithString:taskTaskinfo.taskEvaluation attributes:attributes];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskinfo.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskInfo-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userTaskinfo;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userTaskinfo;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userTaskinfo;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }
}

//歌曲初始化，存储在数组里面
-(NSArray *)songs
{
    if (_songs==nil) {
        self.songs=@[@"2.m4a",@"3.m4a",@"4.m4a",@"5.m4a",@"6.m4a",@"7.m4a",@"8.m4a",@"9.m4a",@"10.m4a",@"11.m4a",@"12.m4a",@"13.m4a",@"14.m4a",@"15.m4a",@"16.m4a",@"17.m4a",@"18.m4a",@"19.m4a"];
    }
    return _songs;
}

//播放音乐初始化
-(void)musicEnsure{
    if (taskTaskinfo.taskId == 1) {
        _currentIndex1 = 2;
        _currentIndex2 = 1;
        _currentIndex3 = 0;
    }else if (taskTaskinfo.taskId == 2) {
        _currentIndex1 = 5;
        _currentIndex2 = 4;
        _currentIndex3 = 3;
    }else if (taskTaskinfo.taskId == 3) {
        _currentIndex1 = 8;
        _currentIndex2 = 7;
        _currentIndex3 = 6;
    }else if (taskTaskinfo.taskId == 4) {
        _currentIndex1 = 11;
        _currentIndex2 = 10;
        _currentIndex3 = 9;
    }else if (taskTaskinfo.taskId == 5) {
        _currentIndex1 = 14;
        _currentIndex2 = 13;
        _currentIndex3 = 12;
    }else if (taskTaskinfo.taskId == 6) {
        _currentIndex1 = 17;
        _currentIndex2 = 16;
        _currentIndex3 = 15;
    }
}

//音乐播放控制
- (void)play:(int)currentIndex {
    //开始播放/继续播放
    [PlayMusicImpl playMusic:self.songs[currentIndex]];
}
- (void)stop:(int)currentIndex {
    //停止播放
    [PlayMusicImpl stopMusic:self.songs[currentIndex]];
}

//跳转到下一页
- (IBAction)nextPage:(id)sender{
    NSLog(@"golden:%d",_user.golden);
    
    if (_user.golden >= 2 ) {
        _user.golden-=2;
        
        NSLog(@"此处保存金币数量");
        //此处保存金币数量
        
        [UserDao updateUser:_user];
        
        NSLog(@"golden:%d",_user.golden);
        
        //下一页
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Activity *activity = [mainStoryboard instantiateViewControllerWithIdentifier:@"Activity"];
        activity.user = userTaskinfo;
        activity.task = taskTaskinfo;
        [activity setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:activity animated:YES completion:nil];
    }else{
        [self promptGoldenNotEnough:@"您的金币不足，不能开启任务，快去闯关获取金币吧！"];
    }
}

//提示框点击确定后音乐暂停
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //音乐全部暂停
    [self stop:_currentIndex1];
    [self stop:_currentIndex2];
    [self stop:_currentIndex3];
    
}

- (void)TaskinfoCheat{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    cheat.user = userTaskinfo;
    cheat.task = taskTaskinfo;
    cheat.flag1cheat=4;
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)buttoncheat:(UIButton *)sender {
    [self TaskinfoCheat];
}

//点击三星标准
- (IBAction)levelThree:(id)sender {
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskinfo.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskInfo-(IBAction)levelThree:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    [self prompt:taskTaskinfo.evaluation1];
    if (taskTaskinfo.taskId == 3||taskTaskinfo.taskId == 5) {
    }else{[self play:_currentIndex1];}
}
//点击四星标准
- (IBAction)levelFour:(id)sender {
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskinfo.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskInfo-(IBAction)levelFour:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    [self prompt:taskTaskinfo.evaluation2];
    if (taskTaskinfo.taskId == 3||taskTaskinfo.taskId == 5) {
    }else{[self play:_currentIndex2];}
}
//点击五星标准
- (IBAction)levelFive:(id)sender {
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskinfo.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskInfo-(IBAction)levelFive:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    [self prompt:taskTaskinfo.evaluation3];
    if (taskTaskinfo.taskId == 3||taskTaskinfo.taskId == 5) {
    }else{[self play:_currentIndex3];}
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
