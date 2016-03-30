//
//  UserDao.m
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "UserDao.h"
#import "DataUtil.h"


@implementation UserDao

+ (int) isExistUser:(NSString*)loginName pwd:(NSString*)password {
    int success = 0;
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM user WHERE loginName = '%@'", loginName];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            int userId = sqlite3_column_int(statement, 0);
            char *loginName = (char *)sqlite3_column_text(statement, 1);
            char *pwd = (char *)sqlite3_column_text(statement, 2);
            NSLog(@"数据库：userId:%d loginName:%s password:%s", userId, loginName, pwd);
            NSString *pwdnssting = [NSString stringWithUTF8String:pwd];
            if([password isEqualToString:pwdnssting] == YES){//密码正确
                success = 1;
            }else{//密码错误
                success = 2;
            }
        }else {
            NSLog(@"%d",3);
            success = 3;
        }
    }
        sqlite3_finalize(statement);//结束之前清除statement对象
        sqlite3_close(database);//关闭数据库
        return success;
}

+ (User*) findUserByLoginName:(NSString*)loginName {
    User *user = [[User alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM user WHERE loginName = '%@'", loginName];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            user.userId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                user.loginName = (NSString*)nil;
            }else {
                user.loginName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                user.password = (NSString*)nil;
            }else{
              user.password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            user.role = sqlite3_column_int(statement, 3);
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                user.realName = (NSString*)nil;
            }else {
                user.realName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            user.sex = sqlite3_column_int(statement, 5);
            user.school = sqlite3_column_int(statement, 6);
            user.grade = sqlite3_column_int(statement, 7);
            user.classNum = sqlite3_column_int(statement, 8);
            user.golden = sqlite3_column_int(statement, 9);
            user.receivePraiseNum = sqlite3_column_int(statement, 10);
            user.sendPraiseNum = sqlite3_column_int(statement, 11);
            user.receiveCommentNum = sqlite3_column_int(statement, 12);
            user.sendCommentNum = sqlite3_column_int(statement, 13);
            user.rank = sqlite3_column_int(statement, 14);
            user.loginTimes = sqlite3_column_int(statement, 15);
            user.answerTimes = sqlite3_column_int(statement, 16);
            user.answerRightTimes = sqlite3_column_int(statement, 17);
            if ((char *)sqlite3_column_text(statement, 18) == nil) {
                user.answerRightPer = (NSString*)nil;
            }else {
                user.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 18)];
            }
            user.finishId1 = sqlite3_column_int(statement, 19);
            user.finishId2 = sqlite3_column_int(statement, 20);
            user.finishId3 = sqlite3_column_int(statement, 21);
            user.finishId4 = sqlite3_column_int(statement, 22);
            user.finishId5 = sqlite3_column_int(statement, 23);
            user.finishId6 = sqlite3_column_int(statement, 24);
            user.finishId7 = sqlite3_column_int(statement, 25);
            user.finishId8 = sqlite3_column_int(statement, 26);
            user.finishId9 = sqlite3_column_int(statement, 27);
            user.finishId10 = sqlite3_column_int(statement, 28);
            user.finishId11 = sqlite3_column_int(statement, 29);
            user.finishId12 = sqlite3_column_int(statement, 30);
            user.award1=sqlite3_column_int(statement, 31);
            user.award2=sqlite3_column_int(statement, 32);
            user.award3=sqlite3_column_int(statement, 33);
            user.award4=sqlite3_column_int(statement, 34);
            user.award5=sqlite3_column_int(statement, 35);
            user.award6=sqlite3_column_int(statement, 36);
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return user;
}

+ (int) changePassword:(NSString*)loginName pwd:(NSString*)passwordnew{
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET password = '%@' WHERE loginName = '%@'", passwordnew, loginName];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
//        NSLog(@"%d",sqlite3_step(statement));
//        NSLog(@"%d",SQLITE_DONE);
//        if (sqlite3_step(statement) == SQLITE_DONE) {
//            success = 1;
//        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

+ (int) updateUser:(User*)user{
    int success = 1;
    if (user.answerTimes > 0) {
        float x = (float)user.answerRightTimes/(float)user.answerTimes;
        NSString* percent = [DataUtil floatToPercent:x];
        user.answerRightPer = percent;
    }else{
        user.answerRightPer = nil;
    }
    NSLog(@"!!!!!!!!!!!!%@",user.answerRightPer);
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET golden = '%d', answerTimes = '%d', answerRightTimes = '%d', answerRightPer = '%@' WHERE loginName = '%@'", user.golden,  user.answerTimes,  user.answerRightTimes,  user.answerRightPer, user.loginName];
    
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);

    if (result == SQLITE_OK)
    {
        NSLog(@"userUpdate!!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}


+ (int) insertUserLogin:(int)_userId loginTime:(NSString*)_loginTime logoutTime:(NSString*)_logoutTime loginState:(int)_loginState{
    sqlite3* database = [SqliteUtil openDatabase];
    
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%d', '%@', '%@', '%d')",
                      @"userLogin", @"userId", @"loginTime", @"logoutTime", @"loginState", _userId, _loginTime, _logoutTime, _loginState];
    char *errorMesg = NULL;
    int result = sqlite3_exec(database,[sql1 UTF8String],NULL, NULL, &errorMesg);
    if (result == SQLITE_OK) {
        NSLog(@"成功添加数据");
        sqlite3_close(database);//关闭数据库
        return result;
    }else {
        NSLog(@"添加数据失败:%s",errorMesg);
        sqlite3_close(database);//关闭数据库
        return result;
    }
    
    
}

+ (int) getUserLoginCount{
    int i = 0;
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userLogin ORDER BY userLoginId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            i = sqlite3_column_int(statement, 0);
            NSLog(@"userdao里面查询：%d",i);
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return i;
}

+ (UserLogin*) findUserLoginByuserloginId:(int)i{
    UserLogin *userLogin = [[UserLogin alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userLogin WHERE userLoginId = '%d'", i];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        if (sqlite3_step(statement) == SQLITE_ROW) {
            userLogin.userLoginId = sqlite3_column_int(statement, 0);
            NSLog(@"userdao里面查询：%d",userLogin.userLoginId);
            userLogin.userId = sqlite3_column_int(statement, 1);
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                userLogin.loginTime = (NSString*)nil;
            }else {
                userLogin.loginTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                userLogin.logoutTime = (NSString*)nil;
            }else {
                userLogin.logoutTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            userLogin.loginState = sqlite3_column_int(statement, 4);
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return userLogin;
}

+ (int) updateUserLoginLogoutTime:(int)userLoginId logoutTime:(NSString*)_logoutTime{
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE userLogin SET logoutTime = '%@' WHERE userLoginId = '%d'", _logoutTime, userLoginId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

+ (int) updateUserLoginTimes:(User*)user {
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET loginTimes = '%d' WHERE loginName = '%@'", user.loginTimes, user.loginName];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

+ (NSMutableArray*) findUserLoginByuserId:(int)_userId{
    NSMutableArray* userLoginArray = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userLogin WHERE userId = '%d'", _userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            UserLogin* ul = [[UserLogin alloc]init];
            ul.userLoginId = sqlite3_column_int(statement, 0);
            ul.userId = sqlite3_column_int(statement, 1);
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                ul.loginTime = (NSString*)nil;
            }else {
                ul.loginTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                ul.logoutTime = (NSString*)nil;
            }else {
                ul.logoutTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            ul.loginState = sqlite3_column_int(statement, 4);
            [userLoginArray addObject:ul];
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    
    return userLoginArray;
}
+ (int) updatefinishId:(User*)user {
    NSLog(@"update finishid：%@",user.loginName);
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET finishId1= '%d',  finishId2= '%d',finishId3= '%d',finishId4= '%d', finishId5= '%d',  finishId6= '%d',finishId7= '%d',finishId8= '%d',finishId9= '%d',  finishId10= '%d',finishId11= '%d',finishId12= '%d' WHERE userID = '%d'", user.finishId1,user.finishId1,user.finishId3,user.finishId4,user.finishId5,user.finishId6,user.finishId7,user.finishId8,user.finishId9,user.finishId10,user.finishId11,user.finishId12,user.userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}
+ (int) updateaward:(User*)user {
    NSLog(@"update award：%@",user.loginName);
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE user SET award1= '%d',  award2= '%d',award3= '%d',award4= '%d', award5= '%d',  award6= '%d' WHERE userID = '%d'", user.award1,user.award2,user.award3,user.award4,user.award5,user.award6,user.userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
        NSLog(@"aaa");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}
@end