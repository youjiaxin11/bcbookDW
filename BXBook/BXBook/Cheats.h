//
//  Cheats.h
//  BXBook
//
//  Created by xiaoqi on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface Cheats : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象（已不用）
@property (assign, nonatomic) Task *task;
@property (assign, nonatomic) int helpId;
@property (assign, nonatomic) int index;//(已不用）
@property (assign, nonatomic) int flag1cheat;//(已不用）

-(void)btnClickVideo:(int)helpId;
-(void)playVideo;

@end