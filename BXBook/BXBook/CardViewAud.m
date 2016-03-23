//
//  CardViewPic.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "CardViewAud.h"

@implementation CardViewAud

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
    
    //显示图片
    //  self.cardImage = [UIImage imageNamed:@"topics8.png"];
    UIImageView *cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50,60,frameWidth-80,frameHeight-150)];
    
    
    UIGraphicsBeginImageContext(CGSizeMake(cardImageView.frame.size.width, cardImageView.frame.size.height));
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width = cardImageView.frame.size.width;
    thumbnailRect.size.height = cardImageView.frame.size.height;
    
    [self.cardImage drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cardImageView.contentMode = UIViewContentModeCenter;
    [cardImageView setImage:newImage];
    [self addSubview:cardImageView];
    
    
    //显示文字2
    UITextView *infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(30,10,frameWidth-60,40)];
    infoTextView.backgroundColor = [UIColor clearColor];
    infoTextView.font = [UIFont fontWithName:@"Arial" size:24];
    // self.infoText = @"demo";
    infoTextView.text = self.infoText;
    [self addSubview:infoTextView];
    
    UIButton* start = [[UIButton alloc] initWithFrame:CGRectMake(300,430,73,70)];
    [start setBackgroundImage:[UIImage imageNamed:@"playon.png"] forState:normal];
    [start addTarget:self action:@selector(actionStart:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:start];
    
    UIButton* pause = [[UIButton alloc] initWithFrame:CGRectMake(380,430,73,70)];
    [pause setBackgroundImage:[UIImage imageNamed:@"pauseon.png"] forState:normal];
    [pause addTarget:self action:@selector(actionPause:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pause];
    
    NSLog(@"this audio demo!!!");
    
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
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
    NSLog(@"播放!");
}

-(void)actionPause:(id)sender{
    [self.audioPlayer pause];
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        //测试用例
        self.filePath = [[NSBundle mainBundle] pathForResource:@"testAud" ofType:@"caf"];
        NSURL *url = [NSURL fileURLWithPath:self.filePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}
@end
