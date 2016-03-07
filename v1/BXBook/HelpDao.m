//
//  HelpDao.m
//  BXBook
//
//  Created by sunzhong on 15/9/2.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "HelpDao.h"
#import "SqliteUtil.h"

@implementation HelpDao

//查询所有通关秘籍
+ (NSMutableArray*) getAllHelps{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM help ORDER BY helpId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Help* help = [[Help alloc]init];
            help.helpId = sqlite3_column_int(statement, 0);
            help.helpType = sqlite3_column_int(statement, 1);
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                help.helpUrl = (NSString*)nil;
            }else {
                help.helpUrl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            help.viewTimes = sqlite3_column_int(statement, 3);
            [array addObject:help];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}

+ (int) updateHelpViewTimes:(Help*)help{
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE help SET viewTimes = '%d' WHERE helpId = '%d'", help.viewTimes, help.helpId];
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


//根据helpId查询通关秘籍
+ (Help*) findHelpByHelpId:(int)helpId{
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM help WHERE helpId = '%d'", helpId];
    sqlite3_stmt *statement;
    Help* help = [[Help alloc]init];
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        if (sqlite3_step(statement) == SQLITE_ROW) {
            help.helpId = sqlite3_column_int(statement, 0);
            help.helpType = sqlite3_column_int(statement, 1);
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                help.helpUrl = (NSString*)nil;
            }else {
                help.helpUrl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return help;
}
@end

