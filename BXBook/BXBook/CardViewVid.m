//
//  CardViewVid.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "CardViewVid.h"

@implementation CardViewVid
@synthesize player,contentimageview,filePath;

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //// Color Declarations
        UIColor* shadowColor2 = [UIColor colorWithRed: 0.209 green: 0.209 blue: 0.209 alpha: 1];
        
        //// Shadow Declarations
        UIColor* shadow = [shadowColor2 colorWithAlphaComponent: 0.73];
        CGSize shadowOffset = CGSizeMake(3.1/2.0, -0.1/2.0);
        CGFloat shadowBlurRadius = 12/2.0;
        self.layer.shadowColor = [shadow CGColor];
        self.layer.shadowOpacity = 0.73;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowRadius = shadowBlurRadius;
        self.layer.shouldRasterize = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGFloat frameWidth = rect.size.width;//修改卡片大小
    CGFloat frameHeight = rect.size.height;///修改卡片大小
    CGFloat cornerRadius = 10;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* cardColor = self.cardColor;
    
    //显示文字2
    UITextView *infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(30,10,frameWidth-60,40)];
    infoTextView.backgroundColor = [UIColor clearColor];
    infoTextView.font = [UIFont fontWithName:@"Arial" size:20];
  //  self.infoText = @"demo";
    infoTextView.text = self.infoText;
    [self addSubview:infoTextView];

    //测试用例
  //  filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
 
    AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(10, 50, frameWidth-100,frameHeight-60);
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.layer addSublayer:playerLayer];
    
    
    UIButton* start = [[UIButton alloc] initWithFrame:CGRectMake(560,frameHeight-160,73,70)];
    [start setBackgroundImage:[UIImage imageNamed:@"playon.png"] forState:normal];
    [start addTarget:self action:@selector(actionStart:) forControlEvents:UIControlEventTouchUpInside];
    start.clipsToBounds = YES;
    [self addSubview:start];
    
    UIButton* pause = [[UIButton alloc] initWithFrame:CGRectMake(560,frameHeight-80,73,70)];
    [pause setBackgroundImage:[UIImage imageNamed:@"pauseon.png"] forState:normal];
    [pause addTarget:self action:@selector(actionPause:) forControlEvents:UIControlEventTouchUpInside];
     start.clipsToBounds = YES;
    [self addSubview:pause];


    
    
    NSLog(@"this video demo!!!");
    
    //// card1
    {
        CGContextSaveGState(context);
        //        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
        CGContextBeginTransparencyLayer(context, NULL);
        
        //// Rectangle 4 Drawing
        UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, frameWidth, frameHeight) cornerRadius: cornerRadius];//修改卡片位置
        [cardColor setFill];
        [rectangle4Path fill];
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}

-(void)actionStart:(id)sender{
    [player play];
}

-(void)actionPause:(id)sender{
    [player pause];
}

@end
