//
//  LineNineQuestion.h
//  BCBookDW
//
//  Created by xiaoqi on 16/3/1.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "LineNine.h"

@interface LineNineQuestion : BaseControl{
@private
    int questionIndex;//记录答的是哪道题
    //int answerQuestionTotalNum;//记录一共答对几道题
    
    int answerQuestionIndex;//记录答的是哪个选项
    int cheatQuestionJump;//记录跳转哪道题的通关秘籍
    
    int exitlinenine; //判断是否强行退出
    
}
@property (assign, nonatomic) int gameIdLineNineQuestion;//关卡及难度数，1-12
@property (assign, nonatomic) User *user;//当前登录用户
//@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
//@property(nonatomic,strong)NSMutableArray *questionsAllFromLineNine;//用一个数组来保存所有的题目
@property(nonatomic,strong)NSArray *questionsLineNineQuestion;//用一个数组来保存当前关卡下的所有题目

@property (assign, nonatomic) int lineNineQuestionIndex;//关卡数

@property (weak, nonatomic) IBOutlet UILabel *lineNineQuestion;
@property (weak, nonatomic) IBOutlet UIButton *lineNineAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *lineNineAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *lineNineAnswer3;


//- (void)clear;

@end
