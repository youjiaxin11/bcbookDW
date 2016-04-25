//
//  UserCenter.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UserCenter.h"
#import "PersonalData.h"
#import "NotebookController.h"

@interface UserCenter ()<AVAudioPlayerDelegate>
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property(nonatomic,strong)NSArray *songs;//用一个数组来保存所有的音乐文件
@end


@implementation UserCenter
@synthesize admDataCen;

User* userUserCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self play];
    userUserCenter = self.user;
    if ([userUserCenter.loginName isEqualToString:@"admin"]) {
    }else{
        admDataCen.hidden = YES;
    }
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUserCenter.userId;
    behaviour.doWhat = @"浏览－个人中心";
    behaviour.doWhere = @"UserCenter-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    [self stop];
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUserCenter.userId;
    behaviour.doWhat = @"浏览－测拉";
    behaviour.doWhere = @"UserCenter-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userUserCenter;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userUserCenter;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userUserCenter;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userUserCenter;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self stop];
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = userUserCenter;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];    }
}

//学习轨迹
- (IBAction)learningTrack:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LearningRecord *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LearningRecord"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//我的好友
- (IBAction)myFriends:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyFriend *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyFriend"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//我的作品
- (IBAction)myWorks:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyWorks *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyWorks"];
    nextpage.user = userUserCenter;
    nextpage.pageType = 1;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//伙伴排行
- (IBAction)friendsRank:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendLevel *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"FriendLevel"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//个人信息
- (IBAction)userInfo:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfo *userinfo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserInfo"];
    userinfo.user = userUserCenter;
    [userinfo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:userinfo animated:YES completion:nil];
}

//修改密码
- (IBAction)changePassword:(id)sender{
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangePwd *changepwd = [mainStoryboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    changepwd.user = userUserCenter;
    [changepwd setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:changepwd animated:YES completion:nil];
}
//跳转到数据中心
- (IBAction)dataCenter:(id)sender {
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalData *next = [mainStoryboard instantiateViewControllerWithIdentifier:@"PersonalData"];
    next.user = userUserCenter;
    [next setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:next animated:YES completion:nil];

}
- (IBAction)goBack:(id)sender {
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
    information.user = userUserCenter;
    [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:information animated:YES completion:nil];
}
- (IBAction)mybag:(UIButton *)sender {
    [self stop];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   Mybag *mybag = [mainStoryboard instantiateViewControllerWithIdentifier:@"Mybag"];
  mybag.user = userUserCenter;
    [mybag setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:mybag animated:YES completion:nil];
    
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
        self.songs=@[@"6.mp3"];
    }
    return _songs;
}
@end
