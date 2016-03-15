//
//  WorkDao.m
//  BXBook
//
//  Created by sunzhong on 15/8/19.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "WorkDao.h"
#import "SqliteUtil.h"

@implementation WorkDao

+ (Work*) decodeWork: (NSDictionary*) dic{
    Work* work = [[Work alloc] init];
    work.workId = [[dic objectForKey:@"workid"] integerValue];
    work.userId = [[dic objectForKey:@"userid"] integerValue];
    work.taskId = [[dic objectForKey:@"taskid"] integerValue];
    work.taskUrl = [dic objectForKey:@"taskUrl"];
    work.receivePraiseNum = [[dic objectForKey:@"receivePraiseNum"] integerValue];
    work.receiveCommentNum = [[dic objectForKey:@"receiveCommentNum"] integerValue];
    work.golden = [[dic objectForKey:@"golden"] integerValue];
    return work;
}

+ (NSMutableArray*) findWorkByUserId:(int)_userId{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM work WHERE userId = '%d'", _userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            Work* work = [[Work alloc]init];
            work.workId = sqlite3_column_int(statement, 0);
            work.userId = sqlite3_column_int(statement, 1);
            work.taskId = sqlite3_column_int(statement, 2);
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                work.taskUrl = (NSString*)nil;
            }else {
                work.taskUrl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            work.receivePraiseNum = sqlite3_column_int(statement, 4);
            work.receiveCommentNum = sqlite3_column_int(statement, 5);
            work.golden = sqlite3_column_int(statement, 6);
            if ((char *)sqlite3_column_text(statement, 7) == nil) {
                work.uploadTime = (NSString*)nil;
            }else {
                work.uploadTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            }
            work.score = sqlite3_column_int(statement, 8);
            work.location = sqlite3_column_int(statement, 9);
            [array addObject:work];
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;

}

+ (NSMutableArray*) findOnlineWorkByUserId:(int)_userId{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM work WHERE userId = '%d'", _userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            if (sqlite3_column_int(statement, 9) == 1) {
                Work* work = [[Work alloc]init];
                work.workId = sqlite3_column_int(statement, 0);
                work.userId = sqlite3_column_int(statement, 1);
                work.taskId = sqlite3_column_int(statement, 2);
                if ((char *)sqlite3_column_text(statement, 3) == nil) {
                    work.taskUrl = (NSString*)nil;
                }else {
                    work.taskUrl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                }
                work.receivePraiseNum = sqlite3_column_int(statement, 4);
                work.receiveCommentNum = sqlite3_column_int(statement, 5);
                work.golden = sqlite3_column_int(statement, 6);
                if ((char *)sqlite3_column_text(statement, 7) == nil) {
                    work.uploadTime = (NSString*)nil;
                }else {
                    work.uploadTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                }
                work.score = sqlite3_column_int(statement, 8);
                work.location = sqlite3_column_int(statement, 9);
                [array addObject:work];
            }
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;

}

+(int) insertWork:(int)_userId taskId:(int)_taskId taskUrl:(NSString*)_taskUrl recPN:(int)_recPN recCN:(int)_recCN golden:(int)_golden uplT:(NSString*)_uplT score:(int)_score loca:(int)_loca{
    sqlite3* database = [SqliteUtil openDatabase];
    
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@', '%@','%@', '%@', '%@', '%@','%@') VALUES ('%d', '%d', '%@', '%d','%d', '%d', '%@', '%d','%d')",
                      @"work", @"userId", @"taskId", @"taskUrl", @"receivePraiseNum",@"receiveCommentNum", @"golden", @"uploadTime", @"score", @"location" ,_userId, _taskId, _taskUrl, _recPN,_recCN,_golden,_uplT,_score,_loca];
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

@end
