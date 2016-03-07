//
//  Puzzle.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Puzzle : NSObject

@property int puzzleId;// 主键自增长
@property NSString* question1;//问题1
@property NSString* answer11;//问题1答案1
@property NSString* answer12;//问题1答案2
@property NSString* answer13;//问题1答案3
@property int answer1Num;//问题1答案个数
@property int answer1Right;//问题1正确答案
@property NSString* question2;//问题2
@property NSString* answer21;//问题2答案1
@property NSString* answer22;//问题2答案2
@property NSString* answer23;//问题2答案3
@property int answer2Num;//问题2答案个数
@property int answer2Right;//问题2正确答案
@property NSString* question3;//问题3
@property NSString* answer31;//问题3答案1
@property NSString* answer32;//问题3答案2
@property NSString* answer33;//问题3答案3
@property int answer3Num;//问题3答案个数
@property int answer3Right;//问题3正确答案
@property NSString* question4;//问题4
@property NSString* answer41;//问题4答案1
@property NSString* answer42;//问题4答案2
@property NSString* answer43;//问题4答案3
@property int answer4Num;//问题4答案个数
@property int helpId1;
@property int helpId2;
@property int helpId3;
@property int helpId4;
@property int answer4Right;//问题4正确答案
@property int answerTimes1;//答题次数
@property int rightTimes1;//正确次数
@property NSString* answerRightPer1;// 正确率
@property int answerTimes2;//答题次数
@property int rightTimes2;//正确次数
@property NSString* answerRightPer2;// 正确率
@property int answerTimes3;//答题次数
@property int rightTimes3;//正确次数
@property NSString* answerRightPer3;// 正确率
@property int answerTimes4;//答题次数
@property int rightTimes4;//正确次数
@property NSString* answerRightPer4;// 正确率
@end