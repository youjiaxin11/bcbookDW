//
//  Help.h
//  BXBook
//
//  Created by sunzhong on 15/7/24.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Help : NSObject

@property int helpId;// 主键自增长
@property int helpType;//通关秘籍类型
@property NSString* helpUrl;//通关秘籍url
@property int viewTimes;//浏览人次


@end