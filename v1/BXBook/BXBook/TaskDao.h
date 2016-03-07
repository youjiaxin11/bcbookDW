//
//  TaskDao.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "Task.h"
#import "UserTask.h"

@interface TaskDao : NSObject

+ (Task*) findTaskByTaskId:(int)taskId;

//在userTask表中通过taskId查找
+ (NSMutableArray*) findUserTaskByTaskId:(int)taskId;

//在userTask表中通过userId查找
+ (NSMutableArray*) findUserTaskByUserId:(int)userId;

//在userTask表中通过userId和taskId查找
+ (NSMutableArray*) findUserTaskByUserId:(int)userId Task:(int)taskId;
@end
