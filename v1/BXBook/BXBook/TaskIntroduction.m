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