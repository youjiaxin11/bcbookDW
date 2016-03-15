//
//  PuzzleQuestion.h
//  BXBook
//
//  Created by xiaoqi on 15/8/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "Cheats.h"

@interface PuzzleQuestion : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
@property (assign, nonatomic) int questionIndex;

@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;

- (void)clear;

@end
