//
//  PlayMusicImpl.h
//  BXBook
//
//  Created by xiaoqi on 15/7/28.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayMusicImpl : UIViewController

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象

/**
 *播放音乐文件
 */
+(BOOL)playMusic:(NSString *)filename;
/**
 *暂停播放
 */
+(void)pauseMusic:(NSString *)filename;
/**
 *播放音乐文件
 */
+(void)stopMusic:(NSString *)filename;

@end