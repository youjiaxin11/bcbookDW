//
//  GameChoice.m
//  BXBook
//
//  Created by sunzhong on 15/7/8.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "GameChoice.h"
#import <Foundation/Foundation.h>

@interface GameChoice ()
@property (strong, nonatomic) IBOutlet UIImageView *dice1;
@property (nonatomic, retain) NSTimer *timer;
@property (strong, nonatomic) CWStarRateView *starRateView;
@end

@implementation GameChoice


int imageNumber = 0;
int dice1Num = 3;
User *userGameChoice;
//Game *gameGameChoice;//当前游戏对象，存有所有题目及答案
//Game *gameGameChoice1;//当前游戏对象，存有所有题目及答案
int finishgameId3;//当前完成的游戏关卡号
int count1=0;//游戏关卡是否全部通过的标志位
int taskchoice;
int finalChoice;
int change =0;
- (void)viewDidLoad {
    change = 0;
    [super viewDidLoad];
    userGameChoice = self.user;
    finishgameId3=self.finishgameId2;
    NSLog(@"$$$$$$$$:%d",finishgameId3);
    NSLog(@"gamechoice：从上个页面传过来的角色：%d", _user.role);
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(600, 280, 200, 60) numberOfStars:2];
    self.starRateView.scorePercent = 0.5;
    self.starRateView.allowIncompleteStar = NO;
    self.starRateView.hasAnimation = YES;
    [self.view addSubview:self.starRateView];
    
    _dice1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_dice1 addGestureRecognizer:singleTap];
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userGameChoice.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"GameChoice-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer{
    //需要一个定时器来控制图片
    [_timer invalidate];
    _timer = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                              target: self
                                            selector: @selector(changeImage)
                                            userInfo: nil
                                             repeats: YES];
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userGameChoice.userId;
    behaviour.doWhat = @"游戏－选关";
    behaviour.doWhere = @"GameChoice-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

//关卡及难度选择最终结果
- (int) judgeFinalResult:(int)dice star:(float)star{
    if (change == 0 && (int)star == 0) {
        return 5;
    }else if(change == 0 && (int)star == 1){
        return 6;
    }else if (change == 1){
        if ((int)star == 0 && dice == 1) {
            return 1;
        }else if ((int)star == 1 && dice == 1 ){
            return 2;
        }else if ((int)star == 0 && dice == 2 ){
            return 3;
        }else if ((int)star == 1 && dice == 2 ){
            return 4;
        }else if ((int)star == 0 && dice == 3 ){
            return 5;
        }else if ((int)star == 1 && dice == 3 ){
            return 6;
        }else if ((int)star == 0 && dice == 4 ){
            return 7;
        }else if ((int)star == 1 && dice == 4 ){
            return 8;
        }else if ((int)star == 0 && dice == 5 ){
            return 9;
        }else if ((int)star == 1 && dice == 5 ){
            return 10;
        }else if ((int)star == 0 && dice == 6 ){
            return 11;
        }else if ((int)star == 1 && dice == 6 ){
            return 12;
        }
        
    }
    return 1;
}


//随机切换图片
- (void) changeImage{
    change = 1;
    int i = arc4random()%6 +1;
    NSLog(@"骰子骰子骰子：%d",i);
    NSString *name1 = @"骰子";
    NSString *name2 = [NSString stringWithFormat:@"%d", i];
    NSString *name3 = @"-1.png";
    NSString *name4 = [name1 stringByAppendingString:name2];
    NSString *name5 = [name4 stringByAppendingString:name3];//图片名字
    UIImage *image = [UIImage imageNamed:name5];
    _dice1.image = image;
    dice1Num = i;
    
    imageNumber++;
    if (imageNumber > 20) {
        [_timer invalidate];
        _timer = nil;
        imageNumber = 0;
        // judgeDiceResult = dice1Num;
    }
}

////点击置骰子按钮
//- (IBAction)playDice:(id)sender {
//    //需要一个定时器来控制图片
//    [_timer invalidate];
//    _timer = nil;
//    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.1
//                                              target: self
//                                            selector: @selector(changeImage)
//                                            userInfo: nil
//                                             repeats: YES];
//
//}

//点击开始闯关按钮
- (IBAction)playGame:(id)sender{
    

    
    finalChoice = [self judgeFinalResult:(int)dice1Num star:(float)self.starRateView.scorePercent];
    NSLog(@"finalChoice:%d",finalChoice);
    if(finishgameId3==1)
    {
    userGameChoice.finishId1=1;
    }
    else if(finishgameId3==2)
    {
        userGameChoice.finishId2=1;
    }
    else if(finishgameId3==3)
    {
        userGameChoice.finishId3=1;
    }
   else if(finishgameId3==4)
    {
        userGameChoice.finishId4=1;
    }
    else if(finishgameId3==5)
    {
        userGameChoice.finishId5=1;
    }
    else if(finishgameId3==6)
    {
        userGameChoice.finishId6=1;
    }
    else if(finishgameId3==7)
    {
        userGameChoice.finishId7=1;
    }
    else if(finishgameId3==8)
    {
        userGameChoice.finishId8=1;
    }
    else if(finishgameId3==9)
    {
        userGameChoice.finishId9=1;
    }
    else if(finishgameId3==10)
    {
        userGameChoice.finishId10=1;
    }
    else if(finishgameId3==11)
    {
        userGameChoice.finishId11=1;
    }
    else if(finishgameId3==12)
    {
        userGameChoice.finishId12=1;
    }
    [UserDao updatefinishId:userGameChoice];
    // gameGameChoice = [GameDao findGameByGameId:finalChoice];
   // if(finishgameId3==gameGameChoice.gameId){
    //  gameGameChoice.finishId=1;
        //然后将gameGameChoice.finishId的值更新至数据库
        //[GameDao updateGameFinishId:gameGameChoice];
      
   // }
   
    
  //  NSMutableArray* gameGameChoices = [GameDao findAllGames];
    //for(int i=1;i<13;i++)
    //{   Game* gameGameChoice1 = [[Game alloc]init];
    //    gameGameChoice1 = [gameGameChoices objectAtIndex:i-1];
     //   if(gameGameChoice1.finishId==1) {count1++;}
      //  else count1=0;
   // }
    
    if(userGameChoice.finishId1==1&&userGameChoice.finishId2==1&&userGameChoice.finishId3==1&&userGameChoice.finishId4==1&&userGameChoice.finishId5==1&&userGameChoice.finishId6==1&&userGameChoice.finishId7==1&&userGameChoice.finishId8==1&&userGameChoice.finishId9==1&&userGameChoice.finishId10==1&&userGameChoice.finishId11==1&&userGameChoice.finishId12==1)
    {[self prompt:@"恭喜你已经顺利通过所有游戏关卡！请前往任务关卡继续挑战吧！"];
        taskchoice=1;
    }
    else{ if((finalChoice==1&&userGameChoice.finishId1==0)||(finalChoice==2&&userGameChoice.finishId2==0)||(finalChoice==3&&userGameChoice.finishId3==0)||(finalChoice==4&&userGameChoice.finishId4==0)||(finalChoice==5&&userGameChoice.finishId5==0)||(finalChoice==6&&userGameChoice.finishId6==0)||(finalChoice==7&&userGameChoice.finishId7==0)||(finalChoice==8&&userGameChoice.finishId8==0)||(finalChoice==9&&userGameChoice.finishId9==0)||(finalChoice==10&&userGameChoice.finishId10==0)||(finalChoice==11&&userGameChoice.finishId11==0)||(finalChoice==12&&userGameChoice.finishId12==0))
        {  UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            LineControl *linecontrol = [mainStoryboard instantiateViewControllerWithIdentifier:@"Line"];
//          //  linecontrol.game = gameGameChoice;
//             linecontrol.gameChoiceNum = finalChoice;
//            linecontrol.user = userGameChoice;
//            [linecontrol setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//            [self presentViewController:linecontrol animated:YES completion:nil];
            
            //记录行为数据
            NSString* timeNow = [TimeUtil getTimeNow];
            Behaviour *behaviour = [[Behaviour alloc]init];
            behaviour.userId = userGameChoice.userId;
            behaviour.doWhat = @"游戏－开始";
            behaviour.doWhere = [[NSString alloc]initWithFormat:@"GameChoice-(IBAction)playGame:(id)sender-关卡id:%d", finalChoice];
            behaviour.doWhen = timeNow;
            [BehaviourDao addBehaviour:behaviour];
            
            LineNine *linenine = [mainStoryboard instantiateViewControllerWithIdentifier:@"LineNine"];
            //  linecontrol.game = gameGameChoice;
            linenine.gameIdLineNine = finalChoice;
            linenine.user = userGameChoice;
            [linenine setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:linenine animated:YES completion:nil];

        }
    else{ if((finalChoice==1&&userGameChoice.finishId1==1)||(finalChoice==2&&userGameChoice.finishId2==1)||(finalChoice==3&&userGameChoice.finishId3==1)||(finalChoice==4&&userGameChoice.finishId4==1)||(finalChoice==5&&userGameChoice.finishId5==1)||(finalChoice==6&&userGameChoice.finishId6==1)||(finalChoice==7&&userGameChoice.finishId7==1)||(finalChoice==8&&userGameChoice.finishId8==1)||(finalChoice==9&&userGameChoice.finishId9==1)||(finalChoice==10&&userGameChoice.finishId10==1)||(finalChoice==11&&userGameChoice.finishId11==1)||(finalChoice==12&&userGameChoice.finishId12==1)) [self prompt:@"该关卡你已经顺利通过！请重新选择关卡"];}
        
    }
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = userGameChoice;
        information.finishgameId4=finishgameId3;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    {if(buttonIndex==0&&taskchoice==1) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TaskChoice *nextpage1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskChoice"];
        nextpage1.user = userGameChoice;
        [nextpage1 setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nextpage1 animated:YES completion:nil];
    }
    }
}
- (IBAction)goBack:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
    information.user = userGameChoice;
    information.finishgameId4=finishgameId3;
    [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:information animated:YES completion:nil];    

}

@end
