//
//  PlayMusicImpl.m
//  BXBook
//
//  Created by xiaoqi on 15/7/28.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "PlayMusicImpl.h"

@implementation PlayMusicImpl
/**
 *存放所有的音乐播放器
 */
static NSMutableDictionary *_musices;
+(NSMutableDictionary *)musices
{
    if (_musices==nil) {
        _musices=[NSMutableDictionary dictionary];
    }
    return _musices;
}

/**
 *播放音乐
 */
+(BOOL)playMusic:(NSString *)filename
{
    if (!filename) return NO;//如果没有传入文件名，那么直接返回
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][filename];
    
    //2.如果播放器没有创建，那么就进行初始化
    if (!player) {
        //2.1音频文件的URL
        NSURL *url=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) return NO;//如果url为空，那么直接返回
        
        //2.2创建播放器
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        
        //2.3缓冲
        if (![player prepareToPlay]) return NO;//如果缓冲失败，那么就直接返回
        
        //2.4存入字典
        [self musices][filename]=player;
    }
    
    //3.播放
    if (![player isPlaying]) {
        //如果当前没处于播放状态，那么就播放
        return [player play];
    }
    
    return YES;//正在播放，那么就返回YES
}

+(void)pauseMusic:(NSString *)filename
{
    if (!filename) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][filename];
    
    //2.暂停
    [player pause];//如果palyer为空，那相当于[nil pause]，因此这里可以不用做处理
    
}

+(void)stopMusic:(NSString *)filename
{
    if (!filename) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][filename];
    
    //2.停止
    [player stop];
    
    //3.将播放器从字典中移除
    [[self musices] removeObjectForKey:filename];
}
@end