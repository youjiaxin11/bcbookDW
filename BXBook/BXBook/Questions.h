//
//  Questions.h
//  BCBookDW
//
//  Created by sunzhong on 16/2/22.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Questions : NSObject

@property int questionId;// 主键自增长
@property NSString* question;//问题的题干
@property int answerRight;//正确答案（1、2、3）
@property int answerNum;//答案个数（2或3个）
@property NSString* answer1;//答案1
@property NSString* answer2;//答案2
@property NSString* answer3;//答案3
@property int difficult;//难度（1代表1星，2代表2星，对应前面关卡选择）
@property int helpId;//helpId（对应通关秘籍）
@property int questionType;//题目类型:1文字，2图片，3音频（暂时不用）
@property int answerTimes;//答题次数
@property int rightTimes;//正确次数
@property NSString* answerRightPer;// 正确率
@property int gameId;//关卡数
@end

