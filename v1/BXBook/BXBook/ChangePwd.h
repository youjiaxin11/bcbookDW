//
//  ChangePwd.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface ChangePwd : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UITextField *oldPwdText;
@property (strong, nonatomic) IBOutlet UITextField *pwdText;
@property (strong, nonatomic) IBOutlet UITextField *pwdText2;


@end