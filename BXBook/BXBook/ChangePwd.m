//
//  ChangePwd.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "ChangePwd.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation ChangePwd


User* userChangePwd;

- (void)viewDidLoad {
    [super viewDidLoad];
    userChangePwd = self.user;
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userChangePwd.userId;
    behaviour.doWhat = @"浏览－修改密码";
    behaviour.doWhere = @"ChangePwd-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}
- (IBAction)inputOldPwd:(id)sender {
    [_oldPwdText setText:nil];
    [_oldPwdText setTextColor:[UIColor blackColor]];
}

- (IBAction)inputNewPwd:(id)sender {
    [_pwdText setText:nil];
    [_pwdText setTextColor:[UIColor blackColor]];
}

- (IBAction)inputNewPwd2:(id)sender {
    [_pwdText2 setText:nil];
    [_pwdText2 setTextColor:[UIColor blackColor]];
}

- (IBAction)changePwd:(id)sender {
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userChangePwd.userId;
    behaviour.doWhat = @"修改密码";
    behaviour.doWhere = @"ChangePwd-(IBAction)changePwd:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    if (_oldPwdText.text == nil || _pwdText == nil || _pwdText2 == nil || [_oldPwdText.text isEqualToString:@""] || [_pwdText.text isEqualToString:@""] || [_pwdText2.text isEqualToString:@""]) {
        [self createSelfPrompt:@"输入不完整" image:[UIImage imageNamed:@"sad.jpg"]];
    } else if([_pwdText.text isEqualToString:_pwdText2.text]){
        NSLog(@"11111:%d",[UserDao changePassword:userChangePwd.loginName pwd:_pwdText.text] );
        if([UserDao changePassword:userChangePwd.loginName pwd:_pwdText.text] == 1){
            [self createSelfPrompt:@"密码修改成功" image:[UIImage imageNamed:@"happy.jpg"]];
        }else [self createSelfPrompt:@"密码修改失败" image:[UIImage imageNamed:@"sad.jpg"]];
    }else
        [self createSelfPrompt:@"两次输入的新密码不一致" image:[UIImage imageNamed:@"sad.jpg"]];
    
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userChangePwd.userId;
    behaviour.doWhat = @"浏览－测拉";
    behaviour.doWhere = @"ChangePwd-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userChangePwd;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userChangePwd;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userChangePwd;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userChangePwd;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}



@end