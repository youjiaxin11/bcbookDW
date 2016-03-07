//
//  Line.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject

@property int lineId;// 主键自增长
@property NSString* question1;//问题1
@property NSString* question2;//问题2
@property NSString* question3;//问题3
@property NSString* answer1;//答案1
@property NSString* answer2;//答案2
@property NSString* answer3;//答案3
@property int helpId;//helpId
@property NSString* lineContent;//连线题内容
@property int answerTimes;//答题次数
@property int rightTimes;//正确次数
@property NSString* answerRightPer;// 正确率
@end