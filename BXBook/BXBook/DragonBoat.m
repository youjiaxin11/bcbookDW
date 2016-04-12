//
//  DragonBoat.m
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "DragonBoat.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@interface DragonBoat()
{
    dispatch_source_t timer;
}
@end

@implementation DragonBoat

/*开发者在页面操作中，用这几个值*/
@synthesize

questionsDragonBoat,//当前关卡下的所有题目,本小游戏使用最后5道题目
gameIdDragonBoat;//当前关卡数
User *userDragonBoat;//当前登录用户
int exitdragonboat = 0; //判断是否强行退出


- (void)viewDidLoad {
    [super viewDidLoad];
    userDragonBoat = self.user;
    // 数据初始化
    [self dataInitializationWhenViewDidLoad];
    
    NSLog(@"游戏币：%d", userDragonBoat.golden);
    NSLog(@"dragonboat:当前登录用户：%@",userDragonBoat.loginName);
    NSLog(@"dragonboat:游戏表中的id：%lu", (unsigned long)[questionsDragonBoat count]);
    NSLog(@"dragonboat:当前关卡数gameid：%d", gameIdDragonBoat);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userDragonBoat.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"DragonBoat-(void)viewDidLoad-关卡id:%d", gameIdDragonBoat];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

-(void)dataInitializationWhenViewDidLoad{
    [self setAnswerBtnsEnabled:NO];
    [_DBUsePrompt setText:@"点击计时开始游戏"];
    [_DBBeginBtn setTitle:@"开始答题" forState:UIControlStateNormal];
    [_DBTimeLabel setText:@"00:00"];
    _DBFinalTimeUsing = 0;
    _DBCurrentQuestionNumber = 13;
    _DBTimeCount = 0;
    userDragonBoat = self.user;
    _DBAnswer1.hidden = YES;
    _DBAnswer2.hidden = YES;
    _DBAnswer3.hidden = YES;
}

- (IBAction)DBCheckAnswers:(id)sender {
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userDragonBoat.userId;
    behaviour.doWhat = @"游戏－答题";
    behaviour.doWhere = [[NSString alloc]initWithFormat:@"DragonBoat-(IBAction)DBCheckAnswers:(id)sender-题目id:%d",_DBQuestionEntity.questionId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    // 用户答题次数和题目被答次数加1,并且更新数据库
    userDragonBoat.answerTimes++;
    _DBQuestionEntity.answerTimes++;
    [UserDao updateUser:userDragonBoat];
    [QuestionsDao updateQuestions:_DBQuestionEntity];
    
    UIButton *btn = sender;
    
    // 如果回答正确
    if (btn.tag == _DBQuestionEntity.answerRight) {
        
        //用户答题正确次数和该题目被正确答题次数加1,并切换到下一题，同时更新数据库
        userDragonBoat.answerRightTimes++;
        _DBQuestionEntity.rightTimes++;
        [UserDao updateUser:userDragonBoat];
        [QuestionsDao updateQuestions:_DBQuestionEntity];
        
        // 如果不是最后一题
        if (_DBCurrentQuestionNumber != 18) {
            [self showAnswers];
        }else{
            
            // 是最后一题，停止计时
            dispatch_source_cancel(timer);
            [self gameOverDataReset];
            //通关奖励
            [self getaward];
            // 更新金币和数据库
            if (gameIdDragonBoat%2 == 1) {
                userDragonBoat.golden++;
                NSLog(@"golden:%d",userDragonBoat.golden);
            }else{
                userDragonBoat.golden = userDragonBoat.golden + 2;
                NSLog(@"golden:%d",userDragonBoat.golden);
            }
            [UserDao updateUser:userDragonBoat];
            [QuestionsDao updateQuestions:_DBQuestionEntity];
            [self prompsucess];
            //   [self prompaward];
            
            
        }
    }else{
        // 回答错误提醒
        if (_DBQuestionEntity.helpId == 0) {
            [self promptNoCheats:@"很抱歉回答错误，请重新答题！"];
        }else{
            [self promptCheatsDragonBoat:@"很抱歉，答错了！去看看通关秘籍吧！"];
        }
    }
}

- (IBAction)DBStartCount:(id)sender {
    
    // 开始游戏，计时开始
    [_DBUsePrompt setText:@"游戏开始，抓紧时间哦"];
    [_DBBeginBtn setTitle:@"计时中" forState:UIControlStateNormal];
    _DBBeginBtn.enabled = NO;
    [self setAnswerBtnsEnabled:YES];
    
    // 显示第一个问题和备选答案
    [self showAnswers];
    
    // 通过线程来做计时器
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    //    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        int hours = _DBTimeCount / 3600;
        int minutes = (_DBTimeCount - (3600*hours)) / 60;
        int seconds = _DBTimeCount%60;
        NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d",minutes,seconds];
        _DBFinalTimeUsing = minutes * 60 + seconds;
        dispatch_async(dispatch_get_main_queue(), ^{
            _DBTimeLabel.text = strTime;
        });
        _DBTimeCount ++;
    });
    // 开启线程，计时开始
    dispatch_resume(timer);
    
}

// 游戏结束数据重置
-(void)gameOverDataReset{
    [_DBUsePrompt setText:@"闯关成功！"];
    [_DBBeginBtn setTitle:@"计时结束" forState:UIControlStateNormal];
    _DBCurrentQuestionNumber = 13;
    _DBTimeCount = 0;
    [self setAnswerBtnsEnabled:NO];
}

// 显示问题和备选答案
-(void)showAnswers{
    // 获取问题实体
    _DBQuestionEntity = [self.questionsDragonBoat objectAtIndex:_DBCurrentQuestionNumber];
    
    // 通过判断问题的备选数目，更新视图
    if (_DBQuestionEntity.answerNum == 2) {
        _DBQuestionLabel.text = _DBQuestionEntity.question;
        [_DBAnswer1 setTitle:_DBQuestionEntity.answer1 forState:UIControlStateNormal];
        [_DBAnswer2 setTitle:_DBQuestionEntity.answer2 forState:UIControlStateNormal];
        _DBAnswer1.hidden = NO;
        _DBAnswer2.hidden = NO;
        _DBAnswer3.hidden = YES;
    }else{
        _DBQuestionLabel.text = _DBQuestionEntity.question;
        [_DBAnswer1 setTitle:_DBQuestionEntity.answer1 forState:UIControlStateNormal];
        [_DBAnswer2 setTitle:_DBQuestionEntity.answer2 forState:UIControlStateNormal];
        [_DBAnswer3 setTitle:_DBQuestionEntity.answer3 forState:UIControlStateNormal];
        _DBAnswer1.hidden = NO;
        _DBAnswer2.hidden = NO;
        _DBAnswer3.hidden = NO;
    }
    
    // 问题题号加1
    _DBCurrentQuestionNumber++;
}

// 设置回答按钮是否可点击
-(void)setAnswerBtnsEnabled:(BOOL)enable{
    _DBAnswer1.enabled = enable;
    _DBAnswer2.enabled = enable;
    _DBAnswer3.enabled = enable;
}
//跳转到下一页
-(void)nextpage1{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userDragonBoat.userId;
    behaviour.doWhat = @"游戏－过关";
    behaviour.doWhere = @"DragonBoat-(void)nextpage1";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskChoice *taskchoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskChoice"];
    taskchoice.user = userDragonBoat;
    // taskchoice.finishgameId=gameIdDragonBoat;
    [taskchoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:taskchoice animated:YES completion:nil];
}

//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitdragonboat = 1;
        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    }
}


//出现在本页的所有弹框的具体属性设置
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"tag：%ld", (long)alertView.tag) ;
    
    if (exitdragonboat == 0 && alertView.tag == 20) {
        NSLog(@"提醒回答错啦");
        if(buttonIndex == 1){
            [self dragonBoatCheat];
        }
    }else if (exitdragonboat == 0 && alertView.tag == 21){
        NSLog(@"最后一题回答完啦");
        if (buttonIndex == 0) {
            [self nextpage1];
        }
        
        else if(buttonIndex==1){
            
            [self pagemybag];
        }
        
        else [self nextpage1];
    }else if (exitdragonboat == 0 && alertView.tag == 0){//无通关秘籍
        NSLog(@"继续答题，什么也不做");
    }else if (exitdragonboat == 1) {//如果强行退出
        if(buttonIndex==0){
            
            //记录行为数据
            NSString* timeNow = [TimeUtil getTimeNow];
            Behaviour *behaviour = [[Behaviour alloc]init];
            behaviour.userId = userDragonBoat.userId;
            behaviour.doWhat = @"游戏－退出";
            behaviour.doWhere = @"DragonBoat-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex";
            behaviour.doWhen = timeNow;
            [BehaviourDao addBehaviour:behaviour];
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userDragonBoat;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
        }
    }else{
        
        NSLog(@"开启任务");
        [self nextpage1];
    }
}

- (IBAction)goBack:(id)sender {
    exitdragonboat = 1;
    [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
}

//跳到通关秘籍
- (void)dragonBoatCheat{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    
    cheat.user = userDragonBoat;
    cheat.helpId = _DBQuestionEntity.helpId;
    NSLog(@"helpId:%d",_DBQuestionEntity.helpId);
    
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//通过不同的关给予不同的奖励
-(void)getaward{
    if(userDragonBoat.award1==nil||userDragonBoat.award1==0) userDragonBoat.award1=0;
    if(userDragonBoat.award2==nil||userDragonBoat.award2==0) userDragonBoat.award2=0;
    if(userDragonBoat.award3==nil||userDragonBoat.award3==0) userDragonBoat.award3=0;
    if(userDragonBoat.award4==nil||userDragonBoat.award4==0) userDragonBoat.award4=0;
    if(userDragonBoat.award5==nil||userDragonBoat.award5==0) userDragonBoat.award5=0;
    if(userDragonBoat.award6==nil||userDragonBoat.award6==0) userDragonBoat.award6=0;
    if(gameIdDragonBoat==1||gameIdDragonBoat==2) userDragonBoat.award1++;
    if(gameIdDragonBoat==3||gameIdDragonBoat==4)userDragonBoat.award2++;
    if(gameIdDragonBoat==5||gameIdDragonBoat==6)userDragonBoat.award3++;
    if(gameIdDragonBoat==7||gameIdDragonBoat==8)userDragonBoat.award4++;
    if(gameIdDragonBoat==9||gameIdDragonBoat==10)userDragonBoat.award5++;
    if(gameIdDragonBoat==11||gameIdDragonBoat==12)userDragonBoat.award6++;
    [UserDao updateaward:userDragonBoat];
    NSLog(@"award3=%d",userDragonBoat.award3);
    
}
- (void) prompsucess{
    // 通关跳转
    if(gameIdDragonBoat==1)
    {
        userDragonBoat.finishId1=1;
    }
    else if(gameIdDragonBoat==2)
    {
        userDragonBoat .finishId2=1;
    }
    else if(gameIdDragonBoat==3)
    {
        userDragonBoat.finishId3=1;
    }
    else if(gameIdDragonBoat==4)
    {
        userDragonBoat.finishId4=1;
    }
    else if(gameIdDragonBoat==5)
    {
        userDragonBoat.finishId5=1;
    }
    else if(gameIdDragonBoat==6)
    {
        userDragonBoat.finishId6=1;
    }
    else if(gameIdDragonBoat==7)
    {
        userDragonBoat.finishId7=1;
    }
    else if(gameIdDragonBoat==8)
    {
        userDragonBoat.finishId8=1;
    }
    else if(gameIdDragonBoat==9)
    {
        userDragonBoat.finishId9=1;
    }
    else if(gameIdDragonBoat==10)
    {
        userDragonBoat.finishId10=1;
    }
    else if(gameIdDragonBoat==11)
    {
        userDragonBoat.finishId11=1;
    }
    else if(gameIdDragonBoat==12)
    {
        userDragonBoat.finishId12=1;
    }
    [UserDao updatefinishId:userDragonBoat];
    
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"恭喜你，共用时%d秒，击败电脑，闯关成功!\n制作粽子的奖励已经放到你的背包中，快快加油闯关集齐奖励吧！\n请选择查看我的背包,前往一站到底或者开启任务",_DBFinalTimeUsing]  delegate:self  cancelButtonTitle:@"开启任务" otherButtonTitles:nil];
    alert.tag = 21;
    [alert show];
    
    
}


//- (void) prompaward{
//  [self.view endEditing:YES];
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"恭喜你闯关成功！制作粽子的奖励已经放到你的背包中，快快加油闯关集齐奖励吧！"  delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:@"看看我的背包", nil];
//   alert.tag=56;
//  [alert show];
//

//}

//跳转到我的背包界面
-(void)pagemybag{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Mybag*mybag= [mainStoryboard instantiateViewControllerWithIdentifier:@"Mybag"];
    mybag.user = userDragonBoat;
    // mybag.finishgameIdm=gameIdDragonBoat;
    [mybag setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:mybag animated:YES completion:nil];
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
    behaviour.userId = userDragonBoat.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"DragonBoat-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userDragonBoat;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userDragonBoat;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userDragonBoat;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userDragonBoat;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}

@end
