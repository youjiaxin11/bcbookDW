//
//  NoteDao.m
//  BCBookDW
//
//  Created by sunzhong on 16/4/13.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "NoteDao.h"

@implementation NoteDao

//添加一条笔记
+ (int) addNote:(Note*)note{
    sqlite3* database = [SqliteUtil openDatabase];
    
    NSString *sql1 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%d', '%@', '%@')",
                      @"note", @"userId", @"note", @"updateTime" ,note.userId, note.note, note.updateTime];
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

    return 1;
}


//更新一条笔记
+ (int) updateNote:(Note*)note{
    int success = 1;
    NSString *query = [NSString stringWithFormat:@"UPDATE note SET note = '%@', updateTime = '%@' WHERE userId = '%d'", note.note, note.updateTime, note.userId];
    
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        NSLog(@"noteUpdate!!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

//通过userid读取一条笔记
+ (Note*) getNoteFromUserId:(int)userId{
    Note* note = [[Note alloc]init];

    NSString *query = [NSString stringWithFormat:@"SELECT * FROM note WHERE userId = '%d'", userId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {//用户名存在
            note.noteId = sqlite3_column_int(statement, 0);
            note.userId = sqlite3_column_int(statement, 1);
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                note.note = (NSString*)nil;
            }else {
                note.note = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                note.updateTime = (NSString*)nil;
            }else{
                note.updateTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
        }else {
            note = nil;
        }
        
    }
    
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库

    return note;
}



@end
