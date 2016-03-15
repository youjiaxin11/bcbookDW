//
//  Work.h
//  BXBook
//
//  Created by sunzhong on 15/8/19.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Work : NSObject

@property int workId;// 主键自增长
@property int userId;//用户id
@property int taskId;//任务id
@property NSString* taskUrl;//作品url
@property int receivePraiseNum;//收到的赞数
@property int receiveCommentNum;//收到的评论数
@property int golden;//金币数
@property NSString* uploadTime;//上传时间
@property int score;//作品得分
@property int location;//作品地址，0本地，1网络

@end