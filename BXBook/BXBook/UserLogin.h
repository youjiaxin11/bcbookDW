//
//  UserLogin.h
//  BXBook
//
//  Created by sunzhong on 15/7/24.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLogin : NSObject

@property int userLoginId;// 主键自增长
@property int userId;//登录者，外键user
@property NSString* loginTime;//登入时间
@property NSString* logoutTime;//登出时间
@property int loginState;//登录状态


@end