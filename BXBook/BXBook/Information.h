//
//  Information.h
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "GameChoice.h"
#import "UserCenter.h"
#import "LoginView.h"

@interface Information : BaseControl

@property (assign, nonatomic) User* user;//当前登录用户
//@property (weak, nonatomic) IBOutlet UITextView *introduce;
@property (assign, nonatomic) int finishgameId4;//当前完成的游戏关卡号
@end