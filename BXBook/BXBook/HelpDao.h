//
//  HelpDao.h
//  BXBook
//
//  Created by sunzhong on 15/9/2.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Help.h"

@interface HelpDao: NSObject

//查询所有通关秘籍
+ (NSMutableArray*) getAllHelps;

//更新help的viewTimes
+ (int) updateHelpViewTimes:(Help*)help;

//根据helpId查询通关秘籍
+ (Help*) findHelpByHelpId:(int)helpId;

@end