//
//  Shoot.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shoot : NSObject

@property int shootId;// 主键自增长
@property NSString* question;//问题
@property NSString* answer1;//答案1
@property NSString* answer2;//答案2
@property NSString* answer3;//答案3
@property int answerNum;//答案个数
@property int answerRight;//正确答案
@property int helpId;//helpId
@property int answerTimes;//答题次数
@property int rightTimes;//正确次数
@property NSString* answerRightPer;// 正确率
@end
