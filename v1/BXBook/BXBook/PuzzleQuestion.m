//
//  PuzzuleQuestion.m
//  BXBook
//
//  Created by xiaoqi on 15/8/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "PuzzleQuestion.h"
#import "PuzzleControl.h"

@implementation PuzzleQuestion

/*开发者在页面操作中，用这几个值*/
User *userPuzzleQuestion;//当前登录用户
Game *gamePuzzleQuestion;//当前游戏对象，存有所有题目及答案
int puzzleQuestionIndex;//记录答的是哪道题
int answerQuestionTotalNum;//记录一共答对几道题

int answerQuestionIndex = 0;//记录答的是哪个选项
int cheatQuestionJump = 0;//记录跳转那道题的通关秘籍
int question1Right = 0;//问题1的拼图向下，1为向上
int question2Right = 0;
int question3Right = 0;
int question4Right = 0;
int question1time = 0;
int question2time = 0;
int question3time = 0;
int question4time = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    userPuzzleQuestion = self.user;
    gamePuzzleQuestion = self.game;
    puzzleQuestionIndex = self.questionIndex;
    NSLog(@"puzzle:当前登录用户：%@",userPuzzleQuestion.loginName);
    NSLog(@"puzzle:游戏表中的id：%d",gamePuzzleQuestion.gameId);
    NSLog(@"puzzle:目前答的是题目：%d",puzzleQuestionIndex);
    NSLog(@"puzzle:此页面要显示的内容如下：");
    /*第一题*/
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.question1);//问题
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer11);//选项1
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer12);//选项2
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer13);//选项3
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer1Num);//选项个数
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer1Right);//正确选项序号
    /*第二题*/
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.question2);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer21);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer22);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer23);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer2Num);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer2Right);
    /*第三题*/
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.question3);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer31);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer32);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer33);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer3Num);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer3Right);
    /*第四题*/
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.question4);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer41);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer42);
    NSLog(@"puzzle:%@",gamePuzzleQuestion.puzzle.answer43);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer4Num);
    NSLog(@"puzzle:%d",gamePuzzleQuestion.puzzle.answer4Right);
    
    if (puzzleQuestionIndex == 1) {
        //判断选项个数，给前台赋值
        [_question setText:gamePuzzleQuestion.puzzle.question1];
        [_answer1 setTitle:gamePuzzleQuestion.puzzle.answer11 forState:UIControlStateNormal];
        [_answer2 setTitle:gamePuzzleQuestion.puzzle.answer12 forState:UIControlStateNormal];
        
        if (gamePuzzleQuestion.puzzle.answer1Num == 2) {//当选项为两个时
            _answer3.hidden = true;
        }else{//当选项为三个时
            [_answer3 setTitle:gamePuzzleQuestion.puzzle.answer13 forState:UIControlStateNormal];
        }
    }else if(puzzleQuestionIndex == 2){
        //判断选项个数，给前台赋值
        [_question setText:gamePuzzleQuestion.puzzle.question2];
        [_answer1 setTitle:gamePuzzleQuestion.puzzle.answer21 forState:UIControlStateNormal];
        [_answer2 setTitle:gamePuzzleQuestion.puzzle.answer22 forState:UIControlStateNormal];
        
        if (gamePuzzleQuestion.puzzle.answer2Num == 2) {//当选项为两个时
            _answer3.hidden = true;
        }else{//当选项为三个时
            [_answer3 setTitle:gamePuzzleQuestion.puzzle.answer23 forState:UIControlStateNormal];
        }
    }else if(puzzleQuestionIndex == 3){
        //判断选项个数，给前台赋值
        [_question setText:gamePuzzleQuestion.puzzle.question3];
        [_answer1 setTitle:gamePuzzleQuestion.puzzle.answer31 forState:UIControlStateNormal];
        [_answer2 setTitle:gamePuzzleQuestion.puzzle.answer32 forState:UIControlStateNormal];
        
        if (gamePuzzleQuestion.puzzle.answer3Num == 2) {//当选项为两个时
            _answer3.hidden = true;
        }else{//当选项为三个时
            [_answer3 setTitle:gamePuzzleQuestion.puzzle.answer33 forState:UIControlStateNormal];
        }
    }else if(puzzleQuestionIndex == 4){
        //判断选项个数，给前台赋值
        [_question setText:gamePuzzleQuestion.puzzle.question4];
        [_answer1 setTitle:gamePuzzleQuestion.puzzle.answer41 forState:UIControlStateNormal];
        [_answer2 setTitle:gamePuzzleQuestion.puzzle.answer42 forState:UIControlStateNormal];
        
        if (gamePuzzleQuestion.puzzle.answer4Num == 2) {//当选项为两个时
            _answer3.hidden = true;
        }else{//当选项为三个时
            [_answer3 setTitle:gamePuzzleQuestion.puzzle.answer43 forState:UIControlStateNormal];
        }
    }
}


//选的哪个选项
- (IBAction)answerEvaluation1:(id)sender {//选A
    answerQuestionIndex = 1;
    [self puzzleAnswer:answerQuestionIndex];
}

- (IBAction)answerEvaluation2:(id)sender {//选B
    answerQuestionIndex = 2;
    [self puzzleAnswer:answerQuestionIndex];
}

- (IBAction)answerEvaluation3:(id)sender {//选C
    answerQuestionIndex = 3;
    [self puzzleAnswer:answerQuestionIndex];
}


- (void)puzzleAnswer:(int)answerQuestionIndex{
    if (puzzleQuestionIndex == 1) {
        userPuzzleQuestion.answerTimes ++;
        gamePuzzleQuestion.puzzle.answerTimes1++;
        if (gamePuzzleQuestion.puzzle.answer1Right == answerQuestionIndex) {
            NSLog(@"正确1");
            userPuzzleQuestion.answerRightTimes++;
            gamePuzzleQuestion.puzzle.rightTimes1++;
            cheatQuestionJump = 1;
            //questionIndex = 1;
            question1Right = 1;
            question1time++;
            if (question1time == 1) {
                answerQuestionTotalNum++;
            }
            
            [self prompt:@"恭喜你，答对啦！"];
        }else {
            NSLog(@"错误1");
            [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
            cheatQuestionJump = 2;
        }
        [UserDao updateUser:userPuzzleQuestion];
        [GameDao updatePuzzle:gamePuzzleQuestion.puzzle];
    }else if(puzzleQuestionIndex ==2){
        userPuzzleQuestion.answerTimes ++;
        gamePuzzleQuestion.puzzle.answerTimes2++;
        if (gamePuzzleQuestion.puzzle.answer2Right == answerQuestionIndex) {
            NSLog(@"正确1");
            userPuzzleQuestion.answerRightTimes++;
            gamePuzzleQuestion.puzzle.rightTimes2++;
            cheatQuestionJump = 1;
            //questionIndex = 2;
            question2Right = 1;
            question2time++;
            if (question2time == 1) {
                answerQuestionTotalNum++;
            }
            [self prompt:@"恭喜你，答对啦！"];
        }else {
            NSLog(@"错误1");
            [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
            cheatQuestionJump = 2;
        }
        [UserDao updateUser:userPuzzleQuestion];
        [GameDao updatePuzzle:gamePuzzleQuestion.puzzle];
    }else if(puzzleQuestionIndex ==3){
        userPuzzleQuestion.answerTimes ++;
        gamePuzzleQuestion.puzzle.answerTimes3++;
        if (gamePuzzleQuestion.puzzle.answer3Right == answerQuestionIndex) {
            NSLog(@"正确1");
            userPuzzleQuestion.answerRightTimes++;
            gamePuzzleQuestion.puzzle.rightTimes3++;
            cheatQuestionJump = 1;
            //questionIndex = 3;
            question3Right = 1;
            question3time++;
            if (question3time == 1) {
                answerQuestionTotalNum++;
            }
            [self prompt:@"恭喜你，答对啦！"];
        }else {
            NSLog(@"错误1");
            [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
            cheatQuestionJump = 2;
        }
        [UserDao updateUser:userPuzzleQuestion];
        [GameDao updatePuzzle:gamePuzzleQuestion.puzzle];
    }else if(puzzleQuestionIndex == 4){
        userPuzzleQuestion.answerTimes ++;
        gamePuzzleQuestion.puzzle.answerTimes4++;
        if (gamePuzzleQuestion.puzzle.answer4Right == answerQuestionIndex) {
            NSLog(@"正确1");
            userPuzzleQuestion.answerRightTimes++;
            gamePuzzleQuestion.puzzle.rightTimes4++;
            cheatQuestionJump = 1;
            //questionIndex = 4;
            question4Right = 1;
            question4time++;
            if (question4time == 1) {
                answerQuestionTotalNum++;
            }
            [self prompt:@"恭喜你，答对啦！"];
        }else {
            NSLog(@"错误1");
            [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
            cheatQuestionJump = 2;
        }
        [UserDao updateUser:userPuzzleQuestion];
        [GameDao updatePuzzle:gamePuzzleQuestion.puzzle];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//提示框按钮跳转
{
    if(cheatQuestionJump == 1){//答对，拼图翻转
        [self goBackPuzzle:answerQuestionTotalNum:question1Right:question2Right:question3Right:question4Right];
    }
    if(cheatQuestionJump ==2){//答错，跳到通关秘籍界面
        if(buttonIndex == 0){
            [self puzzleCheat];
        }
    }
    //if (cheatJump ==3 && answerTotalNum != 4){
    //if(buttonIndex == 0){
    //[self puzzleNotFinish];
    //}
    //}
}

//答对，返回PuzzleControl界面
- (void)goBackPuzzle:(int)answerQuestionTotalNum:(int)question1Right:(int)question2Right:(int)question3Right:(int)question4Right{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PuzzleControl *puzzleControl = [mainStoryboard instantiateViewControllerWithIdentifier:@"Puzzle"];
    puzzleControl.user = userPuzzleQuestion;
    puzzleControl.game = gamePuzzleQuestion;
    puzzleControl.answerTotalNum = answerQuestionTotalNum;
    puzzleControl.puzzle1Right = question1Right;
    puzzleControl.puzzle2Right = question2Right;
    puzzleControl.puzzle3Right = question3Right;
    puzzleControl.puzzle4Right = question4Right;
    [puzzleControl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:puzzleControl animated:YES completion:nil];
}

- (void)clear{
    answerQuestionTotalNum = 0;
    question1Right = 0;
    question2Right = 0;
    question3Right = 0;
    question4Right = 0;
    question1time = 0;
    question2time = 0;
    question3time = 0;
    question4time = 0;
}

//跳到通关秘籍
- (void)puzzleCheat{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    cheat.user = userPuzzleQuestion;
    cheat.game = gamePuzzleQuestion;
    cheat.index=puzzleQuestionIndex;
    cheat.flag1cheat=2;
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//直接跳转到通关秘籍
- (IBAction)gotoPuzzleCheat:(id)sender {
    [self puzzleCheat];
}

@end
