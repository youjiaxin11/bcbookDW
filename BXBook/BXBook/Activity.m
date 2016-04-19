//
//  Activity.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "Activity.h"

@implementation Activity

User* userActivity;
Task* taskActivity;

- (void)viewDidLoad {
    [super viewDidLoad];
    userActivity = self.user;
    taskActivity = self.task;
    NSLog(@"%@",userActivity.loginName);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userActivity.userId;
    behaviour.doWhat = @"浏览－任务活动";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Activity-(void)viewDidLoad-任务id:%d", taskActivity.taskId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//跳转到上传照片
- (IBAction)nextPagePhoto:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
    uploadphoto.user = userActivity;
    uploadphoto.task = taskActivity;
    [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:uploadphoto animated:YES completion:nil];
}

//跳转到上传视频
- (IBAction)nextPageVideo:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
    uploadvideo.user = userActivity;
    uploadvideo.task = taskActivity;
    [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:uploadvideo animated:YES completion:nil];
}

//跳转到上传音频
- (IBAction)nextPageAudio:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
    uploadaudio.user = userActivity;
    uploadaudio.task = taskActivity;
    [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:uploadaudio animated:YES completion:nil];
}

//跳转到我的作品
- (IBAction)nextPageMyWorks:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyWorks *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyWorks"];
    nextpage.user = userActivity;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//跳转到伙伴作品
- (IBAction)nextPageFriendWorks:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendWorks *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"FriendWorks"];
    nextpage.user = userActivity;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
