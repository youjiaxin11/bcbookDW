//
//  TaskInfo.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "Activity.h"
#import "TaskDao.h"
#import "GameChoice.h"


@interface TaskInfo : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) int taskChoiceId;//选择任务卡的id
@property (strong, nonatomic) CWStarRateView *starRateView;
- (IBAction)buttoncheat:(UIButton *)sender;


@end