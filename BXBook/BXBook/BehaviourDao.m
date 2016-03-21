//
//  BehaviourDao.m
//  BCBookDW
//
//  Created by sunzhong on 16/3/21.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BehaviourDao.h"

@implementation BehaviourDao

//添加behaviour
+ (int) addBehaviour:(Behaviour*)behaviour{
    sqlite3* database = [SqliteUtil openDatabase];
    
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@', '%@') VALUES ('%d', '%@', '%@', '%@')",
                      @"behaviour", @"userId", @"doWhat", @"doWhere", @"doWhen", behaviour.userId, behaviour.doWhat, behaviour.doWhere, behaviour.doWhen];
    char *errorMesg = NULL;
    int result = sqlite3_exec(database,[sql1 UTF8String],NULL, NULL, &errorMesg);
    if (result == SQLITE_OK) {
        NSLog(@"成功添加行为数据");
        sqlite3_close(database);//关闭数据库
        return result;
    }else {
        NSLog(@"添加行为数据失败:%s",errorMesg);
        sqlite3_close(database);//关闭数据库
        return result;
    }
    
}

@end