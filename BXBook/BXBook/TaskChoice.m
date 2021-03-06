//
//  TaskChoice.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskChoice.h"
#import "NotebookController.h"


@interface TaskChoice()<AVAudioPlayerDelegate>
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件
@end


@implementation TaskChoice

/*开发者在页面操作中，用这几个值*/
User *userTaskChoice;//当前登录用户
int taskChoiceId;
//int finishgameId1;//当前完成的游戏关卡号
- (void)viewDidLoad {
    [super viewDidLoad];
    userTaskChoice = self.user;
   // finishgameId1=self.finishgameId;
    NSLog(@"golden:%d",_user.golden);
    
    [self play];
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskChoice.userId;
    behaviour.doWhat = @"浏览－任务选择";
    behaviour.doWhere = @"TaskChoice-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    [self stop];
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskChoice.userId;
    behaviour.doWhat = @"浏览－测拉";
    behaviour.doWhere = @"TaskChoice-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userTaskChoice;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userTaskChoice;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userTaskChoice;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userTaskChoice;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}

//跳转到下一页
- (IBAction)nextPage:(id)sender{
    
     [self stop];
    UIButton* button1 = (UIButton*)sender;
    taskChoiceId = (int)[button1 tag];
    NSLog(@"id:%d",taskChoiceId);
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskIntroduction *taskintroduction = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskIntroduction"];
    taskintroduction.user = userTaskChoice;
    taskintroduction.taskChoiceId = taskChoiceId;
    [taskintroduction setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:taskintroduction animated:YES completion:nil];
}

//左滑返回关卡选择
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
         [self stop];
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information * information= [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = userTaskChoice;
      //  information.finishgameId4=finishgameId1;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
     [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Information * information= [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
    information.user = userTaskChoice;
  //  information.finishgameId4=finishgameId1;
    [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:information animated:YES completion:nil];
}


//音乐播放控制
- (void)play {
    //开始播放/继续播放
    [PlayMusicImpl playMusic:self.songs[0]];
}

- (void)stop {
    //停止播放
    [PlayMusicImpl stopMusic:self.songs[0]];
}

//歌曲初始化
-(NSArray *)songs
{
    if (_songs==nil) {
        self.songs=@[@"9.mp3"];
    }
    return _songs;
}

@end
