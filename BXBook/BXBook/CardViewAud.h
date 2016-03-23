//
//  CardViewPic.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

//对应resourceword，显示单词的音形义

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlay.h"
#import "PlayMusicImpl.h"

@interface CardViewAud : UIView
@property UIColor *cardColor;
@property UIImage *cardImage;
@property NSString *infoText;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (strong ,nonatomic) NSString *filePath;
@end
