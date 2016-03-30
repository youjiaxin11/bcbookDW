//
//  UserCenter.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//
#import "Information.h"
#import "BaseControl.h"
#import "UserInfo.h"
#import "ChangePwd.h"
#import "MyWorks.h"
#import "LearningRecord.h"
#import "MyFriend.h"
#import "FriendLevel.h"
#import "Mybag.h"
@interface UserCenter : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UIButton *admDataCen;
- (IBAction)mybag:(UIButton *)sender;



@end
