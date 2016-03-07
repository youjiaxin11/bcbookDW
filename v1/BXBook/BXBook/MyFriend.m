//
//  MyFriend.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "MyFriend.h"

@implementation MyFriend


User* userMyFriend;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",userMyFriend.loginName);
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
