//
//  Note.h
//  BCBookDW
//
//  Created by sunzhong on 16/2/22.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Note : NSObject

@property int noteId;// 主键自增长
@property int userId;//用户
@property NSString* note;//笔记内容
@property NSString* updateTime;//更新时间
@end

