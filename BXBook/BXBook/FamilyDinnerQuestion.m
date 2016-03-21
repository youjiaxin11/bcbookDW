//
//  FamilyDinnerQuestion.m
//  BCBookDW
//
//  Created by ding on 16/2/29.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyDinnerQuestion.h"

@implementation FamilyDinnerQuestion
User *userFamilyDinnerQuestion;//当前登录用户
@synthesize
questionsFamilyDinner,//当前关卡下的所有题目,本小游戏使用中间4道题目
gameIdFamilyDinner;//关卡及难度数，1-12
static int familydinnerQuestionIndex;//记录答的是哪道题
int fanswerQuestionIndex;//记录答的选项
static int answerFamilyDinnerTotalNum1;//记录一共答对几道题
static int FamilyDinnerRightNum11;//记录答对了哪道题
static int FamilyDinnerRightNum12;//记录答对了哪道题
static int FamilyDinnerRightNum13;//记录答对了哪道题
static int FamilyDinnerRightNum14;//记录答对了哪道题
Questions *question1;
- (void)viewDidLoad {
    [super viewDidLoad];
    userFamilyDinnerQuestion = self.user;
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFamilyDinnerQuestion.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"FamilyDinnerQuestion-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    familydinnerQuestionIndex = self.questionIndex;
    FamilyDinnerRightNum11=self.fquestionRightNum11;
     FamilyDinnerRightNum12=self.fquestionRightNum12;
     FamilyDinnerRightNum13=self.fquestionRightNum13;
     FamilyDinnerRightNum14=self.fquestionRightNum14;
    answerFamilyDinnerTotalNum1=self.fanswerTotalNum1;
    question1=[questionsFamilyDinner objectAtIndex :familydinnerQuestionIndex];
         [_question setText:question1.question];
        [_answer1 setTitle:question1.answer1 forState:UIControlStateNormal];
        [_answer2 setTitle:question1.answer2 forState:UIControlStateNormal];
        NSLog(@"%d",question1.answerRight);
        NSLog(@"ID:%d",question1.questionId);
     NSLog(@"题号:%d",familydinnerQuestionIndex);
    NSLog(@"总数:%d",answerFamilyDinnerTotalNum1);
    if (question1.answerNum == 2) {//当选项为两个时
            _answer3.hidden = true;
        }else{//当选项为三个时
            [_answer3 setTitle:question1.answer3 forState:UIControlStateNormal];
        }
}
- (IBAction)fanswer1:(UIButton *)sender {
    fanswerQuestionIndex = 1;
    [self puzzleAnswer:fanswerQuestionIndex];}
- (IBAction)fanswer2:(UIButton *)sender {
    fanswerQuestionIndex = 2;
    [self puzzleAnswer:fanswerQuestionIndex];
}
- (IBAction)fanswer3:(UIButton *)sender {
    fanswerQuestionIndex = 3;
    [self puzzleAnswer:fanswerQuestionIndex];}

- (void)puzzleAnswer:(int)fanswerQuestionIndex{
    
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFamilyDinnerQuestion.userId;
    behaviour.doWhat = @"游戏－答题";
    behaviour.doWhere = [[NSString alloc]initWithFormat:@"FamilyDinnerQuestion-(void)puzzleAnswer:(int)fanswerQuestionIndex-题目id:%d",question1.questionId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    userFamilyDinnerQuestion.answerTimes ++;
    question1.answerTimes++;
    if (question1.questionId-1==familydinnerQuestionIndex&&question1.answerRight==fanswerQuestionIndex)
    {
        NSLog(@"总数1:%d",answerFamilyDinnerTotalNum1);
        NSLog(@"%d",question1.questionId);
        NSLog(@"%d",familydinnerQuestionIndex);
        NSLog(@"right:%d",question1.answerRight);
         NSLog(@"findex:%d",fanswerQuestionIndex);
        [self promptLine3:@"恭喜你，回答正确！"];
            if(familydinnerQuestionIndex==9) FamilyDinnerRightNum11=1;
            if(familydinnerQuestionIndex==10) FamilyDinnerRightNum12=1;
            if(familydinnerQuestionIndex==11) FamilyDinnerRightNum13=1;
            if(familydinnerQuestionIndex==12) FamilyDinnerRightNum14=1;
         answerFamilyDinnerTotalNum1++;
        
        userFamilyDinnerQuestion.answerRightTimes++;
        question1.rightTimes++;
    }
        else {
            [self promptLine3:@"很抱歉回答错误，请重新答题！"];
        familydinnerQuestionIndex=0;
        }
    [UserDao updateUser:userFamilyDinnerQuestion];
    [QuestionsDao updateQuestions:question1];
   
}
- (void)QuestionInterface1{//跳转回FamilyDinner界面
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FamilyDinner *familydinner = [mainStoryboard instantiateViewControllerWithIdentifier:@"FamilyDinner"];
   // if(answerFamilyDinnerTotalNum1==3)familydinnerQuestionIndex=0;
      NSLog(@"总数2:%d",answerFamilyDinnerTotalNum1);
    familydinner.user = userFamilyDinnerQuestion;
    familydinner.questionsFamilyDinner = questionsFamilyDinner;
    familydinner.gameIdFamilyDinner = gameIdFamilyDinner;
    familydinner.fanswerTotalNum=answerFamilyDinnerTotalNum1;
    familydinner.fquestionRightNum1=FamilyDinnerRightNum11;
    familydinner.fquestionRightNum2=FamilyDinnerRightNum12;
    familydinner.fquestionRightNum3=FamilyDinnerRightNum13;
    familydinner.fquestionRightNum4=FamilyDinnerRightNum14;
    familydinner.findex= familydinnerQuestionIndex;
    [familydinner setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:familydinner animated:YES completion:nil];

}
//出现在本页的所有弹框的具体属性设置
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self QuestionInterface1];    
}


@end
