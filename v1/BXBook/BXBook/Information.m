//
//  Information.m
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "Information.h"
#import "PlayMusicImpl.h"
#import <AVFoundation/AVFoundation.h>

@interface Information()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件

@end

@interface Information ()

@end

@implementation Information

User *userInformation;
UITextView *informationIntroduce;
int firstLogin = 0;//首次登录
int taskCard = 0;//点击选择任务卡

int finishgameId5;//当前完成的游戏关卡号
- (void)viewDidLoad {
    [super viewDidLoad];
    
    userInformation = self.user;
   // informationIntroduce = self.introduce;
    finishgameId5=self.finishgameId4;
    if( userInformation.loginTimes==1)
    {
        firstLogin = 1;
        [self prompt:@"友情提示：向右滑动页面可以返回哦"] ;
        
    }
    NSLog(@"information：从上个页面传过来的角色：%d", _user.role);
    
   

    
    // 设定位置和大小
    CGRect frame = CGRectMake(0,0,0,0);
    frame.size = [UIImage imageNamed:@"兔爷－规则介绍GIF.gif"].size;
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"兔爷－规则介绍GIF" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
    
    //播放音乐
    [self play];
    
    // textview 改变字体的行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    
    informationIntroduce = [[UITextView alloc]initWithFrame:CGRectMake(350, 180, 550, 300)];
    [informationIntroduce setBackgroundColor:[UIColor clearColor]];
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:25],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    informationIntroduce.attributedText = [[NSAttributedString alloc] initWithString:@"6个关卡，2个难度等级。\n连线题、拼图题和射击题。\n1颗星：每个小游戏获得1枚金币。\n2颗星：每个小游戏获得2枚金币。\n每个任务卡消耗2枚金币。\n上传作品，获得3枚金币。\n作品收到的赞越多，金币数也越多。" attributes:attributes];
    
    [self.view addSubview:informationIntroduce];
    
   
}

//点击选择关卡按钮
- (IBAction)gameChocie:(id)sender{
    //音乐暂停
    [self stop];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameChoice *gamechoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameChoice"];
    gamechoice.user = userInformation;
    gamechoice.finishgameId2=finishgameId5;
    [gamechoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:gamechoice animated:YES completion:nil];
}

//点击个人中心按钮
- (IBAction)userCenter:(id)sender{
    //音乐暂停
    [self stop];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    usercenter.user = userInformation;
    [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:usercenter animated:YES completion:nil];
}

//直接跳到任务卡
- (IBAction)gotoTask:(id)sender {
    taskCard = 1;
    //音乐暂停
    [self stop];
    [self prompt2:@"建议先闯关答题，获得足够的金币才能做任务哟。确定要开启任务卡吗？"];
    
   
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (taskCard == 1 ) {
        if(buttonIndex==0){
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TaskChoice *taskChoice = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskChoice"];
            taskChoice.user = userInformation;
            [taskChoice setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:taskChoice animated:YES completion:nil];
           
        }
    }
    taskCard = 0;
    firstLogin = 0;
}

//音乐播放控制
- (void)play {
    //开始播放/继续播放
    [PlayMusicImpl playMusic:self.songs[0]];
}

- (void)stop {
    //停止播放
    [PlayMusicImpl stopMusic:self.songs[0]];
}

//歌曲初始化
-(NSArray *)songs
{
    if (_songs==nil) {
        self.songs=@[@"1.m4a"];
    }
    return _songs;
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    //音乐暂停
    [self stop];
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginView *loginview = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [loginview setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:loginview animated:YES completion:nil];
    }
}


@end