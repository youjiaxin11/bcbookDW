//
//  LineNine.m
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "LineNine.h"
#import <math.h>
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation LineNine
@synthesize
questionsAll,
questionsLineNine,
gameIdLineNine;//当前关卡数

/*开发者在页面操作中，用这几个值*/
User *userLineNine;//当前登录用户
int exitlinenine = 0; //判断是否强行退出
int ifFinished = 0;//判断是否打完跳转到下一关，0为否，1为是

//static int lineNineQuestion1Right;//问题1的拼图向下，2为向上
//static int lineNineQuestion2Right;//问题2的拼图向下，7为向上
//static int lineNineQuestion3Right;//问题3的拼图向下，6为向上
//static int lineNineQuestion4Right;//问题4的拼图向下，9为向上
//static int lineNineQuestion5Right;//问题5的拼图向下，5为向上
//static int lineNineQuestion6Right;//问题6的拼图向下，1为向上
//static int lineNineQuestion7Right;//问题7的拼图向下，4为向上
//static int lineNineQuestion8Right;//问题8的拼图向下，3为向上
//static int lineNineQuestion9Right;//问题9的拼图向下，8为向上

//问题1的拼图向下，2为向上
//问题2的拼图向下，7为向上
//问题3的拼图向下，6为向上
//问题4的拼图向下，9为向上
//问题5的拼图向下，5为向上
//问题6的拼图向下，1为向上
//问题7的拼图向下，4为向上
//问题8的拼图向下，3为向上
//问题9的拼图向下，8为向上
static NSMutableArray *lineNineQuestionRight;
static int lineNineAnswerTimes;


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    userLineNine = self.user;
    

    //获取所有题目
    questionsAll = [[NSMutableArray alloc]init];
    questionsAll = [QuestionsDao findAllQuestions];
    
    //筛选当前关卡下的题目
    questionsLineNine = [[NSMutableArray alloc]init];
    questionsLineNine = [QuestionsDao findQuestionsByGameChoiceId:gameIdLineNine ques:questionsAll];
    
    //每关一共18个题目，9个九宫格，4个团圆饭，5个赛龙舟
    //因此questionsLineNine里面，有18个题，前9个用在第一关，中间四个用在第二关，最后5个用在第三关
    
    NSLog(@"linenine:当前登录用户：%@",userLineNine.loginName);
    NSLog(@"linenine:关卡数：%d",gameIdLineNine);
    NSLog(@"linenine:所有题目数量：%d", [questionsLineNine count]);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLineNine.userId;
    behaviour.doWhat = @"浏览－游戏九宫格";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"LineNine-(void)viewDidLoad-关卡id:%d", gameIdLineNine];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    //------------------------------------------------------------------------------------
    
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
    
    if (lineNineAnswerTimes != 0){
        //判断拼图是否翻转
        lineNineQuestionRight = self.lineNineRight;
        int lineNineQuestionNum = [lineNineQuestionRight count];
        //打印答题情况
        for (NSString *string in lineNineQuestionRight) {
            NSLog(@"答题情况%@,",string);
        }
        int circleNum = 0;
        int num1 = 0;
        int num2 = 0;
        int num3 = 0;
        
        for (int i = 0; i < lineNineQuestionNum-2; i++) {
            num1 = [([lineNineQuestionRight objectAtIndex:i]) intValue];
            for (int j = i+1; j < lineNineQuestionNum-1; j++) {
                num2 = [([lineNineQuestionRight objectAtIndex:j]) intValue];
                for (int k = j+1; k < lineNineQuestionNum; k++) {
                    num3 = [([lineNineQuestionRight objectAtIndex:k]) intValue];
                    
                    if ((num1 + num2 + num3 == 15)&&(num1 * num2 * num3 != 0)){
                        //                        for (int allTurnBack = 1; allTurnBack <= [lineNineQuestionRight count]; allTurnBack++) {
                        //                            [self prompt:@"恭喜你，连成一线！查看完整拼图"]; //提示已经可以看完整拼图
                        //                            [self backgroundImageForCard : allTurnBack];
                        //                        }
                        NSLog(@"相加等于15的三个数：%d %d %d",num1,num2,num3);
                        ifFinished = 1;//答题完毕，可以跳转到下一关
                        break;
                    }
                    circleNum++;
                }
            }
        }
        
        /*
         //在长度为9的一维数组中遍历三个数字为一组的所有循环次数
         //计算所有组合的个数:C(9,3)
         int numerator = lineNineQuestionNum;//分子
         double denominator = sqrt(lineNineQuestionNum);//分母
         int numeratorMultiplication = 1;//分子相乘结果
         double denominatorMultiplication = 1;//分母相乘结果
         
         for (int i = denominator; i > 0; i--) {
         numeratorMultiplication *= numerator;
         numerator = numerator - 1;
         denominatorMultiplication *= denominator;
         denominator = denominator - 1;
         }
         double allCircleNum = numeratorMultiplication/denominatorMultiplication;
         */
        
        //翻各自的拼图
        //if (circleNum == allCircleNum){
        if ([lineNineQuestionRight objectAtIndex:0] == lineNineQuestion1Right) {
            [self backgroundImageForCard : 1];
        }
        if ([lineNineQuestionRight objectAtIndex:1] == lineNineQuestion2Right) {
            [self backgroundImageForCard : 2];
        }
        if ([lineNineQuestionRight objectAtIndex:2] == lineNineQuestion3Right) {
            [self backgroundImageForCard : 3];
        }
        if ([lineNineQuestionRight objectAtIndex:3] == lineNineQuestion4Right) {
            [self backgroundImageForCard : 4];
        }
        if ([lineNineQuestionRight objectAtIndex:4] == lineNineQuestion5Right) {
            [self backgroundImageForCard : 5];
        }
        if ([lineNineQuestionRight objectAtIndex:5] == lineNineQuestion6Right) {
            [self backgroundImageForCard : 6];
        }
        if ([lineNineQuestionRight objectAtIndex:6] == lineNineQuestion7Right) {
            [self backgroundImageForCard : 7];
        }
        if ([lineNineQuestionRight objectAtIndex:7] == lineNineQuestion8Right) {
            [self backgroundImageForCard : 8];
        }
        if ([lineNineQuestionRight objectAtIndex:8] == lineNineQuestion9Right) {
            [self backgroundImageForCard : 9];
        }
        if (ifFinished == 1){
           // [self createSelfPrompt:@"恭喜你，连成一线！查看完整拼图" image:[UIImage imageNamed:@"happy.jpg"]];
            [self prompt:@"恭喜你，连成一线！查看完整拼图"]; //提示已经可以看完整拼图
        }
        //}
    }else{
        NSLog(@"第一次执行LineNine，不进行翻转！");
    }
    lineNineAnswerTimes++;//didload之行次数＋1
}

//拼图翻转
- (void)backgroundImageForCard:(int) num
{
    
    NSString *whichPuzzle = @"拼图-";
    //把参数num转化为NSString类型，以便字符串拼接
    NSString *stringNum = [NSString stringWithFormat:@"%d",num];
    
    //字符串拼接————翻转拼图的名字
    whichPuzzle = [whichPuzzle stringByAppendingString:stringNum];
    NSLog(@"翻哪张拼图:%@",whichPuzzle);
    
    //判断哪个拼图将进行翻转，并将其翻转
    UIImage *buttonImage = [UIImage imageNamed:whichPuzzle];
    switch (num) {
        case 1:
            [self.lineNine1 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 2:
            [self.lineNine2 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 3:
            [self.lineNine3 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 4:
            [self.lineNine4 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 5:
            [self.lineNine5 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 6:
            [self.lineNine6 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 7:
            [self.lineNine7 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 8:
            [self.lineNine8 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
        case 9:
            [self.lineNine9 setBackgroundImage:buttonImage forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
}

//点击按钮，跳转到相应问题下
- (IBAction)LineNineQuestion1:(id)sender {
    questionIndex = 1;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion2:(id)sender {
    questionIndex = 2;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion3:(id)sender {
    questionIndex = 3;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion4:(id)sender {
    questionIndex = 4;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion5:(id)sender {
    questionIndex = 5;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion6:(id)sender {
    questionIndex = 6;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion7:(id)sender {
    questionIndex = 7;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion8:(id)sender {
    questionIndex = 8;
    [self QuestionInterface:questionIndex];
}

- (IBAction)LineNineQuestion9:(id)sender {
    questionIndex = 9;
    [self QuestionInterface:questionIndex];
}

//跳转到LineNineQuestion界面
- (void)QuestionInterface:(int)questionIndex{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LineNineQuestion *lineNineQuestion = [mainStoryboard instantiateViewControllerWithIdentifier:@"LineNineQuestion"];
    lineNineQuestion.user = userLineNine;
    //lineNineQuestion.questionsAllFromLineNine = questionsAll;
    
    //用eightLineNineQuestion保存前9道题
    NSArray *onlyLineNineQuestion = [questionsLineNine subarrayWithRange:NSMakeRange(0, 9)];
    //传给LineNineQuestion
    lineNineQuestion.questionsLineNineQuestion = onlyLineNineQuestion;//只有所有LineNine的题
    lineNineQuestion.gameIdLineNineQuestion = gameIdLineNine;//关卡数
    lineNineQuestion.lineNineQuestionIndex = questionIndex-1;//选择的小关卡
    
    [lineNineQuestion setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:lineNineQuestion animated:YES completion:nil];
    
}

//跳转到下一页
-(void)nextpage1{

    if(gameIdLineNine%2==0)userLineNine.golden=userLineNine.golden+1;
    if(gameIdLineNine%2==1) userLineNine.golden=userLineNine.golden+1;
    [UserDao updateUser:userLineNine];

    //
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FamilyDinner *famliydinner = [mainStoryboard instantiateViewControllerWithIdentifier:@"FamilyDinner"];
    famliydinner.user = userLineNine;
    famliydinner.questionsFamilyDinner = questionsLineNine;
    famliydinner.gameIdFamilyDinner = gameIdLineNine;
    [famliydinner setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:famliydinner animated:YES completion:nil];
}

//跳转到下一题
- (IBAction)gotoFamilyDinner:(UIButton *)sender {
    
    if (ifFinished == 1){//答完题
        [self clearLineNineStateArray];//答题情况还原为0
        ifFinished = 0;//退出前把是否可以跳到下一关的标志清零
        [self nextpage1];
    }else{
        [self promptNotFinish:@"你还有没答完的题哦！"];
    }
    
    
    //第三步：更新数据库信息
    //更新用户信息
    //更新question表，所有题目的正确率等信息
}

- (void)clearLineNineStateArray{
    //开辟9个位置存放9道题的答题情况，初始化为NSNumber:0
    //    lineNineAnswerStateArray = [NSMutableArray arrayWithCapacity:9];
    NSNumber *num2NSNumber  = [NSNumber numberWithInteger:0];
    for (int i = 0; i < [lineNineQuestionRight count]; i++) {
        [lineNineQuestionRight replaceObjectAtIndex:i withObject: num2NSNumber];
    }
    
    //打印清零结果
    for (NSString *string in lineNineQuestionRight) {
        NSLog(@"%@,",string);
    }
    
}

//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{

    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitlinenine = 1;
       // [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
        [self createSelfPrompt2:@"退出游戏将会失去本关的游戏币哟！" image:[UIImage imageNamed:@"sad.jpg"]];
    }
}

//从未答完提示框跳回题目
- (void)notFinishedAndGoBack{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LineNine *lineNine = [mainStoryboard instantiateViewControllerWithIdentifier:@"LineNine"];
    lineNine.user = userLineNine;
    lineNine.lineNineRight = lineNineQuestionRight;
    lineNine.gameIdLineNine = gameIdLineNine;
    
    //所有题个数
    //NSLog(@"一共有%d道题:",[questionsAllFromLineNine count]);
    
    [lineNine setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:lineNine animated:YES completion:nil];
}



- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
     {
       if (exitlinenine == 1){//如果强行退出
            //记录行为数据
            NSString* timeNow = [TimeUtil getTimeNow];
            Behaviour *behaviour = [[Behaviour alloc]init];
            behaviour.userId = userLineNine.userId;
            behaviour.doWhat = @"游戏－退出";
            behaviour.doWhere = @"LineNine-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex";
            behaviour.doWhen = timeNow;
            [BehaviourDao addBehaviour:behaviour];
            
            [self clearLineNineStateArray];//退出前把答题情况清零
            ifFinished = 0;//退出前把是否可以跳到下一关的标志清零
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userLineNine;;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
           exitlinenine = 0;
       }else{
           for (int allTurnBack = 1; allTurnBack <= [lineNineQuestionRight count]; allTurnBack++) {
               [self backgroundImageForCard : allTurnBack];
           }
           

       }
    }else if (buttonIndex == 1){
         [alertView close];
     }
    
}
    

//出现在本页的所有弹框的具体属性设置
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    

    if(buttonIndex==0)
    {

        
        if (exitlinenine == 1){//如果强行退出
            //记录行为数据
            NSString* timeNow = [TimeUtil getTimeNow];
            Behaviour *behaviour = [[Behaviour alloc]init];
            behaviour.userId = userLineNine.userId;
            behaviour.doWhat = @"游戏－退出";
            behaviour.doWhere = @"LineNine-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex";
            behaviour.doWhen = timeNow;
            [BehaviourDao addBehaviour:behaviour];
            
            [self clearLineNineStateArray];//退出前把答题情况清零
            ifFinished = 0;//退出前把是否可以跳到下一关的标志清零
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userLineNine;;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
            exitlinenine = 0;
        }else{
            for (int allTurnBack = 1; allTurnBack <= [lineNineQuestionRight count]; allTurnBack++) {
                [self backgroundImageForCard : allTurnBack];
            }
            
            
        }
    }
//    else if (buttonIndex == 1){
//       // [alertView ];
//    }
    

}
- (IBAction)goBack:(id)sender {
    exitlinenine = 1;
    //[self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    [self createSelfPrompt2:@"退出游戏将会失去本关的游戏币哟！" image:[UIImage imageNamed:@"sad.jpg"]];
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
    behaviour.userId = userLineNine.userId;
    behaviour.doWhat = @"浏览－测拉";
    behaviour.doWhere = @"LineNine-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userLineNine;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userLineNine;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userLineNine;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userLineNine;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}


@end
