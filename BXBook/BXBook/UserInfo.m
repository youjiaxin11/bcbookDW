//
//  UserInfo.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UserInfo.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation UserInfo


User* userUserInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUserInfo = self.user;
    [_realNameLbl setText:userUserInfo.realName];
    [_loginNameLbl setText:userUserInfo.loginName];
    
    if(userUserInfo.school == 1)
        [_schoolLbl setText:@"白家庄小学本部"];
    else if(userUserInfo.school == 2)
        [_schoolLbl setText:@"白家庄小学第一分校"];
    else if(userUserInfo.school == 3)
        [_schoolLbl setText:@"白家庄小学第二分校"];

    [_gradeLbl setText:[NSString stringWithFormat:@"%d年级", userUserInfo.grade]];
    [_classLbl setText:[NSString stringWithFormat:@"%d班", userUserInfo.classNum]];
    [_goldenLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.golden]];
    [_revPraiseLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.receivePraiseNum]];
    [_senPraiseLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.sendPraiseNum]];
    [_revComLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.receiveCommentNum]];
    [_senComLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.sendCommentNum]];
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userUserInfo.userId;
    behaviour.doWhat = @"浏览－个人信息";
    behaviour.doWhere = @"UserInfo-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
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
    behaviour.userId = userUserInfo.userId;
    behaviour.doWhat = @"浏览－测拉";
    behaviour.doWhere = @"UserInfo-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userUserInfo;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userUserInfo;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userUserInfo;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userUserInfo;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
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
