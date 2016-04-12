//
//  TaskIntroduction.h
//  BXBook
//
//  Created by Jack on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "TaskDao.h"
#import "GameChoice.h"
#import "TaskInfo.h"

@interface TaskIntroduction : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) int taskChoiceId;//选择任务卡的id
@property (weak, nonatomic) IBOutlet UITextView *taskMessageText;
@property (weak, nonatomic) IBOutlet UIButton *goToTaskInfo;
@property (strong, nonatomic) IBOutlet UITextView *evaluateText;
@property (strong, nonatomic) CWStarRateView *starRateView;
@end