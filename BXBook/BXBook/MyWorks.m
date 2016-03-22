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
    
    
    if (YES) {
        self.count = 3;
    }else {
        self.count = 3;//卡片个数
    }
    
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
    
    MyWork* mywork1 = [[MyWork alloc]init];
    mywork1.workId = 1;
    mywork1.userId = userMyWorks.userId;
    mywork1.taskTitle = @"包粽子";
    mywork1.uploadTime = @"2016年3月21日6:08";
    mywork1.type = 1;
    MyWork* mywork2 = [[MyWork alloc]init];
    mywork2.workId = 2;
    mywork2.userId = userMyWorks.userId;
    mywork2.taskTitle = @"五彩丝线";
    mywork2.uploadTime = @"2016年3月22日6:08";
    mywork2.type = 2;
    MyWork* mywork3 = [[MyWork alloc]init];
    mywork3.workId = 3;
    mywork3.userId = userMyWorks.userId;
    mywork3.taskTitle = @"赛龙舟";
    mywork3.uploadTime = @"2016年3月23日6:08";
    mywork3.type = 3;
    
    myworks = [[NSMutableArray alloc]init];
    [myworks addObject:mywork1];
    [myworks addObject:mywork2];
    [myworks addObject:mywork3];
    
    
    //设置要现实的文字数组数据源
//    self.texts = [[NSMutableArray alloc]initWithCapacity:self.count];
//    for (int i = 0; i < self.count; i++) {
//        //  NSString *text = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%d",i]];
//        NSString *text = @"1111";
//        [self.texts addObject:text];
//    }
    
    // ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:self.view.frame];
    // [self.view addSubview:swipeableView];
    
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
    
    if (self.index<0) {
        self.index = 0;
    }
    if (self.index<self.count) {
        
        MyWork* myworkShow = [myworks objectAtIndex:self.index];
        if (myworkShow.type == 1) {//图片
            CardViewPic *view = [[CardViewPic alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
            view.cardImage = [UIImage imageNamed:@"拼图5.png"];
            self.index++;
            return view;
        }else if (myworkShow.type == 2){//视频
            CardViewVid *view = [[CardViewVid alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
          //  view.filePath = [self.filePaths objectAtIndex:self.index];
            self.index++;
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [view addGestureRecognizer:singleTap];
            return view;

        }else if (myworkShow.type == 3){//录音
            //在这里修改卡片的数据源
            CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
            view.cardColor = [self colorForName:self.colors[self.index]];
            view.cardText = @"111";
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
    }
}


//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)handleSingleTap:(UIGestureRecognizer*)gestureRecognizer{
    //MyWork* myworkShow = [myworks objectAtIndex:self.index];
    //NSString *urlStr = myworkShow.filePath;
    //测试用例
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    if (urlStr == nil) {
        [self prompt:@"未上传视频"];
    }else{
        //VideoPlay* videoplay;
        //[videoplay Play:urlStr];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        //视频播放对象
        moviePlay = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentMoviePlayerViewControllerAnimated:moviePlay];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myMovieFinishedCallback:)
                                                     name: MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        moviePlay = nil;
    }
}




-(void)myMovieFinishedCallback:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    //    [moviePlay  dismissMoviePlayerViewControllerAnimated];
    //    [moviePlay.moviePlayer stop];
    //    moviePlay.moviePlayer.initialPlaybackTime = -1.0;
    moviePlay = nil;
}


@end