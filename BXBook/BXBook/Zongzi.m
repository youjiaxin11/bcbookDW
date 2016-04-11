//
//  Zongzi.m
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Zongzi.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"
@interface Zongzi()
@end

@implementation Zongzi
@synthesize user,buttonz;
User *userZongzi;
- (void)viewDidLoad {
    [super viewDidLoad];
    userZongzi = self.user;
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userZongzi.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Zongzi-(void)viewDidLoad"];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    [self prompt:@"恭喜你成功制作一个粽子啦！" ];
    UIImage *image1=[UIImage imageNamed:@"zongzi"];
    [buttonz setBackgroundImage:image1 forState:UIControlStateNormal];
    
    
    
}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
       usercenter.user = userZongzi;
        [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:usercenter animated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    usercenter.user = userZongzi;
    [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:usercenter animated:YES completion:nil];
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
    behaviour.userId = userZongzi.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"Zongzi-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userZongzi;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userZongzi;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userZongzi;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userZongzi;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}



@end
