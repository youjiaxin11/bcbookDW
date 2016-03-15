//
//  Comment.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "Comment.h"

@implementation Comment


User* userComment;
Task* taskComment;

- (void)viewDidLoad {
    [super viewDidLoad];
    userComment = self.user;
    taskComment = self.task;
    NSLog(@"%@",userComment.loginName);
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




@end
