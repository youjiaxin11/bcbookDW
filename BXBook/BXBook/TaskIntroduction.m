//
//  TaskIntroduction.m
//  BXBook
//
//  Created by Jack on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskIntroduction.h"

@implementation TaskIntroduction

User* userTaskIntroduction;
Task* taskTaskIntroduction;

- (void)viewDidLoad {
    [super viewDidLoad];
    userTaskIntroduction = self.user;
    taskTaskIntroduction = [TaskDao findTaskByTaskId:_taskChoiceId];
    [_taskMessageText setText:taskTaskIntroduction.taskMessage];
    NSLog(@"taskintruduction：%@", userTaskIntroduction.loginName);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
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
    }
}
- (IBAction)goToTaskInfo:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskInfo *taskinfo = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
    taskinfo.user = userTaskIntroduction;
    taskinfo.taskChoiceId = _taskChoiceId;
    [taskinfo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:taskinfo animated:YES completion:nil];
}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end