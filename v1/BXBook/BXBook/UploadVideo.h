//
//  UploadVideo.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface UploadVideo : BaseControl{
    NSString *lastChosenMediaType;
    NSString *urlStr;
    UIImageView *contentimageview;
    AVPlayer *player;
}

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Task *task;//当前任务卡
@property(nonatomic,copy)        NSString *lastChosenMediaType;
@property(nonatomic,copy)  NSString *urlStr;
@property(nonatomic,retain)  IBOutlet   UIImageView *contentimageview;
@property (strong ,nonatomic) AVPlayer *player;//播放器，用于录制完视频后播放视频

@end