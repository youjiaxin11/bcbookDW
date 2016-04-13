//
//  Work.h
//  BXBook
//
//  Created by sunzhong on 15/8/19.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWork : NSObject<NSCoding>

@property int workId;// 主键自增长
@property int userId;//用户id
@property NSString* taskTitle;//任务名称
@property NSString* uploadTime;//上传时间
@property int type;//作品类型，1图片，2视频，3录音
@property NSString* filePath;//作品本地保存路径
@end