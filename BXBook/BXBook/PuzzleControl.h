//
//  PuzzleControl.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "ShootControl.h"
#import "PuzzleQuestion.h"

@interface PuzzleControl : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
@property (assign, nonatomic) int answerTotalNum;
@property (assign, nonatomic)int puzzle1Right;//问题1的拼图向下，1为向上
@property (assign, nonatomic)int puzzle2Right;
@property (assign, nonatomic)int puzzle3Right;
@property (assign, nonatomic)int puzzle4Right;

@property (weak, nonatomic) IBOutlet UIButton *puzzle1;
@property (weak, nonatomic) IBOutlet UIButton *puzzle2;
@property (weak, nonatomic) IBOutlet UIButton *puzzle3;
@property (weak, nonatomic) IBOutlet UIButton *puzzle4;

@property (weak, nonatomic) IBOutlet UIButton *nextpageButton;
@property (strong, nonatomic) IBOutlet UILabel *goldenLbl;

@end