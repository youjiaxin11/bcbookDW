//
//  FriendLevel.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "FriendLevel.h"

@implementation FriendLevel

User* userFriendLevel;

- (void)viewDidLoad {
    [super viewDidLoad];
    userFriendLevel = self.user;
    NSLog(@"%@",userFriendLevel.loginName);
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
