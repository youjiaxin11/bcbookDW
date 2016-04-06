//
//  TaskChoice.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "TaskIntroduction.h"
#import "GameChoice.h"

@interface TaskChoice : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UIButton *button;
//@property (assign, nonatomic) int finishgameId;//当前完成的游戏关卡号
@end