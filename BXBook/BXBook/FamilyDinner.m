//
//  FamilyDinner.m
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "FamilyDinner.h"


@implementation FamilyDinner
@synthesize
questionsFamilyDinner,//当前关卡下的所有题目,本小游戏使用中间4道题目
gameIdFamilyDinner;//当前关卡数

/*开发者在页面操作中，用这几个值*/
User *userFamilyDinner;//当前登录用户
int exitfamilydinner = 0; //判断是否强行退出
Questions *question;
static int answerFamilyDinnerTotalNum;//记录一共答对几道题
static int FamilyDinnerRightNum1;//记录答对了哪道题
static int FamilyDinnerRightNum2;//记录答对了哪道题
static int FamilyDinnerRightNum3;//记录答对了哪道题
static int FamilyDinnerRightNum4;//记录答对了哪道题
static int fquestionIndex;//记录答的是哪道题
int exitFamilyDinner = 0;
int jump1;
int jump2;
- (void)viewDidLoad {
    [super viewDidLoad];
    userFamilyDinner = self.user;

    
    answerFamilyDinnerTotalNum=self.fanswerTotalNum;
    FamilyDinnerRightNum1=self.fquestionRightNum1;
    FamilyDinnerRightNum2=self.fquestionRightNum2;
     FamilyDinnerRightNum3=self.fquestionRightNum3;
     FamilyDinnerRightNum4=self.fquestionRightNum4;
    fquestionIndex=self.findex;
    NSLog(@"familyDinner:所有题目数量：%d", [questionsFamilyDinner count]);
   NSLog(@"答对题数：%d", answerFamilyDinnerTotalNum);
       NSLog(@"答了哪道题：%d",fquestionIndex);
    
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userFamilyDinner.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"FamilyDinner-(void)viewDidLoad-关卡id:%d", gameIdFamilyDinner];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    
    if (FamilyDinnerRightNum1==1||FamilyDinnerRightNum2==1||FamilyDinnerRightNum3==1||FamilyDinnerRightNum4==1){
       question=[questionsFamilyDinner objectAtIndex :fquestionIndex];
       
     
    }
    if( FamilyDinnerRightNum1 == 1)
    {[self backgroundImage1];}
     if ( FamilyDinnerRightNum2 == 1) {
       [self backgroundImage2];
    }
    if (FamilyDinnerRightNum3 == 1) {
     [self backgroundImage3];
    }
    if (FamilyDinnerRightNum4  == 1) {
      [self backgroundImage4];
    }
    if(answerFamilyDinnerTotalNum==3)
    {
        [self promptLine4:@"恭喜你，已经具有进入下一关资格！请选择继续邀请成员或者直接开启下一关"];jump1=1;
        
    }
    if(answerFamilyDinnerTotalNum==4)
    {
        [self promptLine3:@"恭喜你，闯关成功！"];jump2=1;
    }
    //第一步：用户答题次数和题目被答次数加1
    
    //第二步：判断答案正误
    //if(正确)
    //计算用户得到的金币数
    //用户答题正确次数和该题目被正确答题次数加1
    //...各种弹框及跳转
    
    //   else if(未答题)
    //   else if(答题错误)
    
    //第三步：更新数据库信息
    //更新用户信息
    //更新question表，所有题目的正确率等信息
}
//出现在本页的所有弹框的具体属性设置
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(jump1==1){
        if(buttonIndex==0); else if(buttonIndex==1) [self nextpage1];}
    if(jump2==1) [self nextpage1];
    if (exitfamilydinner == 1) {//如果强行退出
        if(buttonIndex==0){
            //记录行为数据
            NSString* timeNow = [TimeUtil getTimeNow];
            Behaviour *behaviour = [[Behaviour alloc]init];
            behaviour.userId = userFamilyDinner.userId;
            behaviour.doWhat = @"游戏－退出";
            behaviour.doWhere = @"FamilyDinner-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex";
            behaviour.doWhen = timeNow;
            [BehaviourDao addBehaviour:behaviour];
            
            answerFamilyDinnerTotalNum=0;
            FamilyDinnerRightNum1=0;FamilyDinnerRightNum2=0;FamilyDinnerRightNum3=0;FamilyDinnerRightNum4=0;
            fquestionIndex = 0;
            
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userFamilyDinner;;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
        }
    }
    
}
//跳转到下一页
-(void)nextpage1{
    Questions* que = [questionsFamilyDinner objectAtIndex:9];
    if(que.gameId%2==0)userFamilyDinner.golden=userFamilyDinner.golden+2;
    if(que.gameId%2==1) userFamilyDinner.golden=userFamilyDinner.golden+1;
    [UserDao updateUser:userFamilyDinner];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DragonBoat *dragonboat = [mainStoryboard instantiateViewControllerWithIdentifier:@"DragonBoat"];
    dragonboat.user = userFamilyDinner;
    dragonboat.questionsDragonBoat = questionsFamilyDinner;
    dragonboat.gameIdDragonBoat = gameIdFamilyDinner;
    [dragonboat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:dragonboat animated:YES completion:nil];
}

//点击提交答案，判断正误，进行下一步操作
//- (IBAction)submit:(UIButton *)sender {
    
  
//}


//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitfamilydinner = 1;
        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    }

    
    
}



- (IBAction)fbutton1:(UIButton *)sender {
 if(FamilyDinnerRightNum1==0)
 {  fquestionIndex = 9;
   [self QuestionInterface:fquestionIndex];
 }
}
- (IBAction)mbutton1:(UIButton *)sender {
  if(FamilyDinnerRightNum2==0)
  {fquestionIndex = 10;
    [self QuestionInterface:fquestionIndex];
  }
}
- (IBAction)gfbutton1:(UIButton *)sender {
  if(FamilyDinnerRightNum3==0)
  { fquestionIndex = 11;
    [self QuestionInterface:fquestionIndex];
  }
}
- (IBAction)gmbutton1:(UIButton *)sender {
   if(FamilyDinnerRightNum4==0)
   {fquestionIndex = 12;
    [self QuestionInterface:fquestionIndex];
   }
}


- (void)QuestionInterface:(int)fquestionIndex{//跳转到FamilyDinneruestion界面
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     FamilyDinnerQuestion*familydinnerqusetion = [mainStoryboard instantiateViewControllerWithIdentifier:@"FamilyDinnerQuestion"];
    familydinnerqusetion.user = userFamilyDinner;
    familydinnerqusetion.questionsFamilyDinner=questionsFamilyDinner;
    familydinnerqusetion.gameIdFamilyDinner=gameIdFamilyDinner;
    familydinnerqusetion.questionIndex=fquestionIndex;
    familydinnerqusetion.fanswerTotalNum1=answerFamilyDinnerTotalNum;
    familydinnerqusetion.fquestionRightNum11=FamilyDinnerRightNum1;
    familydinnerqusetion.fquestionRightNum12=FamilyDinnerRightNum2;
    familydinnerqusetion.fquestionRightNum13=FamilyDinnerRightNum3;
    familydinnerqusetion.fquestionRightNum14=FamilyDinnerRightNum4;
    [familydinnerqusetion setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:familydinnerqusetion animated:YES completion:nil];
}

- (void)backgroundImage1
{
    
    UIImage *buttonImage1 = [UIImage imageNamed:@"Cheat1"];//修改后需要改图片名称
    [self.fbutton setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
    
    
}
- (void)backgroundImage2
{
    
    UIImage *buttonImage2 = [UIImage imageNamed:@"Cheat2"];//修改后需要改图片名称
    [self.mbutton setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
}

- (void)backgroundImage3
{
    
    UIImage *buttonImage3 = [UIImage imageNamed:@"Cheat3"];//修改后需要改图片名称
    [self.gfbutton setBackgroundImage:buttonImage3 forState:UIControlStateNormal];
}

- (void)backgroundImage4
{
    
    UIImage *buttonImage4 = [UIImage imageNamed:@"Cheat4"];//修改后需要改图片名称
    [self.gmbutton setBackgroundImage:buttonImage4 forState:UIControlStateNormal];
}



- (IBAction)goBack:(id)sender {
    exitfamilydinner = 1;
    [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    answerFamilyDinnerTotalNum=0;
    FamilyDinnerRightNum1=0;FamilyDinnerRightNum2=0;FamilyDinnerRightNum3=0;FamilyDinnerRightNum4=0;
    fquestionIndex = 0;
}


@end
