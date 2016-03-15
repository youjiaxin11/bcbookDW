//
//  WorkDao.h
//  BXBook
//
//  Created by sunzhong on 15/8/19.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Work.h"

@interface WorkDao : NSObject

+ (Work*) decodeWork:(NSDictionary*) dic;
//通过userId找到这个人的所有作品
+ (NSMutableArray*) findWorkByUserId:(int)_userId;

//通过userId找到这个人的所有网络作品
+ (NSMutableArray*) findOnlineWorkByUserId:(int)_userId;

//添加作品
+(int) insertWork:(int)_userId taskId:(int)_taskId taskUrl:(NSString*)_taskUrl recPN:(int)_recPN recCN:(int)_recCN golden:(int)_golden uplT:(NSString*)_uplT score:(int)_score loca:(int)_loca;
@end
