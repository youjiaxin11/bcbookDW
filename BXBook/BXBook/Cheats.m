//
//  Cheats.m
//  BXBook
//
//  Created by xiaoqi on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "Cheats.h"
#import "VideoPlay.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation Cheats

@synthesize
task,//任务卡
helpId;//通关秘籍ID

/*开发者在页面操作中，用这几个值*/
User *userCheats;//当前登录用户
//Game *gameCheats;//当前游戏对象，存有所有题目及答案
Task *taskCheats;
//int cheatflag;
//int index1;
//int helpIdNow = 1;//记录当前题目的helpId，初始默认为1
//MPMoviePlayerViewController *movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    userCheats = self.user;
    //gameCheats = self.game;
    taskCheats =self.task;
    //cheatflag = self.flag1cheat;
    //index1 =self.index;
    NSLog(@"当前登录用户：%@",userCheats.loginName);
    NSLog(@"通关秘籍ID：%d",helpId);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userCheats.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Cheats-(void)viewDidLoad-任务id:%d", taskCheats.taskId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];

    
//    //通过gameChoice判断helpId
//
//    if(cheatflag == 1){//连线题
//        helpIdNow = gameCheats.line.helpId;
//    }else if(cheatflag == 3){//射击
//        helpIdNow = gameCheats.shoot.helpId;
//    }else if(cheatflag == 2){//拼图
//        if (index1 == 1) {
//            helpIdNow = gameCheats.puzzle.helpId1;
//        }else if(index1 == 2) {
//            helpIdNow = gameCheats.puzzle.helpId2;
//        }else if(index1 == 3) {
//            helpIdNow = gameCheats.puzzle.helpId3;
//        }else if(index1 == 4) {
//            helpIdNow = gameCheats.puzzle.helpId4;
//        }
//    }else if(cheatflag == 4){//任务卡
//        helpIdNow = taskCheats.helpId;
//        NSLog(@"^^^^^^^^^:%d",helpIdNow);
//    }
    
    //以下为在页面显示通关秘籍
    Help* help = [HelpDao findHelpByHelpId:helpId];
    NSLog(@"helpId:%d.helpType:%d",helpId, help.helpType);
    if (help.helpType == 1) {//答题对应的文字形式通关秘籍
        UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(180, 220, 700, 500)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:28],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        textView.attributedText = [[NSAttributedString alloc] initWithString:help.helpUrl attributes:attributes];
        textView.backgroundColor = [UIColor clearColor];//设置它的背景颜色
        textView.scrollEnabled = YES;//是否可以拖动
        textView.editable =NO;//禁止编辑
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        [self.view addSubview: textView];//加入到整个页面中
        //    }else if (help.helpType == 2){//图片
        //        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(140, 110, 768, 576)];
        //        NSString* helpIdNowStr = [NSString stringWithFormat:@"%d", helpId];
        //        NSString* fileName = [@"Cheat" stringByAppendingString:helpIdNowStr];//根据helpId动态拼接文件名
        //        NSString* fileName2 = [fileName stringByAppendingString:@".png"];
        //        [imageView setImage:[UIImage imageNamed:fileName2]];
        //        [self.view addSubview:imageView];
//    }else if (help.helpType == 2){//任务卡里面的对应的微课
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        btn.frame = CGRectMake(400, 360, 200, 70);
//        [btn setTitle:@"点击播放微课" forState:UIControlStateNormal];
//        [btn setTitle:@"点击播放微课" forState:UIControlStateHighlighted];
//        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
//        [btn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
    }
    
    //更新通关秘籍浏览人次
    if (help.viewTimes>=0) {
        help.viewTimes++;
    }else{
        help.viewTimes=1;
    }
    [HelpDao updateHelpViewTimes:help];
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
    behaviour.userId = userCheats.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"Cheats-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userCheats;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userCheats;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userCheats;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userCheats;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}
//-(void)playVideo{
//    
//    //记录行为数据
//    NSString* timeNow = [TimeUtil getTimeNow];
//    Behaviour *behaviour = [[Behaviour alloc]init];
//    behaviour.userId = userCheats.userId;
//    behaviour.doWhat = @"查看微课";
//    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Cheats-(void)playVideo-任务id:%d", taskCheats.taskId];
//    behaviour.doWhen = timeNow;
//    [BehaviourDao addBehaviour:behaviour];
//    
//    NSString* helpIdNowStr = [NSString stringWithFormat:@"%d", helpId];
//    NSString* fileName = [@"Weike" stringByAppendingString:helpIdNowStr];//根据helpId动态拼接文件名
//    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
// //   NSString *path = [[NSBundle mainBundle] pathForResource:@"Cheat18" ofType:@"mp4"];
//    //视频URL
//    NSURL *url = [NSURL fileURLWithPath:path];
//    //视频播放对象
//    movie = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//    [self presentMoviePlayerViewControllerAnimated:movie];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(myMovieFinishedCallback:)
//                                                 name: MPMoviePlayerPlaybackDidFinishNotification
//                                               object:nil];
//    
//}
//
//-(void)myMovieFinishedCallback:(NSNotification *)aNotification
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:MPMoviePlayerPlaybackDidFinishNotification
//                                                  object:nil];
//    [movie  dismissMoviePlayerViewControllerAnimated];
//    [movie.moviePlayer stop];
//    movie.moviePlayer.initialPlaybackTime = -1.0;
//    movie = nil;
//}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"leftn");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end