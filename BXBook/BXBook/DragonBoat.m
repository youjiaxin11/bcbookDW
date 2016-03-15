//
//  DragonBoat.m
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "DragonBoat.h"

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
    
    // 数据初始化
    [self dataInitializationWhenViewDidLoad];
    
    NSLog(@"游戏币：%d", userDragonBoat.golden);
    NSLog(@"dragonboat:当前登录用户：%@",userDragonBoat.loginName);
    NSLog(@"dragonboat:游戏表中的id：%lu", (unsigned long)[questionsDragonBoat count]);
    NSLog(@"dragonboat:当前关卡数gameid：%d", gameIdDragonBoat);
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
            
            // 通关跳转
            [self.view endEditing:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"恭喜你，共用时%d秒，击败电脑，一站到底或者下一个任务",_DBFinalTimeUsing]  delegate:self cancelButtonTitle:@"一站到底" otherButtonTitles:@"开启任务", nil];
            alert.tag = 21;
            [alert show];
        }
    }else{
        
        // 回答错误提醒
        [self.view endEditing:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"回答错误，请继续作答！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 20;
        [alert show];
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
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskChoice *taskchoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskChoice"];
    taskchoice.user = userDragonBoat;
    taskchoice.finishgameId=gameIdDragonBoat;
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
    if (alertView.tag == 20) {
        NSLog(@"提醒回答错啦");
    }else if (alertView.tag == 21){
        NSLog(@"最后一题回答完啦");
        if (buttonIndex == 0) {
            NSLog(@"去往一站到底");
        }else{
            [self nextpage1];
        }
    }
    else if (exitdragonboat == 1) {//如果强行退出
        if(buttonIndex==0){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userDragonBoat;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
        }
    }else{
        if (buttonIndex == 1) {
            [self nextpage1];
        }else{
            [self nextpage1];
        }
    }
}
@end