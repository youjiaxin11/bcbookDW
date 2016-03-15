//
//  SqliteUtil.m
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "SqliteUtil.h"

@implementation SqliteUtil

+ (void)copySqliteToSandbox{
    //文件类型
    NSString * docPath = [[NSBundle mainBundle] pathForResource:@"bxbookdw" ofType:@"sqlite"];
    NSLog(@"ssssss:%@",docPath);

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    BOOL filesPresent = [self copyMissingFile:docPath toPath:documentsDirectory];
    if (filesPresent) {
        NSLog(@"OK");
    }
    else
    {
        NSLog(@"NO");
    }
    

}

/**
 *    @brief    把Resource文件夹下的save1.dat拷贝到沙盒
 *
 *    @param     sourcePath     Resource文件路径
 *    @param     toPath     把文件拷贝到XXX文件夹
 *
 *    @return    BOOL
 */
+ (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}

+ (NSString*)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"bxbookdw.sqlite"]);
    return [documentsDirectory stringByAppendingPathComponent:@"bxbookdw.sqlite"];
}

+ (sqlite3*) openDatabase {
    sqlite3 *database = nil;
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
    }
    NSLog(@"打开数据库成功");
    return database;
}

@end
