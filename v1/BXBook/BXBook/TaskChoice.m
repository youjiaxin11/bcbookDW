//
//  TaskChoice.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskChoice.h"

@implementation TaskChoice

/*开发者在页面操作中，用这几个值*/
User *userTaskChoice;//当前登录用户
int taskChoiceId;
int finishgameId1;//当前完成的游戏关卡号
- (void)viewDidLoad {
    [super viewDidLoad];
    userTaskChoice = self.user;
    finishgameId1=self.finishgameId;
    NSLog(@"golden:%d",_user.golden);
}

//跳转到下一页
- (IBAction)nextPage:(id)sender{
    UIButton* button1 = (UIButton*)sender;
    taskChoiceId = [button1 tag];
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
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information * information= [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = userTaskChoice;
        information.finishgameId4=finishgameId1;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];
    }
}

@end
