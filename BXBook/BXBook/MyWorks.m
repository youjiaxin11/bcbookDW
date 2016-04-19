//
//  MyWorks.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "MyWorks.h"
#import "WebUtil.h"
#import "WorksCell.h"
#import "PhotosController.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "CardViewPic.h"
#import "CardViewVid.h"
#import "CardViewAud.h"
#import "NotebookController.h"


@interface MyWorks () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;

@property (nonatomic, strong) NSArray *colorNames;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger count;


@property (nonatomic, strong) NSMutableArray *images;
//@property (nonatomic, strong) NSMutableArray *texts;

@end

@implementation MyWorks
@synthesize taskId, pageType;

User* userMyWorks;
NSMutableArray *workArr;
NSMutableArray* myworks;
MPMoviePlayerController *moviePlay;


- (void)viewDidLoad {
    [super viewDidLoad];
    userMyWorks = self.user;
    NSLog(@"%@",userMyWorks.loginName);
    NSLog(@"%d",taskId);

    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userMyWorks.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"MyWorks-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
//    
//    if (YES) {
//        self.count = 3;
//    }else {
//        self.count = 3;//卡片个数
//    }
//
    
    NSArray *workArray = [MyWorkDao getAllMyWork];
    myworks = [[NSMutableArray alloc]init];
    [myworks addObjectsFromArray:workArray];
    self.count = myworks.count;
    
    //设置颜色数组数据源
    self.index = 0;
    self.colorNames = @[
                        @"Turquoise",
                        @"Green Sea",
                        @"Emerald",
                        @"Nephritis",
                        @"Peter River",
                        @"Belize Hole",
                        @"Amethyst",
                        @"Wisteria",
                        @"Wet Asphalt",
                        @"Midnight Blue",
                        @"Sun Flower",
                        @"Orange",
                        @"Carrot",
                        @"Pumpkin",
                        @"Alizarin",
                        @"Pomegranate",
                        @"Clouds",
                        @"Silver",
                        @"Concrete",
                        @"Asbestos",
                        ];
    self.colors = [[NSMutableArray alloc]initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        NSString *color;
        int j = i;
        if (j >= 20) {
            j = j - 20;
        }
        color = [[NSString alloc]initWithString:self.colorNames[j]];
        [self.colors addObject:color];
    }
    

    
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    // required data source
    self.swipeableView.dataSource = self;
    
    // optional delegate
    self.swipeableView.delegate = self;
    
}


- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.index);
    [self.swipeableView swipeTopViewToLeft];
}
- (IBAction)swipeRightButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.index);
    [self.swipeableView swipeTopViewToRight];
}

- (IBAction)reloadButtonAction:(UIButton *)sender {
    NSLog(@"colorIndex:%d",self.index);
    //if(self.colorIndex >= 4 && self.colorIndex<=16){
    self.index = self.index-4;
    //  self.colorIndex = 0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
    // }
    
}

#pragma mark - ZLSwipeableViewDelegate
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view {
    NSLog(@"did swipe left");
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view {
    NSLog(@"did swipe right");
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
    NSLog(@"swiping at location: x %f, y%f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    NSLog(@"!!!!!填充卡片view适配");
    NSLog(@"index的数值是多少？ ＝＝ %ld",(long)self.index);

    
    if (self.index<0) {
        self.index = 0;
    }
    if (self.index < self.count) {
//        NSLog(@"－－－－准备加载作品");
        MyWork *myworkShow = [myworks objectAtIndex:self.index];
        NSLog(@"作品信息");
        NSLog(@"我的第%ld个作品：%@",self.index+1,myworkShow);
        NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",myworkShow.workId,myworkShow.userId,myworkShow.uploadTime,myworkShow.taskTitle,myworkShow.type,myworkShow.filePath);
        
        NSString* str1 = [@"任务名称:" stringByAppendingString:myworkShow.taskTitle];
        NSString* str2 = [str1 stringByAppendingString:@" 提交时间:"];
        NSString* str3 = [str2 stringByAppendingString:myworkShow.uploadTime];
        
        
        //获得路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:myworkShow.filePath];

        NSLog(@"作品路径：%@",filePath);
        if (myworkShow.type == 1) {//图片
            
            NSLog(@"－－－－准备加载图片");
            CardViewPic *view = [[CardViewPic alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
            
            //这里:用路径加载图片
            NSLog(@"图片路径：%@",filePath);
            
            NSData* data = [[NSData alloc] initWithContentsOfFile:filePath];
            UIImage* img = nil;
            if(data != nil)
            {
                img = [[UIImage alloc] initWithData:data];
            }
            view.cardImage = img;
            view.infoText = str3;
            self.index++;
            return view;
        }else if (myworkShow.type == 2){//视频
            CardViewVid *view = [[CardViewVid alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
            view.infoText = str3;

            view.filePath = filePath;
            self.index++;
            return view;

        }else if (myworkShow.type == 3){//录音
            //在这里修改卡片的数据源
            CardViewAud *view = [[CardViewAud alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
            view.cardImage = [UIImage imageNamed:@"workAud.png"];
            view.fileName = myworkShow.filePath;
            view.infoText = str3;
            self.index++;
            return view;
        }
        

    }
    return nil;
}

#pragma mark - ()
- (UIColor *)colorForName:(NSString *)name
{
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
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
    behaviour.userId = userMyWorks.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"MyWorks-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userMyWorks;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userMyWorks;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userMyWorks;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userMyWorks;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end