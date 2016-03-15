//
//  PuzzleControl.m
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "PuzzleControl.h"

@implementation PuzzleControl
@synthesize goldenLbl;

/*开发者在页面操作中，用这几个值*/
User *userPuzzle;//当前登录用户
Game *gamePuzzle;//当前游戏对象，存有所有题目及答案
static int answerPuzzleTotalNum;//记录一共答对几道题
static int puzzleQuestion1Right;//问题1的拼图向下，1为向上
static int puzzleQuestion2Right;
static int puzzleQuestion3Right;
static int puzzleQuestion4Right;

int puzzleCheatJump = 0;//记录是为答完题跳转，还是全答完跳转
int questionIndex = 0;//记录答的是哪道题
int exitpuzzle = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    userPuzzle = self.user;
    gamePuzzle = self.game;
    answerPuzzleTotalNum = self.answerTotalNum;
    puzzleQuestion1Right = self.puzzle1Right;
    puzzleQuestion2Right = self.puzzle2Right;
    puzzleQuestion3Right = self.puzzle3Right;
    puzzleQuestion4Right = self.puzzle4Right;
    NSLog(@"puzzle:当前登录用户：%@",userPuzzle.loginName);
    NSLog(@"puzzle:游戏表中的id：%d",gamePuzzle.gameId);
    NSLog(@"puzzle:此页面要显示的内容如下：");
    NSLog(@"puzzle helpId1：%d",gamePuzzle.puzzle.helpId1);
    NSLog(@"puzzle helpId2：%d",gamePuzzle.puzzle.helpId2);
    NSLog(@"puzzle helpId3：%d",gamePuzzle.puzzle.helpId3);
    NSLog(@"puzzle helpId4：%d",gamePuzzle.puzzle.helpId4);
    if (puzzleQuestion1Right == 1) {
        [self backgroundImageForCard1];
    }
    if (puzzleQuestion2Right == 1){
        [self backgroundImageForCard2];
    }
    if (puzzleQuestion3Right ==1){
        [self backgroundImageForCard3];
    }
    if (puzzleQuestion4Right == 1){
        [self backgroundImageForCard4];
    }
    [goldenLbl setText:[NSString stringWithFormat:@"游戏币：%d", userPuzzle.golden]];
}

- (IBAction)PuzzleQuestion1:(id)sender {//跳转到PuzzleQuestion界面上
    questionIndex = 1;
    [self QuestionInterface:questionIndex];
    
}

- (IBAction)PuzzleQuestion2:(id)sender {//跳转到PuzzleQuestion界面上
    questionIndex = 2;
    [self QuestionInterface:questionIndex];
    
}

- (IBAction)PuzzleQuestion3:(id)sender {//跳转到PuzzleQuestion界面上
    questionIndex = 3;
    [self QuestionInterface:questionIndex];
    
}

- (IBAction)PuzzleQuestion4:(id)sender {//跳转到PuzzleQuestion界面上
    questionIndex = 4;
    [self QuestionInterface:questionIndex];
    
}

- (void)QuestionInterface:(int)questionIndex{//跳转到PuzzleQuestion界面
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PuzzleQuestion *puzzlequestion = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleQuestion"];
    puzzlequestion.user = userPuzzle;
    puzzlequestion.game = gamePuzzle;
    puzzlequestion.questionIndex = questionIndex;
    [puzzlequestion setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:puzzlequestion animated:YES completion:nil];
}

//拼图翻转1
- (void)backgroundImageForCard1
{
    
    UIImage *buttonImage1 = [UIImage imageNamed:@"拼图1"];
    [self.puzzle1 setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    
}
//拼图翻转2
- (void)backgroundImageForCard2
{
    
    UIImage *buttonImage2 = [UIImage imageNamed:@"拼图2"];
    [self.puzzle2 setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
    
}
//拼图翻转3
- (void)backgroundImageForCard3
{
    
    UIImage *buttonImage3 = [UIImage imageNamed:@"拼图3"];
    [self.puzzle3 setBackgroundImage:buttonImage3 forState:UIControlStateNormal];
    
}
//拼图翻转4
- (void)backgroundImageForCard4
{
    
    UIImage *buttonImage4 = [UIImage imageNamed:@"拼图4"];
    [self.puzzle4 setBackgroundImage:buttonImage4 forState:UIControlStateNormal];
    
}


- (IBAction)next:(id)sender {
    [self nextPageJudgement];
}


//跳转到下一页判断
- (void)nextPageJudgement{
    if (answerPuzzleTotalNum < 4) {
        puzzleCheatJump = 3;
        [self promptNotFinish:@"你还有没答完的题哦！"];
    }
    if (answerPuzzleTotalNum == 4) {
        [self nextPage];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//提示框按钮跳转
{
    if (puzzleCheatJump ==3 && answerPuzzleTotalNum != 4){
        if(buttonIndex == 0){
            [self puzzleNotFinish];
        }
    }
    if (exitpuzzle == 1) {//如果强行退出
        if(buttonIndex==0){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userPuzzle;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
            puzzleQuestion1Right = 0;
            puzzleQuestion2Right = 0;
            puzzleQuestion3Right = 0;
            puzzleQuestion4Right = 0;
            
            answerPuzzleTotalNum = 0;//记录一共答对几道题
            
            puzzleCheatJump = 0;//记录是为答完题跳转，还是全答完跳转
            questionIndex = 0;//记录答的是哪道题
            
            PuzzleQuestion *puzzleQuestion = [[PuzzleQuestion alloc]init];
            [puzzleQuestion clear];

        }
    }
}


//从未答完提示框跳回题目
- (void)puzzleNotFinish{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PuzzleControl *puzzlecontrol = [mainStoryboard instantiateViewControllerWithIdentifier:@"Puzzle"];
    puzzlecontrol.user = userPuzzle;
    puzzlecontrol.game = gamePuzzle;
    puzzlecontrol.answerTotalNum = answerPuzzleTotalNum;
    puzzlecontrol.puzzle1Right = puzzleQuestion1Right;
    puzzlecontrol.puzzle2Right = puzzleQuestion2Right;
    puzzlecontrol.puzzle3Right = puzzleQuestion3Right;
    puzzlecontrol.puzzle4Right = puzzleQuestion4Right;
    [puzzlecontrol setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:puzzlecontrol animated:YES completion:nil];
}

//跳转到下一页
- (void)nextPage{
    if (gamePuzzle.gameId %2 == 1) {
        userPuzzle.golden++;
        NSLog(@"golden:%d",userPuzzle.golden);
    }else{
        userPuzzle.golden = userPuzzle.golden + 2;
        NSLog(@"golden:%d",userPuzzle.golden);
    }
    [UserDao updateUser:_user];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShootControl *shootcontrol = [mainStoryboard instantiateViewControllerWithIdentifier:@"Shoot"];
    shootcontrol.user = userPuzzle;
    shootcontrol.game = gamePuzzle;
    [shootcontrol setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:shootcontrol animated:YES completion:nil];

    
    puzzleQuestion1Right = 0;
    puzzleQuestion2Right = 0;
    puzzleQuestion3Right = 0;
    puzzleQuestion4Right = 0;
    
    answerPuzzleTotalNum = 0;//记录一共答对几道题
    
    puzzleCheatJump = 0;//记录是为答完题跳转，还是全答完跳转
    questionIndex = 0;//记录答的是哪道题
    
    PuzzleQuestion *puzzleQuestion = [[PuzzleQuestion alloc]init];
    [puzzleQuestion clear];
}

//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitpuzzle = 1;
        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    }
}

@end
