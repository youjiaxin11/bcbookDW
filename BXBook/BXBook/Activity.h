//
//  Activity.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "UploadAudio.h"
#import "MyWorks.h"
#import "FriendWorks.h"

@interface Activity : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Task *task;//当前任务卡

@end
