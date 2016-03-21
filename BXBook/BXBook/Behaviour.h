//
//  Questions.h
//  BCBookDW
//
//  Created by sunzhong on 16/2/22.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Behaviour : NSObject

@property int behaviourId;// 主键自增长
@property int userId;//用户
@property NSString* doWhat;//做了什么
@property NSString* doWhere;//在什么位置
@property NSString* doWhen;//时间
@end

