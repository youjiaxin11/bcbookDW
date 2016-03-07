//
//  GameTaskData.h
//  BXBook
//
//  Created by sunzhong on 15/9/2.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"


@interface GameTaskData : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户


//
//计算任务平均得分
-(NSMutableArray*) computeTaskAverageScore;
//计算任务完成人次
-(NSMutableArray*) computeTaskDonePeople;

@property (strong, nonatomic) UITableView *DataTable;

@end