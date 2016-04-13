//
//  MyWorkDao.h
//  BCBookDW
//
//  Created by sunzhong on 16/4/12.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyWork.h"

@interface MyWorkDao : NSObject

+(NSArray *)getAllMyWork;
+(void)addMyWork:(MyWork *)myWork;
+(void)addMyWork:(int)workId andUserId:(int)userId andTaskTitle:(NSString *)taskTitle andUploadTime:(NSString *)uploadTime andType:(int)type andFilePath:(NSString *)filePath;
+(void)removeWrongQustion:(int)workId andUserId:(int)userId;

@end
