//
//  GameChoice.h
//  BXBook
//
//  Created by sunzhong on 15/7/8.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "BaseControl.h"
#import "LineControl.h"
#import "Information.h"
#import "LineNine.h"

@interface GameChoice : BaseControl
@property (assign, nonatomic) User* user;//当前登录用户
//@property (assign, nonatomic) int finishgameId2;//当前完成的游戏关卡号
@end