//
//  LineNine.h
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "FamilyDinner.h"
#import "LineNineQuestion.h"

@interface LineNine : BaseControl{
@private
    //记录答的是哪道题
    int questionIndex;
}

@property (assign, nonatomic) int gameIdLineNine;//关卡及难度数，1-12
@property (assign, nonatomic) User *user;//当前登录用户
//@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
@property(nonatomic,strong)NSMutableArray *questionsAll;//用一个数组来保存所有的题目
@property(nonatomic,strong)NSMutableArray *questionsLineNine;//用一个数组来保存当前关卡下的所有题目

//提交按钮
@property (strong, nonatomic) IBOutlet UIButton *submitLineNineBtn;

//LineNine上的9个按钮
@property (weak, nonatomic) IBOutlet UIButton *lineNine1;
@property (weak, nonatomic) IBOutlet UIButton *lineNine2;
@property (weak, nonatomic) IBOutlet UIButton *lineNine3;
@property (weak, nonatomic) IBOutlet UIButton *lineNine4;
@property (weak, nonatomic) IBOutlet UIButton *lineNine5;
@property (weak, nonatomic) IBOutlet UIButton *lineNine6;
@property (weak, nonatomic) IBOutlet UIButton *lineNine7;
@property (weak, nonatomic) IBOutlet UIButton *lineNine8;
@property (weak, nonatomic) IBOutlet UIButton *lineNine9;

//用一个可变数组保存每个问题的答题对错情况
@property (assign, nonatomic)NSMutableArray *lineNineRight;

@end