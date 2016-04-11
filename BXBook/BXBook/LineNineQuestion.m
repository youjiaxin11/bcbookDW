//
//  LineNineQuestion.m
//  BCBookDW
//
//  Created by xiaoqi on 16/3/1.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "LineNineQuestion.h"
#import "Questions.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation LineNineQuestion

@synthesize
//questionsAllFromLineNine,//18道所有题
questionsLineNineQuestion,//当前关卡下的所有题目，本小游戏使用前面9道题目
gameIdLineNineQuestion,//当前关卡数
lineNineQuestionIndex;//小关


/*开发者在页面操作中，用这几个值*/
User *userLineNineQuestion;//当前登录用户
Questions *lineNineQuestion;//当前界面题目

static NSMutableArray *lineNineAnswerStateArray;//用一个可变数组保持答题情况
static int answerTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    userLineNineQuestion = self.user;
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLineNineQuestion.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"LineNineQuestion-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    

    
    if (answerTime == 0) {
        //开辟9个位置存放9道题的答题情况，初始化为NSNumber:0
        //    lineNineAnswerStateArray = [NSMutableArray arrayWithCapacity:9];
        NSNumber *num2NSNumber  = [NSNumber numberWithInteger:0];
        lineNineAnswerStateArray = [[NSMutableArray alloc]initWithObjects:num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,num2NSNumber,nil];
        answerTime++;
    }else{
        answerTime++;
    }
    //打印答题状态
    //枚举遍历，相当于java中的增强for循环
    NSLog(@"linenineQuestion更新前答题状态:");
    for (NSString *string in lineNineAnswerStateArray) {
        NSLog(@"%@,",string);
    }
    
    
    //    //获取所有题目
    //    questionsAll = [[NSMutableArray alloc]init];
    //    questionsAll = [QuestionsDao findAllQuestions];
    
    //    //筛选当前关卡下的题目
    //    questionsLineNineQuestion = [[NSMutableArray alloc]init];
    //    questionsLineNineQuestion = [QuestionsDao findQuestionsByGameChoiceId:gameIdLineNineQuestion ques:questionsAll];
    
    
    NSLog(@"linenineQuestion:当前登录用户：%@",userLineNineQuestion.loginName);
    NSLog(@"linenineQuestion:9道所有题目数量：%d", [questionsLineNineQuestion count]);
    
    //9道题中的第几题
    questionIndex = self.lineNineQuestionIndex;
    
    NSLog(@"linenineQuestion:当前关卡数：%d",gameIdLineNineQuestion);
    NSLog(@"linenineQuestion:目前答的是题目：%d",questionIndex);
    NSLog(@"linenineQuestion:此页面要显示的内容如下：");
    
    //从这9道题中抽取出所答题的内容
    lineNineQuestion = [questionsLineNineQuestion objectAtIndex:questionIndex];
    
    NSLog(@"linenineQuestion题干:%@",lineNineQuestion.question);//问题
    NSLog(@"linenineQuestion选项1:%@",lineNineQuestion.answer1);
    NSLog(@"linenineQuestion选项2:%@",lineNineQuestion.answer2);
    NSLog(@"linenineQuestion选项3:%@",lineNineQuestion.answer3);
    NSLog(@"linenineQuestion正确答案:%d",lineNineQuestion.answerRight);
    
    
    //判断选项个数，给前台赋值
    [_lineNineQuestion setText:lineNineQuestion.question];
    [_lineNineAnswer1 setTitle:lineNineQuestion.answer1 forState:UIControlStateNormal];
    [_lineNineAnswer2 setTitle:lineNineQuestion.answer2 forState:UIControlStateNormal];
    
    if (lineNineQuestion.answerNum == 2) {//当选项为两个时
        _lineNineAnswer3.hidden = true;
    }else{//当选项为三个时
        [_lineNineAnswer3 setTitle:lineNineQuestion.answer3 forState:UIControlStateNormal];
    }
}


//选的哪个选项
- (IBAction)answerEvaluation1:(id)sender {//选A
    answerQuestionIndex = 1;
    [self lineNineAnswer:answerQuestionIndex];
}

- (IBAction)answerEvaluation2:(id)sender {//选B
    answerQuestionIndex = 2;
    [self lineNineAnswer:answerQuestionIndex];
}

- (IBAction)answerEvaluation3:(id)sender {//选C
    answerQuestionIndex = 3;
    [self lineNineAnswer:answerQuestionIndex];
}

//点击选项后跳转到此函数中，判断对错
- (void)lineNineAnswer:(int)myAnswerQuestionIndex{
    
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLineNineQuestion.userId;
    behaviour.doWhat = @"游戏－答题";
    behaviour.doWhere = [[NSString alloc]initWithFormat:@"LineNineQuestion-(void)lineNineAnswer:(int)myAnswerQuestionIndex-题目id:%d",lineNineQuestion.questionId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    userLineNineQuestion.answerTimes++;//用户答题次数＋1
    lineNineQuestion.answerTimes++;//题目被答次数＋1
    
    if (lineNineQuestion.answerRight == myAnswerQuestionIndex) {
        [self updateAnswerStateArray];//修改答题状态属性
        NSLog(@"正确");
        
        
        userLineNineQuestion.answerRightTimes++;//用户答对次数＋1
        lineNineQuestion.rightTimes++;//题目正确次数＋1
        cheatQuestionJump = 1;//跳转到答对弹框
        
        [self prompt:@"恭喜你，答对啦！"];
    }else {
        NSLog(@"错误");
        [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
        cheatQuestionJump = 2;
    }
    
    //更新数据库
    [UserDao updateUser:userLineNineQuestion];
    [QuestionsDao updateQuestions:lineNineQuestion];
}

//修改答题状态属性
- (void)updateAnswerStateArray{
    //整型转化为NSNumber类型
    NSNumber *lineNineQuestion1Right  = [NSNumber numberWithInteger:2];
    NSNumber *lineNineQuestion2Right  = [NSNumber numberWithInteger:7];
    NSNumber *lineNineQuestion3Right  = [NSNumber numberWithInteger:6];
    NSNumber *lineNineQuestion4Right  = [NSNumber numberWithInteger:9];
    NSNumber *lineNineQuestion5Right  = [NSNumber numberWithInteger:5];
    NSNumber *lineNineQuestion6Right  = [NSNumber numberWithInteger:1];
    NSNumber *lineNineQuestion7Right  = [NSNumber numberWithInteger:4];
    NSNumber *lineNineQuestion8Right  = [NSNumber numberWithInteger:3];
    NSNumber *lineNineQuestion9Right  = [NSNumber numberWithInteger:8];
    switch (questionIndex) {
        case 0:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion1Right];//更新记录答题情况的数组
            break;
            
        case 1:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion2Right];//更新记录答题情况的数组
            break;
            
        case 2:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion3Right];//更新记录答题情况的数组
            break;
        case 3:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion4Right];//更新记录答题情况的数组
            break;
            
        case 4:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion5Right];//更新记录答题情况的数组
            break;
            
        case 5:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion6Right];//更新记录答题情况的数组
            break;
        case 6:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion7Right];//更新记录答题情况的数组
            break;
            
        case 7:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion8Right];//更新记录答题情况的数组
            break;
            
        case 8:
            [lineNineAnswerStateArray replaceObjectAtIndex:questionIndex withObject: lineNineQuestion9Right];//更新记录答题情况的数组
            break;
            
        default:
            break;
    }
    
    //打印答题状态
    NSLog(@"linenineQuestion更新后的答题状态");
    //枚举遍历，相当于java中的增强for循环
    for (NSString *string in lineNineAnswerStateArray) {
        NSLog(@"%@,",string);
    }
}

//提示框内容
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//提示框按钮跳转
{
    if(cheatQuestionJump == 1){//答对，返回LineNine并翻转拼图
        [self goBackLineNine:lineNineAnswerStateArray];
    }
    if(cheatQuestionJump ==2){//答错，跳到通关秘籍界面
        if(buttonIndex == 0){
            [self goBackLineNine:lineNineAnswerStateArray];
        }else{
            //跳转到通关秘籍
        }
    }
}

//答对，返回LineNine界面
- (void)goBackLineNine:(NSMutableArray*)myAnswerStateArray{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LineNine *lineNine = [mainStoryboard instantiateViewControllerWithIdentifier:@"LineNine"];
    lineNine.user = userLineNineQuestion;
    lineNine.lineNineRight = lineNineAnswerStateArray;
    lineNine.gameIdLineNine = gameIdLineNineQuestion;
    
    //所有题个数
    //NSLog(@"一共有%d道题:",[questionsAllFromLineNine count]);
    
    [lineNine setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:lineNine animated:YES completion:nil];
}

//- (void)clear{
//    answerQuestionTotalNum = 0;
//    question1Right = 0;
//    question2Right = 0;
//    question3Right = 0;
//    question4Right = 0;
//    question1time = 0;
//    question2time = 0;
//    question3time = 0;
//    question4time = 0;
//}

////跳到通关秘籍
//- (void)lineNineCheat{
//
//    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
//    cheat.user = userPuzzleQuestion;
//    cheat.game = gamePuzzleQuestion;
//    cheat.index=puzzleQuestionIndex;
//    cheat.flag1cheat=2;
//    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//    [self presentViewController:cheat animated:YES completion:nil];
//
//}
//
////直接跳转到通关秘籍
//- (IBAction)gotoPuzzleCheat:(id)sender {
//    [self lineNineCheat];
//}

//左滑退出
//- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
//{
//    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
//        exitlinenine = 1;
//        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
//    }
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLineNineQuestion.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"LineNineQuestion-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userLineNineQuestion;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userLineNineQuestion;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userLineNineQuestion;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userLineNineQuestion;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}


@end

