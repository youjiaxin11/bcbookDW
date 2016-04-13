//
//  NoteDao.h
//  BCBookDW
//
//  Created by sunzhong on 16/4/13.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "Note.h"
#import "DataUtil.h"

@interface NoteDao : NSObject

//添加一条笔记
+ (int) addNote:(Note*)note;

//更新一条笔记
+ (int) updateNote:(Note*)note;

//通过userid读取一条笔记
+ (Note*) getNoteFromUserId:(int)userId;

@end