//
//  UserDao.h
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "User.h"
#import "UserLogin.h"

@interface UserDao : NSObject

//判断用户是否存在
+ (int) isExistUser:(NSString*)loginName pwd:(NSString*)password;

//读取某个人的全部信息
+ (User*) findUserByLoginName:(NSString*)loginName;

//修改密码
+ (int) changePassword:(NSString*)loginName pwd:(NSString*)passwordnew;

//更新User
+ (int) updateUser:(User*)user;

//插入到登录表
+ (int) insertUserLogin:(int)_userId loginTime:(NSString*)_loginTime logoutTime:(NSString*)_logoutTime loginState:(int)_loginState;

//通过userloginid查找登录表中某个人
+ (UserLogin*) findUserLoginByuserloginId:(int)i;

//计算登录表中人个数
+ (int) getUserLoginCount;

//更新登录表的退出时间
+ (int) updateUserLoginLogoutTime:(int)userLoginId logoutTime:(NSString*)_logoutTime;

//更新用户登录时间
+ (int) updateUserLoginTimes:(User*)user;

//通过userid查找登录表中某个人
+ (NSMutableArray*) findUserLoginByuserId:(int)_userId;
//更新已经完成的游戏关卡
+ (int) updatefinishId:(User*)user;
@end
