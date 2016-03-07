//
//  TaskDao.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskDao.h"

@implementation TaskDao

+ (Task*) findTaskByTaskId:(int)taskId{
    Task* task = [[Task alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM task WHERE taskId = '%d'", taskId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            task.taskId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                task.taskTitle = (NSString*)nil;
            }else {
                task.taskTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                task.taskMessage = (NSString*)nil;
            }else{
                task.taskMessage = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                task.taskEvaluation = (NSString*)nil;
            }else {
                task.taskEvaluation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            task.taskRank = sqlite3_column_int(statement, 4);
            task.helpId = sqlite3_column_int(statement, 5);
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                task.evaluation1 = (NSString*)nil;
            }else {
                task.evaluation1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            if ((char *)sqlite3_column_text(statement, 7) == nil) {
                task.evaluation2 = (NSString*)nil;
            }else {
                task.evaluation2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            }
            if ((char *)sqlite3_column_text(statement, 8) == nil) {
                task.evaluation3 = (NSString*)nil;
            }else {
                task.evaluation3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            }
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return task;
}

//在userTask表中通过taskId查找
+ (NSMutableArray*) findUserTaskByTaskId:(int)taskId{
    NSMutableArray* userTaskArray = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userTask WHERE taskId = '%d'", taskId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            UserTask* ul = [[UserTask alloc]init];
            ul.userTaskId = sqlite3_column_int(statement, 0);
            ul.userId = sqlite3_column_int(statement, 1);
            ul.taskId = sqlite3_column_int(statement, 2);
            ul.score = sqlite3_column_int(statement, 3);
            [userTaskArray addObject:ul];
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    
    return userTaskArray;

}

//在userTask表中通过userId查找
+ (NSMutableArray*) findUserTaskByUserId:(int)userId{
    NSMutableArray* userTaskArray = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userTask WHERE taskId = '%d'", userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            UserTask* ul = [[UserTask alloc]init];
            ul.userTaskId = sqlite3_column_int(statement, 0);
            ul.userId = sqlite3_column_int(statement, 1);
            ul.taskId = sqlite3_column_int(statement, 2);
            ul.score = sqlite3_column_int(statement, 3);
            [userTaskArray addObject:ul];
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    
    return userTaskArray;
}

+ (NSMutableArray*) findUserTaskByUserId:(int)userId Task:(int)taskId{
    NSMutableArray* userTaskArray = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM userTask WHERE userId = '%d' and taskId = '%d'", userId,taskId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            UserTask* ul = [[UserTask alloc]init];
            ul.userTaskId = sqlite3_column_int(statement, 0);
            ul.userId = sqlite3_column_int(statement, 1);
            ul.taskId = sqlite3_column_int(statement, 2);
            ul.score = sqlite3_column_int(statement, 3);
            [userTaskArray addObject:ul];
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    
    return userTaskArray;
}

@end