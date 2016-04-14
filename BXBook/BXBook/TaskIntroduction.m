//
//  TaskIntroduction.m
//  BXBook
//
//  Created by Jack on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskIntroduction.h"
#import "NotebookController.h"
#import "VideoPlay.h"

@implementation TaskIntroduction

User* userTaskIntroduction;
Task* taskTaskIntroduction;
MPMoviePlayerViewController *movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    userTaskIntroduction = self.user;
    taskTaskIntroduction = [TaskDao findTaskByTaskId:_taskChoiceId];
//    [_taskMessageText setText:taskTaskIntroduction.taskMessage];
    NSString *three = taskTaskIntroduction.evaluation1;
    NSString *four = taskTaskIntroduction.evaluation2;
    NSString *five = taskTaskIntroduction.evaluation3;
    NSString *str1 = [three stringByAppendingString:[NSString stringWithFormat:@"\n%@", four]];
    NSString *str2 = [str1 stringByAppendingString:[NSString stringWithFormat:@"\n%@", five]];
//    [_evaluateText setText:str2];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:24],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _evaluateText.attributedText = [[NSAttributedString alloc] initWithString:str2 attributes:attributes];
    _taskMessageText.attributedText = [[NSAttributedString alloc] initWithString:taskTaskIntroduction.taskMessage attributes:attributes];
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskIntroduction.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"TaskIntroduction-(void)viewDidLoad-任务id:%d", _taskChoiceId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
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
    behaviour.userId = userTaskIntroduction.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskIntroduction-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userTaskIntroduction;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userTaskIntroduction;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userTaskIntroduction;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userTaskIntroduction;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}
- (IBAction)goToTaskInfo:(id)sender {
    
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
        activity.user = userTaskIntroduction;
        activity.task = taskTaskIntroduction;
        [activity setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:activity animated:YES completion:nil];
    }else{
        [self createSelfPrompt:@"你的金币不足，不能开启任务，快去闯关获取金币吧！" image:[UIImage imageNamed:@"sad.jpg"]];
    }


}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)studyMicroClass:(id)sender {
    Help* help = [HelpDao findHelpByHelpId:taskTaskIntroduction.helpId];
    //更新通关秘籍浏览人次
    if (help.viewTimes>=0) {
        help.viewTimes++;
    }else{
        help.viewTimes=1;
    }
    [HelpDao updateHelpViewTimes:help];
    [self playVideo];
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskIntroduction.userId;
    behaviour.doWhat = @"查看微课";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"TaskIntroduction-(IBAction)studyMicroClass:(id)sender-任务id:%d", taskTaskIntroduction.taskId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

-(void)playVideo{
    
    
    NSString* helpIdNowStr = [NSString stringWithFormat:@"%d", taskTaskIntroduction.helpId];
    NSString* fileName = [@"Weike" stringByAppendingString:helpIdNowStr];//根据helpId动态拼接文件名
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    NSLog(@"weike :%@",path);
    //视频URL
    NSURL *url = [NSURL fileURLWithPath:path];
    //视频播放对象
    movie = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:movie];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name: MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
}

-(void)myMovieFinishedCallback:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [movie  dismissMoviePlayerViewControllerAnimated];
    [movie.moviePlayer stop];
    movie.moviePlayer.initialPlaybackTime = -1.0;
    movie = nil;
}


@end