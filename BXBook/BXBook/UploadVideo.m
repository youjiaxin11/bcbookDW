//
//  UploadVideo.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UploadVideo.h"


@implementation UploadVideo
@synthesize lastChosenMediaType;
@synthesize urlStr;
@synthesize player;
@synthesize contentimageview;
MPMoviePlayerViewController *movieUpload;


User* userUploadVideo;
Task* taskUploadVideo;
NSString* str1_video;
NSString* str2_video;
NSString* str3_video;
NSString* str4_video;
NSString* taskTitle_video;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUploadVideo = self.user;
    taskUploadVideo = self.task;
    
    if (taskUploadVideo == nil) {
        taskTitle_video = @"随手拍";
    }else{
        taskTitle_video = taskUploadVideo.taskTitle;
    }
    NSLog(@"tasktitle:%@",taskTitle_video);

    contentimageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [contentimageview addGestureRecognizer:singleTap];
    NSLog(@"@video : %@",userUploadVideo.loginName);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUploadVideo.userId;
    behaviour.doWhat = @"浏览－上传视频";
    behaviour.doWhere = @"UploadVideo-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer{
    if (urlStr == nil) {
            [self createSelfPrompt:@"未上传视频" image:[UIImage imageNamed:@"sad.jpg"]];
    }else{
        //VideoPlay* videoplay;
        //[videoplay Play:urlStr];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        //视频播放对象
        movieUpload = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:movieUpload];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name: MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        movieUpload = nil;
    }
}




-(void)myMovieFinishedCallback:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [movieUpload  dismissMoviePlayerViewControllerAnimated];
    [movieUpload.moviePlayer stop];
    movieUpload.moviePlayer.initialPlaybackTime = -1.0;
    movieUpload = nil;
}

- (IBAction)addVideo:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择视频来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍摄",@"从手机相册选择", nil];
    [alert show];
}

#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPiicturePrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持视频格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
    
    
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        NSLog(@"video...");
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
        
        //获取当前时间
        NSString* timeNow = [TimeUtil getTimeNow];
        [WorkDao insertWork:userUploadVideo.userId taskId:taskUploadVideo.taskId taskUrl:nil recPN:0 recCN:0 golden:0 uplT:timeNow score:0 loca:0];
        
        //保存到本地沙盒
        //保存在本机沙盒
        str1_video = [userUploadVideo.loginName stringByAppendingString:@"+"];
        str2_video = [str1_video stringByAppendingString:[NSString stringWithFormat:@"%@+", taskTitle_video]];
        str3_video = [str2_video stringByAppendingString:timeNow];
        str4_video = [str3_video stringByAppendingString:@"+video.mp4"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:str4_video];   // 保存文件的名称
        
        MyWork *work = [[MyWork alloc]init];
        work.workId = 100;
        work.userId = userUploadVideo.userId;
        work.taskTitle = taskTitle_video;
        work.type = 2;
        work.uploadTime = timeNow;
        work.filePath = str4_video;
        
        //[MyWorkDao addMyWork:work];
     //   [UIImagePNGRepresentation(chosenImage) writeToFile: filePath  atomically:YES];
        NSData  *myData = [[NSData  alloc] initWithContentsOfFile: urlStr ];
        [myData writeToFile:filePath atomically: YES ];
        
        NSLog(@"----即将上传视频的作品");
        NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        [MyWorkDao addMyWork:work.workId andUserId:work.userId andTaskTitle:work.taskTitle andUploadTime:work.uploadTime andType:work.type andFilePath:work.filePath];
        
        //记录行为数据
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = userUploadVideo.userId;
        behaviour.doWhat = @"上传视频－本地";
        behaviour.doWhere = @"UploadVideo-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];

        
        
        //录制完之后自动播放
        player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:player];
    //    playerLayer.frame=self.contentimageview.frame;
        playerLayer.frame=CGRectMake(0, 0, self.contentimageview.frame.size.width, self.contentimageview.frame.size.height);
        [self.contentimageview.layer addSublayer:playerLayer];
        [player play];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeMovie;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }

}


//上传作品
- (IBAction)uploadWorks:(id)sender{
        [self createSelfPrompt:@"已保存在本地，去“我的作品”中查看吧！" image:[UIImage imageNamed:@"happy.jpg"]];
}


//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}

-(void) imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:(NSError*)error contexInfo:(void*) contextInfo{
    if (!error) {
       //[self createSelfPrompt:@"成功保存到本地相册" image:[UIImage imageNamed:@"happy.jpg"]];
    }else {
        //[self createSelfPrompt:[error description] image:[UIImage imageNamed:@"sad.jpg"]];
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
