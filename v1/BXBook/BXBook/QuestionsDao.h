
//
//  QuestionsDao.h
//  BCBookDW
//
//  Created by sunzhong on 16/2/22.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "Questions.h"
#import "DataUtil.h"

@interface QuestionsDao : NSObject

//根据questionid查找关卡Questions表中的信息
+ (Questions*) findQuestionsByQuestionId:(int)questionId;

//获取所有questions
+ (NSMutableArray*) findAllQuestions;

//更新questions
+ (int) updateQuestions:(Questions*)questions;

//更新gamefinishId
//+ (int) updateGameFinishId:(Game*)game;

//根据关卡数 从所有题目里面选出该关卡内的题目
+ (NSMutableArray*) findQuestionsByGameChoiceId:(int)gameId ques:(NSMutableArray*)questions;
@end
