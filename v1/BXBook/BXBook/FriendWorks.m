//
//  FriendWorks.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "FriendWorks.h"

@implementation FriendWorks


User* userFriendWorks;

- (void)viewDidLoad {
    [super viewDidLoad];
    userFriendWorks = self.user;
    NSLog(@"%@",userFriendWorks.loginName);
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
