//
//  FamilyDinnerQuestion.m
//  BCBookDW
//
//  Created by ding on 16/2/29.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyDinnerQuestion.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

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
    //判断是否出现通关秘籍按钮
    if (question1.helpId != 0){//有通关秘籍则在界面上显示通关秘籍按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 60, 100, 100);
        
        //设置button标题及其颜色
        [btn setTitle:@"通关秘籍" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        //设置button填充图片
        [btn setBackgroundImage:[UIImage imageNamed:@"buttonBkg.png"] forState:UIControlStateNormal];
        
        //按下按钮，并且手指离开屏幕的时候触发这个事件，跟web中的click事件一样。触发了这个事件以后，执行butClick:这个方法，addTarget:self 的意思是说，这个方法在本类中也可以传入其他类的指针
        [btn addTarget:self action:@selector(gotoLineNineCheat) forControlEvents:UIControlEventTouchUpInside];
        
        //显示控件
        [self.view addSubview:btn];
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
    //    if (question1.questionId-1==familydinnerQuestionIndex&&question1.answerRight==fanswerQuestionIndex)
    if (question1.answerRight==fanswerQuestionIndex)
    {
        NSLog(@"总数1:%d",answerFamilyDinnerTotalNum1);
        NSLog(@"%d",question1.questionId);
        NSLog(@"%d",familydinnerQuestionIndex);
        NSLog(@"right:%d",question1.answerRight);
        NSLog(@"findex:%d",fanswerQuestionIndex);
         [self createSelfPrompt:@"恭喜你，答对啦！" image:[UIImage imageNamed:@"happy.jpg"]];
        cheatQuestionJump = 1;
        if(familydinnerQuestionIndex==9) FamilyDinnerRightNum11=1;
        if(familydinnerQuestionIndex==10) FamilyDinnerRightNum12=1;
        if(familydinnerQuestionIndex==11) FamilyDinnerRightNum13=1;
        if(familydinnerQuestionIndex==12) FamilyDinnerRightNum14=1;
        answerFamilyDinnerTotalNum1++;
        
        userFamilyDinnerQuestion.answerRightTimes++;
        question1.rightTimes++;
    }
    else {
        if (question1.helpId == 0) {
            [self createSelfPrompt:@"很抱歉，回答错误，请重新答题！" image:[UIImage imageNamed:@"sad.jpg"]];
        }else{
            [self createSelfPrompt3:@"很抱歉，答错了！去看看通关秘籍吧！" image:[UIImage imageNamed:@"sad.jpg"]];
        }
        cheatQuestionJump = 2;
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

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(cheatQuestionJump == 1){//答对
        [self QuestionInterface1];
    }
    if(cheatQuestionJump ==2){//答错，跳到通关秘籍界面
        if(buttonIndex == 0){
            [self QuestionInterface1];
        }else{
            //跳转到通关秘籍
            [self familyDinnerCheat];
        }
    }
    
}

//跳到通关秘籍
- (void)familyDinnerCheat{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    
    cheat.user = userFamilyDinnerQuestion;
    cheat.helpId = question1.helpId;
    
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//直接跳转到通关秘籍
- (IBAction)gotoLineNineCheat:(id)sender {
    [self familyDinnerCheat];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFamilyDinnerQuestion.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"FamilyDinnerQuestion-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userFamilyDinnerQuestion;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userFamilyDinnerQuestion;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userFamilyDinnerQuestion;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userFamilyDinnerQuestion;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}


@end
