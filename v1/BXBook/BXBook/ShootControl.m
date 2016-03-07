//
//  ShootControl.m
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "ShootControl.h"
#import "PlayMusicImpl.h"
#import <AVFoundation/AVFoundation.h>

@interface ShootControl()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件
@property(nonatomic,assign)int currentIndex;//用一个int型的属性来记录当前的索引

@end

@implementation ShootControl
@synthesize goldenLbl;

/*开发者在页面操作中，用这几个值*/
User *userShoot;//当前登录用户
Game *gameShoot;//当前游戏对象，存有所有题目及答案

//判断三个音乐是否播放
int music1 = 0;
int music2 = 0;
int music3 = 0;

//判断要停止哪首音乐
int preIndex1 = 0;

//标志是否答对题目
int questionright = 0;

int exitshoot = 0;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    userShoot = self.user;
    gameShoot = self.game;
    
    [goldenLbl setText:[NSString stringWithFormat:@"游戏币：%d", userShoot.golden]];
    //图片初始化
    UIImage *answer4_1 = [UIImage imageNamed:@"answer4_1"];
    UIImage *answer4_2 = [UIImage imageNamed:@"answer4_2"];
    UIImage *answer4_3 = [UIImage imageNamed:@"answer4_3"];
    UIImage *answer5_1 = [UIImage imageNamed:@"answer5_1"];
    UIImage *answer5_2 = [UIImage imageNamed:@"answer5_2"];
    UIImage *answer5_3 = [UIImage imageNamed:@"answer5_3"];
    UIImage *answer6_1 = [UIImage imageNamed:@"answer6_1"];
    UIImage *answer6_2 = [UIImage imageNamed:@"answer6_2"];
    UIImage *answer6_3 = [UIImage imageNamed:@"answer6_3"];
    UIImage *answer7_1 = [UIImage imageNamed:@"answer7_1"];
    UIImage *answer7_2 = [UIImage imageNamed:@"answer7_2"];
    UIImage *answer7_3 = [UIImage imageNamed:@"answer7_3"];
    UIImage *answer8_1 = [UIImage imageNamed:@"answer8_1"];
    UIImage *answer8_2 = [UIImage imageNamed:@"answer8_2"];
    UIImage *answer8_3 = [UIImage imageNamed:@"answer8_3"];
    UIImage *answer9_1 = [UIImage imageNamed:@"answer9_1"];
    UIImage *answer9_2 = [UIImage imageNamed:@"answer9_2"];
    UIImage *answer9_3 = [UIImage imageNamed:@"answer9_3"];
    UIImage *answer10_1 = [UIImage imageNamed:@"answer10_1"];
    UIImage *answer10_2 = [UIImage imageNamed:@"answer10_2"];
    UIImage *answer10_3 = [UIImage imageNamed:@"answer10_3"];
    
    //不同的shootID对应不同图片音乐按钮显示情况
    if(gameShoot.shoot.shootId == 1){
        [self musicShow];
    }else if(gameShoot.shoot.shootId == 2){
        [self musicShow];
    }else if(gameShoot.shoot.shootId == 3){
        [self musicShow];
    }else if(gameShoot.shoot.shootId == 4){
        [self imageShow];
        [self.image1 setBackgroundImage:answer4_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer4_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer4_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 5){
        [self imageShow];
        [self.image1 setBackgroundImage:answer5_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer5_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer5_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 6){
        [self imageShow];
        [self.image1 setBackgroundImage:answer6_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer6_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer6_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 7){
        [self imageShow];
        [self.image1 setBackgroundImage:answer7_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer7_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer7_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 8){
        [self imageShow];
        [self.image1 setBackgroundImage:answer8_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer8_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer8_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 9){
        [self imageShow];
        [self.image1 setBackgroundImage:answer9_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer9_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer9_3 forState:UIControlStateNormal];
    }else if (gameShoot.shoot.shootId == 10){
        [self imageShow];
        [self.image1 setBackgroundImage:answer10_1 forState:UIControlStateNormal];
        [self.image2 setBackgroundImage:answer10_2 forState:UIControlStateNormal];
        [self.image3 setBackgroundImage:answer10_3 forState:UIControlStateNormal];
    }else if(gameShoot.shoot.shootId == 11){
        [self musicShow];
    }else if (gameShoot.shoot.shootId == 12){
        [self musicShow];
    }
    
    //问题答案文字显示
    //显示题目
    NSLog(@"shoot:当前登录用户：%@",userShoot.loginName);
    NSLog(@"shoot:游戏表中的id：%d",gameShoot.gameId);
    NSLog(@"shoot:游戏中shootId:%d",gameShoot.shoot.shootId);
    NSLog(@"shoot:此页面要显示的内容如下：");
    NSLog(@"shoot:游戏中 helpId:%d",gameShoot.shoot.helpId);
    NSString *questions = gameShoot.shoot.question;
    self.question.text = questions;
    NSLog(@"shoot:%@",gameShoot.shoot.question);//问题
    
    NSString *answer1 = gameShoot.shoot.answer1;
    NSLog(@"shoot:%@",gameShoot.shoot.answer1);//选项1
    [self.answer1 setTitle:answer1 forState:UIControlStateNormal];
    
    NSString *answer2 = gameShoot.shoot.answer2;
    NSLog(@"shoot:%@",gameShoot.shoot.answer2);//选项2
    [self.answer2 setTitle:answer2 forState:UIControlStateNormal];
    
    NSString *answer3 = gameShoot.shoot.answer3;
    NSLog(@"shoot:%@",gameShoot.shoot.answer3);//选项3
    [self.answer3 setTitle:answer3 forState:UIControlStateNormal];
    
    NSLog(@"shoot:%d",gameShoot.shoot.answerNum);//选项个数
    NSLog(@"shoot:%d",gameShoot.shoot.answerRight);//正确选项序号
}

//按钮回答反馈
- (IBAction)answer1Pressed:(id)sender {
    userShoot.answerTimes ++;
    gameShoot.shoot.answerTimes++;
    if (self.answer1.tag == gameShoot.shoot.answerRight) {
        questionright = 1;
        userShoot.answerRightTimes++;
        gameShoot.shoot.rightTimes++;
        [self promptShootFinish:@"恭喜你，答对啦！"];
    }else{
        [self promptShootNotFinish:@"很抱歉，答错了!\n去看看通关秘籍吧！"];
    }
    [UserDao updateUser:userShoot];
    [GameDao updateShoot:gameShoot.shoot];
}

- (IBAction)answer2Pressed:(id)sender {
    userShoot.answerTimes ++;
    gameShoot.shoot.answerTimes++;
    if (self.answer2.tag == gameShoot.
        shoot.answerRight) {
        questionright = 1;
        userShoot.answerRightTimes++;
        gameShoot.shoot.rightTimes++;
        [self promptShootFinish:@"恭喜你，答对啦！"];
    }else{
        [self promptShootNotFinish:@"很抱歉，答错了!\n去看看通关秘籍吧！"];
    }
    [UserDao updateUser:userShoot];
    [GameDao updateShoot:gameShoot.shoot];
}
- (IBAction)answer3Pressed:(id)sender {
    userShoot.answerTimes ++;
    gameShoot.shoot.answerTimes++;
    if (self.answer3.tag == gameShoot.shoot.answerRight) {
        questionright = 1;
        userShoot.answerRightTimes++;
        gameShoot.shoot.rightTimes++;
        [self promptShootFinish:@"恭喜你，答对啦！"];
    }else{
        [self promptShootNotFinish:@"很抱歉，答错了!\n去看看通关秘籍吧！"];
    }
    [UserDao updateUser:userShoot];
    [GameDao updateShoot:gameShoot.shoot];
}


//提示框跳转选择控制，答对就通过，回答错去通关秘籍
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (exitshoot == 1) {//如果强行退出
        if(buttonIndex==0){
            questionright = 0;
            
            //音乐全部暂停
            if(music1 %2 == 1){
                music1++;
                [self stop];
            }
            if(music2 %2 == 1){
                music2++;
                [self stop];
            }
            if(music3 %2 == 1){
                music3++;
                [self stop];
            }
            
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
            gamechoice.user = userShoot;
            [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:gamechoice animated:YES completion:nil];
            
        }
    }else{
    
    if(questionright == 1){
        [self startMission];
    }else{
        [self shootCheat];
    }
    }
    
}

//歌曲初始化
-(NSArray *)songs
{
    if (_songs==nil) {
        self.songs=@[@"a 水调歌头-但愿人长久.mp3",@"b 中秋.mp3",@"c 十五的月亮.mp3",@"a 彩云追月.mp3",@"b 春江花月夜.mp3",@"c 思乡曲.mp3",@"与a相配合思乡曲.mp3",@"与b相配牧童短笛.mp3",@"与c相配李云迪-彩云追月 - 钢琴独奏.mp3",@"思乡曲.mp3"];
    }
    return _songs;
}

//音乐按钮1
- (IBAction)play1:(id)sender {
    music1++;
    
    if (gameShoot.shoot.shootId == 1) {
        _currentIndex = 0;
    }else if (gameShoot.shoot.shootId == 2){
        _currentIndex = 3;
    }else if (gameShoot.shoot.shootId == 3){
        _currentIndex = 5;
    }else if (gameShoot.shoot.shootId == 11){
        _currentIndex = 6;
    }else if (gameShoot.shoot.shootId == 12){
        _currentIndex = 9;
    }
    
    //关掉其他音乐
    if (music2 %2 == 1) {
        music2++;
        if (music3 %2 == 1) {
            music3++;
        }
    }
    [self stopOthers];
    
    //播放音乐1
    if (music1 %2 == 1) {
        [self play];
        preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
}

//音乐按钮2
- (IBAction)play2:(id)sender {
    music2++;
    
    if (gameShoot.shoot.shootId == 1) {
        _currentIndex = 1;
    }else if (gameShoot.shoot.shootId == 2){
        _currentIndex = 4;
    }else if (gameShoot.shoot.shootId == 3){
        _currentIndex = 5;
    }else if (gameShoot.shoot.shootId == 11){
        _currentIndex = 7;
    }else if (gameShoot.shoot.shootId == 12){
        _currentIndex = 9;
    }
    
    //关掉其他音乐
    if (music1 %2 == 1) {
        music1++;
        if (music3 %2 == 1) {
            music3++;
        }
    }
    [self stopOthers];
    
    //播放音乐2
    if (music2 %2 == 1) {
        [self play];
        preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
    
}

//音乐按钮3
- (IBAction)play3:(id)sender {
    music3++;
    
    if (gameShoot.shoot.shootId == 1) {
        _currentIndex = 2;
    }else if (gameShoot.shoot.shootId == 2){
        _currentIndex = 5;
    }else if (gameShoot.shoot.shootId == 3){
        _currentIndex = 5;
    }else if (gameShoot.shoot.shootId == 11){
        _currentIndex = 8;
    }else if (gameShoot.shoot.shootId == 12){
        _currentIndex = 9;
    }
    
    //关掉其他音乐
    if (music1 %2 == 1) {
        music1++;
        if (music2 %2 == 1) {
            music2++;
        }
    }
    [self stopOthers];
    
    //播放音乐3
    if (music3 %2 == 1) {
        [self play];
        preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
    
}

//图片按钮显示控制
-(void)imageShow{
    _image1.hidden = false;
    _image2.hidden = false;
    _image3.hidden = false;
}
//音乐按钮显示控制
-(void)musicShow{
    _sound1.hidden = false;
    _sound2.hidden = false;
    _sound3.hidden = false;
}

//音乐播放控制
- (void)play {
    //开始播放/继续播放
    [PlayMusicImpl playMusic:self.songs[self.currentIndex]];
}
- (void)pause {
    //暂停播放
    [PlayMusicImpl pauseMusic:self.songs[self.currentIndex]];
}
- (void)stop {
    //停止播放
    [PlayMusicImpl stopMusic:self.songs[self.currentIndex]];
}
- (void)stopOthers {
    //停止播放
    [PlayMusicImpl stopMusic:self.songs[preIndex1]];
}

//跳到通关秘籍
- (void)shootCheat{
    
    //音乐全部暂停
    if(music1 %2 == 1){
        music1++;
        [self stop];
    }
    if(music2 %2 == 1){
        music2++;
        [self stop];
    }
    if(music3 %2 == 1){
        music3++;
        [self stop];
    }
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    cheat.user = userShoot;
    cheat.game = gameShoot;
    cheat.flag1cheat=3;
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//开启任务
- (void)startMission{
    
    if (gameShoot.gameId %2 == 1) {
        userShoot.golden++;
        NSLog(@"golden:%d",userShoot.golden);
    }else{
        userShoot.golden = userShoot.golden + 2;
        NSLog(@"golden:%d",userShoot.golden);
    }
    //User数据库更新
    [UserDao updateUser:_user];
    questionright = 0;
    
    //音乐全部暂停
    if(music1 %2 == 1){
        music1++;
        [self stop];
    }
    if(music2 %2 == 1){
        music2++;
        [self stop];
    }
    if(music3 %2 == 1){
        music3++;
        [self stop];
    }
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaskChoice *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskChoice"];
    nextpage.user = userShoot;
    nextpage.finishgameId=gameShoot.gameId;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//直接跳转到通关秘籍
- (IBAction)gotoShootCheat:(id)sender {
    [self shootCheat];
}

//左滑退出
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        exitshoot = 1;
        [self prompt2:@"退出游戏将会失去本关的游戏币哟！"];
    }
}


@end
