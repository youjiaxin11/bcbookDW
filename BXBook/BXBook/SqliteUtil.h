//
//  SqliteUtil.h
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteUtil : NSObject

//获得数据库在沙盒中的路径
+ (NSString *)dataFilePath;

//打开数据库
+ (sqlite3*) openDatabase;

//首次运行时将数据库更新到沙盒中
+ (void)copySqliteToSandbox;

+ (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath;

@end
