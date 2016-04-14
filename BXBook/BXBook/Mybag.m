//
//  Mybag.m
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mybag.h"
#import "XYZPhoto.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"
#define IMAGEWIDTH 360
#define IMAGEHEIGHT 480
@interface Mybag()
@end


@implementation Mybag
@synthesize user,presentaward,baward1,baward2,baward3,baward4,baward5,baward6;

User *userMybag;
//int finishgameIdm1;
- (void)viewDidLoad {
    [super viewDidLoad];
    userMybag = self.user;
    //finishgameIdm1=self.finishgameIdm;
    baward1.hidden=YES;
    baward2.hidden=YES;
    baward3.hidden=YES;
    baward4.hidden=YES;
    baward5.hidden=YES;
    baward6.hidden=YES;
    presentaward.hidden=YES;
       //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userMybag.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Mybag-(void)viewDidLoad"];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    self.photos = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
        float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
        float W = IMAGEWIDTH;
        float H = IMAGEHEIGHT;
        
        XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        //[photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
        NSString *name1 = @"award";
        NSString *name2 = [NSString stringWithFormat:@"%d.png", i+1];
        NSString *name3 = [name1 stringByAppendingString:name2];
        UIImage *photoImage = [UIImage imageNamed:name3];
        //CGSize OriginSize = photoImageOrigin.size;
        //UIImage *photoImage = [self image:photoImageOrigin centerInSize:CGSizeMake(OriginSize.width/5,OriginSize.height/5)];
        [photo updateImage:photoImage];
        photo.photoId = i+1;
        [self.view addSubview:photo];
        
        float alpha = i*1.0/10 + 0.2;
        [photo setImageAlphaAndSpeedAndSize:alpha];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage2:)];
        [photo addGestureRecognizer:tap];
        
        [self.photos addObject:photo];
    }
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
}
- (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize
{
    UIGraphicsBeginImageContext(CGSizeMake(viewsize.width, viewsize.height));
    [image drawInRect:CGRectMake(0, 0, viewsize.width, viewsize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

- (void)doubleTap {
    
    NSLog(@"DoubleTap...........");
    
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            NSLog(@"zhuangtai1");
            baward1.hidden=YES;
            baward2.hidden=YES;
            baward3.hidden=YES;
            baward4.hidden=YES;
            baward5.hidden=YES;
            baward6.hidden=YES;
            presentaward.hidden=YES;
            
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 4;
    float H = self.view.bounds.size.height / 4;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                 NSLog(@"zhuangtai2");
                baward1.hidden=YES;
                baward2.hidden=YES;
                baward3.hidden=YES;
                baward4.hidden=YES;
                baward5.hidden=YES;
                baward6.hidden=YES;
                presentaward.hidden=YES;
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W+130, i/3*H+110, W, H);//修改双击图片的位置和大小
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
                [self allcount];
              
                
            } else if (photo.state == XYZPhotoStateTogether) {
                 NSLog(@"zhuangtai3");
                baward1.hidden=YES;
                baward2.hidden=YES;
                baward3.hidden=YES;
                baward4.hidden=YES;
                baward5.hidden=YES;
                baward6.hidden=YES;
                presentaward.hidden=YES;
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
                
                
                
            }
        }
        
    }];
   
   
  
    
}

- (void)singleTap {
    
    NSLog(@"SingleTap...........");
    
    for (XYZPhoto *photo in self.photos) {
//        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateTogether)
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateTogether) {
             NSLog(@"zhuangtai5");
            baward1.hidden=YES;
            baward2.hidden=YES;
            baward3.hidden=YES;
            baward4.hidden=YES;
            baward5.hidden=YES;
            baward6.hidden=YES;
            presentaward.hidden=YES;
            return;
        }
    }
    
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateBig) {
                 NSLog(@"zhuangtai6");
                baward1.hidden=YES;
                baward2.hidden=YES;
                baward3.hidden=YES;
                baward4.hidden=YES;
                baward5.hidden=YES;
                baward6.hidden=YES;
                presentaward.hidden=YES;
                photo.frame = photo.oldFrame;
                photo.alpha = photo.oldAlpha;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }
        
    }];
    
}


- (void)tapImage2:(UIGestureRecognizer*)sender {
    
    XYZPhoto *photo = sender.view;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (photo.state == XYZPhotoStateNormal) {
             NSLog(@"zhuangtai7");
            photo.oldFrame = photo.frame;
            photo.oldAlpha = photo.alpha;
            photo.oldSpeed = photo.speed;
            photo.frame = CGRectMake(50, 120, photo.superview.bounds.size.width - 250, photo.superview.bounds.size.height - 250);//修改单击图片的位置和大小
            photo.imageView.frame = photo.bounds;
            photo.drawView.frame = photo.bounds;
            [photo.superview bringSubviewToFront:photo];
            photo.speed = 0;
            photo.alpha = 1;
            photo.state = XYZPhotoStateBig;
            //取不同奖励的个数，并呈现在前台
            NSString *stringawardcount=[[NSString alloc]init];
            if(photo.photoId==1)stringawardcount= [NSString stringWithFormat:@"%d",userMybag.award1];
            if(photo.photoId==2) stringawardcount=[ NSString stringWithFormat:@"%d",userMybag.award2];
            if(photo.photoId==3)stringawardcount=[ NSString stringWithFormat:@"%d",userMybag.award3];
            if(photo.photoId==4)stringawardcount=[ NSString stringWithFormat:@"%d",userMybag.award4];
            if(photo.photoId==5)stringawardcount=[ NSString stringWithFormat:@"%d",userMybag.award5];
            if(photo.photoId==6)stringawardcount=[ NSString stringWithFormat:@"%d",userMybag.award6];
            baward1.hidden=YES;
            baward2.hidden=YES;
            baward3.hidden=YES;
            baward4.hidden=YES;
            baward5.hidden=YES;
            baward6.hidden=YES;
            presentaward.hidden=NO;
            presentaward.text = stringawardcount;
            [presentaward setBackgroundColor:[UIColor clearColor]];
            
        }
        
//        
//        else if (photo.state == XYZPhotoStateBig || photo.state == XYZPhotoStateTogether)
         else if (photo.state == XYZPhotoStateBig ){
            NSLog(@"zhuangtai8");
            NSLog(@"跳转photoId:%d",photo.photoId);
            photo.frame = photo.oldFrame;
            photo.alpha = photo.oldAlpha;
            photo.speed = photo.oldSpeed;
            photo.imageView.frame = photo.bounds;
            photo.drawView.frame = photo.bounds;
            photo.state = XYZPhotoStateNormal;
            baward1.hidden=YES;
            baward2.hidden=YES;
            baward3.hidden=YES;
            baward4.hidden=YES;
            baward5.hidden=YES;
            baward6.hidden=YES;
            presentaward.hidden=YES;
            
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
        usercenter.user = userMybag;
        [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:usercenter animated:YES completion:nil];    }
}
//跳转到下一页
-(void)nextpage1{
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Makezongzi* makezongzi = [mainStoryboard instantiateViewControllerWithIdentifier:@"Makezongzi"];
    makezongzi.user = userMybag;
    [makezongzi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:makezongzi animated:YES completion:nil];
}

- (IBAction)Makezongzi:(UIButton *)sender {
    if(userMybag.award1>=1&&userMybag.award2>=1&&userMybag.award3>=1&&userMybag.award4>=1&&userMybag.award5>=1&&userMybag.award6>=1)
    { [self nextpage1];}
    else {
        [self createSelfPrompt:@"很抱歉你还没有齐集制作粽子的所有奖励材料，请去闯关赢去奖励吧！" image:[UIImage imageNamed:@"sad.jpg"]];
    }
}


-(void)allcount{
    //前台显示六种奖励的个数
    presentaward.hidden=YES;
    baward1.hidden=NO;
    baward2.hidden=NO;
    baward3.hidden=NO;
    baward4.hidden=NO;
    baward5.hidden=NO;
    baward6.hidden=NO;
    
    NSString *stringaward1=[[NSString alloc]init];
    NSString *stringaward2=[[NSString alloc]init];
    NSString *stringaward3=[[NSString alloc]init];
    NSString *stringaward4=[[NSString alloc]init];
    NSString *stringaward5=[[NSString alloc]init];
    NSString *stringaward6=[[NSString alloc]init];
    stringaward1= [NSString stringWithFormat:@"%d",userMybag.award1];
    stringaward2=[ NSString stringWithFormat:@"%d",userMybag.award2];
    stringaward3=[ NSString stringWithFormat:@"%d",userMybag.award3];
    stringaward4=[ NSString stringWithFormat:@"%d",userMybag.award4];
    stringaward5=[ NSString stringWithFormat:@"%d",userMybag.award5];
    stringaward6=[ NSString stringWithFormat:@"%d",userMybag.award6];
    baward1.text = stringaward1;
    baward2.text = stringaward2;
    baward3.text = stringaward3;
    baward4.text = stringaward4;
    baward5.text = stringaward5;
    baward6.text = stringaward6;
    [baward1 setBackgroundColor:[UIColor clearColor]];
    [baward2 setBackgroundColor:[UIColor clearColor]];
    [baward3 setBackgroundColor:[UIColor clearColor]];
    [baward4 setBackgroundColor:[UIColor clearColor]];
    [baward5 setBackgroundColor:[UIColor clearColor]];
    [baward6 setBackgroundColor:[UIColor clearColor]];
    
    
}
- (IBAction)goBack:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    usercenter.user = userMybag;
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
    behaviour.userId = userMybag.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"Mybag-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userMybag;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userMybag;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userMybag;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userMybag;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}


@end