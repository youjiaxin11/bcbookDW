//
//  QuestionsDao.m
//  BCBookDW
//
//  Created by sunzhong on 16/2/22.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "QuestionsDao.h"

@implementation QuestionsDao

+ (NSMutableArray*) findAllQuestions{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM questions ORDER BY questionId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Questions* questions = [[Questions alloc]init];
            questions.questionId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                questions.question = (NSString*)nil;
            }else {
                questions.question = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            questions.answerRight = sqlite3_column_int(statement, 2);
            questions.answerNum = sqlite3_column_int(statement, 3);
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                questions.answer1 = (NSString*)nil;
            }else {
                questions.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                questions.answer2 = (NSString*)nil;
            }else {
                questions.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                questions.answer3 = (NSString*)nil;
            }else {
                questions.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            questions.difficult = sqlite3_column_int(statement, 7);
            questions.helpId = sqlite3_column_int(statement, 8);
            questions.questionType = sqlite3_column_int(statement, 9);
            questions.answerTimes = sqlite3_column_int(statement, 10);
            questions.rightTimes = sqlite3_column_int(statement, 11);
            if ((char *)sqlite3_column_text(statement, 12) == nil) {
                questions.answerRightPer = (NSString*)nil;
            }else {
                questions.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
            }
            questions.gameId = sqlite3_column_int(statement, 13);
            [array addObject:questions];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}



+ (Questions*) findQuestionsByQuestionId:(int)questionId{
    Questions* questions =[[Questions alloc] init];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM questions WHERE questionId = '%d'", questionId];
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            questions.questionId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                questions.question = (NSString*)nil;
            }else {
                questions.question = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            questions.answerRight = sqlite3_column_int(statement, 2);
            questions.answerNum = sqlite3_column_int(statement, 3);
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                questions.answer1 = (NSString*)nil;
            }else {
                questions.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                questions.answer2 = (NSString*)nil;
            }else {
                questions.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                questions.answer3 = (NSString*)nil;
            }else {
                questions.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            questions.difficult = sqlite3_column_int(statement, 7);
            questions.helpId = sqlite3_column_int(statement, 8);
            questions.questionType = sqlite3_column_int(statement, 9);
            questions.answerTimes = sqlite3_column_int(statement, 10);
            questions.rightTimes = sqlite3_column_int(statement, 11);
            if ((char *)sqlite3_column_text(statement, 12) == nil) {
                questions.answerRightPer = (NSString*)nil;
            }else {
                questions.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
            }
            questions.gameId = sqlite3_column_int(statement, 13);
        }
        
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return questions;
}


+ (int) updateQuestions:(Questions *)questions{
    int success = 1;
    if (questions.answerTimes > 0) {
        float x = (float)questions.rightTimes/(float)questions.answerTimes;
        NSString* percent = [DataUtil floatToPercent:x];
        questions.answerRightPer = percent;
    }else{
        questions.answerRightPer = nil;
    }
    NSString *query = [NSString stringWithFormat:@"UPDATE questions SET answerTimes = '%d', rightTimes = '%d', answerRightPer = '%@' WHERE questionId = '%d'", questions.answerTimes,  questions.rightTimes,  questions.answerRightPer, questions.questionId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        NSLog(@"questionsPer!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}



+ (NSMutableArray*) findQuestionsByGameChoiceId:(int)gameId ques:(NSMutableArray*)questions {
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    int i = 0;
    while (i < [questions count]) {
        Questions* question = [questions objectAtIndex:i];
        if (question.gameId == gameId) {
            [array addObject:question];
        }
        i++;
    }
    return array;
}
@end
