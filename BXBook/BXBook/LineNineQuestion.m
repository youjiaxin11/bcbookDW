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
#import <AVFoundation/AVFoundation.h>

@interface LineNineQuestion()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件
@property(nonatomic,assign)int currentIndex;//用一个int型的属性来记录当前的索引

//判断三个音乐是否播放
@property(nonatomic,assign)int music1;
@property(nonatomic,assign)int music2;
@property(nonatomic,assign)int music3;

//判断要停止哪首音乐
@property(nonatomic,assign)int preIndex1;

@end

@implementation LineNineQuestion
@synthesize
//questionsAllFromLineNine,//18道所有题
questionsLineNineQuestion,//当前关卡下的所有题目，本小游戏使用前面9道题目
gameIdLineNineQuestion,//当前关卡数
lineNineQuestionIndex;//小关
lineNineQuestionImage;//题干图片


/*开发者在页面操作中，用这几个值*/
User *userLineNineQuestion;//当前登录用户
Questions *lineNineQuestion;//当前界面题目
HelpDao *lineNineHelpDao;//当前通关秘籍

static NSMutableArray *lineNineAnswerStateArray;//用一个可变数组保持答题情况
static int answerTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    userLineNineQuestion = self.user;
    _music1 = 0;
    _music2 = 0;
    _music3 = 0;
    _preIndex1 = 0;
    
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
    NSLog(@"linenineQuestion:9道所有题目数量：%lu", (unsigned long)[questionsLineNineQuestion count]);
    
    //9道题中的第几题
    questionIndex = self.lineNineQuestionIndex;
    
    NSLog(@"linenineQuestion:当前关卡数：%d",gameIdLineNineQuestion);
    NSLog(@"linenineQuestion:目前答的是题目：%d",questionIndex);
    NSLog(@"linenineQuestion:此页面要显示的内容如下：");
    
    //从这9道题中抽取出所答题的内容
    lineNineQuestion = [questionsLineNineQuestion objectAtIndex:questionIndex];
    
    NSLog(@"linenineQuestionID:%d",lineNineQuestion.questionId);//问题ID
    NSLog(@"linenineQuestion题干:%@",lineNineQuestion.question);//问题
    NSLog(@"linenineQuestion选项1:%@",lineNineQuestion.answer1);
    NSLog(@"linenineQuestion选项2:%@",lineNineQuestion.answer2);
    NSLog(@"linenineQuestion选项3:%@",lineNineQuestion.answer3);
    NSLog(@"linenineQuestion正确答案:%d",lineNineQuestion.answerRight);
    NSLog(@"linenineQuestion通关秘籍ID:%d",lineNineQuestion.helpId);//通关秘籍ID
    
    
    //题干赋值
    [_lineNineQuestionLabel setText:lineNineQuestion.question];
    //判断选项个数，给前台赋值
    [_lineNineAnswer1 setTitle:lineNineQuestion.answer1 forState:UIControlStateNormal];
    [_lineNineAnswer2 setTitle:lineNineQuestion.answer2 forState:UIControlStateNormal];
//    NSLog(@"选项个数：%d",lineNineQuestion.answerNum);
//    if (lineNineQuestion.answerNum == 2) {//当选项为两个时
//        _lineNineAnswer3.hidden = true;
//    }else{//当选项为三个时
//        [_lineNineAnswer3 setTitle:lineNineQuestion.answer3 forState:UIControlStateNormal];
//    }

    if (lineNineQuestion.questionType == 0){//选择题
        [self imageShow];
    }else if (lineNineQuestion.questionType == 1){//音乐题
        [self musicShow];
    }else if (lineNineQuestion.questionType == 2){//图片题1，题干加载图片
        [self imageShow];
        UIImage *image = [UIImage imageNamed:@"QueImage-1.png"];
        self.lineNineQuestionImage.image = image;
        self.lineNineQuestionImage.contentMode = UIViewContentModeScaleAspectFit;
        
    }else if (lineNineQuestion.questionType == 3){//图片题2，题干加载图片
        [self imageShow];
        UIImage *image = [UIImage imageNamed:@"QueImage-2.png"];
        self.lineNineQuestionImage.image = image;
        self.lineNineQuestionImage.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    //判断是否出现通关秘籍按钮
    if (lineNineQuestion.helpId != 0){//有通关秘籍则在界面上显示通关秘籍按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, 80, 120, 60);
        
        //设置button标题及其颜色
        [btn setTitle:@"通 关 秘 籍" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        
        //设置button填充图片
        [btn setBackgroundImage:[UIImage imageNamed:@"buttonBkg.png"] forState:UIControlStateNormal];

        //按下按钮，并且手指离开屏幕的时候触发这个事件，跟web中的click事件一样。触发了这个事件以后，执行butClick:这个方法，addTarget:self 的意思是说，这个方法在本类中也可以传入其他类的指针
        [btn addTarget:self action:@selector(gotoLineNineCheat) forControlEvents:UIControlEventTouchUpInside];
        
        //显示控件
        [self.view addSubview:btn];
    }

}

//图片按钮显示控制
-(void)imageShow{
    _lineNineAnswer1.hidden = false;
    _lineNineAnswer2.hidden = false;
//    _lineNineAnswer3.hidden = false;
    NSLog(@"选项个数：%d",lineNineQuestion.answerNum);
    if (lineNineQuestion.answerNum == 2) {//当选项为两个时
        _lineNineAnswer3.hidden = true;
    }else{//当选项为三个时
        [_lineNineAnswer3 setTitle:lineNineQuestion.answer3 forState:UIControlStateNormal];
    }
    
    _lineNineMusic1.hidden = true;
    _lineNineMusic2.hidden = true;
    _lineNineMusic3.hidden = true;
    
    _lineNineQuestionImage.hidden = false;
}
//音乐按钮显示控制
-(void)musicShow{
    _lineNineAnswer1.hidden = false;
    _lineNineAnswer2.hidden = false;
//    _lineNineAnswer3.hidden = false;
    NSLog(@"选项个数：%d",lineNineQuestion.answerNum);
    if (lineNineQuestion.answerNum == 2) {//当选项为两个时
        _lineNineAnswer3.hidden = true;
    }else{//当选项为三个时
        [_lineNineAnswer3 setTitle:lineNineQuestion.answer3 forState:UIControlStateNormal];
    }
    
    _lineNineMusic1.hidden = false;
    _lineNineMusic2.hidden = false;
    _lineNineMusic3.hidden = false;
    
    _lineNineQuestionImage.hidden = true;
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
    [PlayMusicImpl stopMusic:self.songs[_preIndex1]];
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

//歌曲初始化
-(NSArray *)songs
{
    if (_songs==nil){
        self.songs=@[@"QueMusic-1.mp3",@"QueMusic-2.mp3",@"QueMusic-3.mp3"];
    }
    return _songs;
}

- (IBAction)play1:(id)sender {
    _music1++;
    _currentIndex = 0;
    
    //关掉其他音乐
    if (_music2 %2 == 1) {
        _music2++;
        if (_music3 %2 == 1) {
            _music3++;
        }
    }
    [self stopOthers];
    
    //播放音乐1
    if (_music1 %2 == 1) {
        [self play];
        _preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
    
}

- (IBAction)play2:(id)sender {
    _music2++;
    _currentIndex = 1;
    
    //关掉其他音乐
    if (_music1 %2 == 1) {
        _music1++;
        if (_music3 %2 == 1) {
            _music3++;
        }
    }
    [self stopOthers];
    
    //播放音乐2
    if (_music2 %2 == 1) {
        [self play];
        _preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
    
}

- (IBAction)play3:(id)sender {
    _music3++;
    _currentIndex = 2;
    
    //关掉其他音乐
    if (_music1 %2 == 1) {
        _music1++;
        if (_music2 %2 == 1) {
            _music2++;
        }
    }
    [self stopOthers];
    
    //播放音乐3
    if (_music3 %2 == 1) {
        [self play];
        _preIndex1 = _currentIndex;
    }else{
        [self stop];
    }
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
        
        //[self prompt:@"恭喜你，答对啦！"];
        [self createSelfPrompt:@"恭喜你，答对啦！" image:[UIImage imageNamed:@"happy.jpg"]];

    }else {
        NSLog(@"错误");
        if (lineNineQuestion.helpId == 0) {
            [self createSelfPrompt:@"很抱歉，回答错误，请重新答题！" image:[UIImage imageNamed:@"sad.jpg"]];
          //  [self promptNoCheats:@"很抱歉回答错误，请重新答题！"];
        }else{
            [self createSelfPrompt3:@"很抱歉，答错了！去看看通关秘籍吧！" image:[UIImage imageNamed:@"sad.jpg"]];
          //  [self promptCheats:@"很抱歉，答错了！去看看通关秘籍吧！"];
        }
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

- (void) stopAllMusic{
    //音乐全部暂停
    if(_music1 %2 == 1){
        _music1++;
        [self stop];
    }
    if(_music2 %2 == 1){
        _music2++;
        [self stop];
    }
    if(_music3 %2 == 1){
        _music3++;
        [self stop];
    }
    
}


- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self stopAllMusic];
    
    if(cheatQuestionJump == 1){//答对，返回LineNine并翻转拼图
        [self goBackLineNine:lineNineAnswerStateArray];
    }
    if(cheatQuestionJump ==2){//答错，跳到通关秘籍界面
        if(buttonIndex == 0){
            [self goBackLineNine:lineNineAnswerStateArray];
        }else{
            //跳转到通关秘籍
            [self lineNineCheat];
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

//跳到通关秘籍
- (void)lineNineCheat{
    //音乐全部暂停
    [self stopAllMusic];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Cheats *cheat = [mainStoryboard instantiateViewControllerWithIdentifier:@"Cheats"];
    
    cheat.user = userLineNineQuestion;
    cheat.helpId = lineNineQuestion.helpId;
    
    [cheat setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:cheat animated:YES completion:nil];
    
}

//直接跳转到通关秘籍
- (void) gotoLineNineCheat{
    //音乐全部暂停
    [self stopAllMusic];
    
    [self lineNineCheat];
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

