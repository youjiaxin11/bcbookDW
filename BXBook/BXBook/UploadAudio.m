//
//  UploadAudio.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UploadAudio.h"
#define kRecordAudioFile @"myRecord.caf"

@implementation UploadAudio

User* userUploadAudio;
Task* taskUploadAudio;
NSString* str1;
NSString* str2;
NSString* str3;
NSString* str4;
NSString* taskTitle_audio;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUploadAudio = self.user;
    taskUploadAudio = self.task;
    
    if (taskUploadAudio == nil) {
        taskTitle_audio = @"说说";
    }else{
        taskTitle_audio = taskUploadAudio.taskTitle;
    }
     NSLog(@"tasktitle:%@",taskTitle_audio);
    NSString* timeNow = [TimeUtil getTimeNow];
    NSLog(@"%@%d",userUploadAudio.loginName,taskUploadAudio.taskId);
    str1 = [userUploadAudio.loginName stringByAppendingString:@"+"];
    str2 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%@+",taskTitle_audio]];
    str3 = [str2 stringByAppendingString:timeNow];
    str4 = [str3 stringByAppendingString:@"+audio.caf"];
    [self setAudioSession];
    NSLog(@"@audio : %@",userUploadAudio.loginName);
    

    
    //记录行为数据
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUploadAudio.userId;
    behaviour.doWhat = @"浏览－上传音频";
    behaviour.doWhere = @"UploadAudio-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
}

//上传作品
- (IBAction)uploadWorks:(id)sender{
    [self createSelfPrompt:@"已保存在本地，去“我的作品”中查看吧！" image:[UIImage imageNamed:@"happy.jpg"]];
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - 私有方法
/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:str4];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}
#pragma mark - UI事件
/**
 *  点击录音按钮
 *
 *  @param sender 录音按钮
 */
- (IBAction)recordClick:(UIButton *)sender {
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }
}

/**
 *  点击暂定按钮
 *
 *  @param sender 暂停按钮
 */
- (IBAction)pauseClick:(UIButton *)sender {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate=[NSDate distantFuture];
    }
}

/**
 *  点击恢复按钮
 *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
 *
 *  @param sender 恢复按钮
 */
- (IBAction)resumeClick:(UIButton *)sender {
    [self recordClick:sender];
}

/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (IBAction)stopClick:(UIButton *)sender {
    [self.audioRecorder stop];
    self.timer.fireDate=[NSDate distantFuture];
    self.audioPower.progress=0.0;

}

#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    NSLog(@"录音完成!");
    
    NSString* timeNow = [TimeUtil getTimeNow];
//    str1 = [userUploadAudio.loginName stringByAppendingString:@"+"];
//    str2 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%@+", taskTitle_audio]];
//    str3 = [str2 stringByAppendingString:timeNow];
//    str4 = [str3 stringByAppendingString:@"+audio.caf"];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str4];   // 保存文件的名称
    
    MyWork *work = [[MyWork alloc]init];
    work.workId = 100;
    work.userId = userUploadAudio.userId;
    work.taskTitle = taskTitle_audio;
    work.type = 3;
    work.uploadTime = timeNow;
    work.filePath = str4;
    
    NSLog(@"----即将上传音频的作品");
    NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
    [MyWorkDao addMyWork:work.workId andUserId:work.userId andTaskTitle:work.taskTitle andUploadTime:work.uploadTime andType:work.type andFilePath:work.filePath];
    //获取当前时间
//    NSString* timeNow = [TimeUtil getTimeNow];
    [WorkDao insertWork:userUploadAudio.userId taskId:taskUploadAudio.taskId taskUrl:nil recPN:0 recCN:0 golden:0 uplT:timeNow score:0 loca:0];
    
    //记录行为数据
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUploadAudio.userId;
    behaviour.doWhat = @"上传音频－本地";
    behaviour.doWhere = @"UploadAudio-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
