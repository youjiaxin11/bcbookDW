//
//  FamilyDinnerQuestion.h
//  BCBookDW
//
//  Created by ding on 16/2/29.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "FamilyDinner.h"

@interface FamilyDinnerQuestion : BaseControl{
@private
    int cheatQuestionJump;//记录跳转哪道题的通关秘籍
    int exitlinenine; //判断是否强行退出
}

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) int gameIdFamilyDinner;//关卡及难度数，1-12
@property(nonatomic,strong)NSMutableArray *questionsFamilyDinner;//用一个数组来保存当前关卡下的所有题目
@property (assign, nonatomic) int questionIndex;
@property (assign, nonatomic) int fanswerTotalNum1;
@property (assign, nonatomic)int fquestionRightNum11;
@property (assign, nonatomic)int fquestionRightNum12;
@property (assign, nonatomic)int fquestionRightNum13;
@property (assign, nonatomic)int fquestionRightNum14;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;

-(void)puzzleAnswer:(int)fanswerQuestionIndex;
    @end