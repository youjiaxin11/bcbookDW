//
//  Comment.h
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface Comment : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Task *task;//当前任务卡

@end
