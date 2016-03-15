//
//  Task.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property int taskId;// 主键自增长
@property NSString* taskTitle;//任务标题
@property NSString* taskMessage;//任务简介
@property NSString* taskEvaluation;//评价标准
@property int taskRank;//任务等级
@property int helpId;//通关秘籍
@property NSString*  evaluation1;//3星
@property NSString*  evaluation2;//4星
@property NSString*  evaluation3;//5星

@end