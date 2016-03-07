//
//  UserTask.h
//  BXBook
//
//  Created by sunzhong on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTask : NSObject

@property int userTaskId;// 主键自增长
@property int userId;//用户id
@property int taskId;//任务id
@property int score;//任务得分


@end
