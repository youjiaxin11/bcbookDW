//
//  GameDao.m
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "GameDao.h"

@implementation GameDao

+ (Game*) findGameByGameId:(int)gameId{
    Game* game =[[Game alloc] init];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    
    NSString * constrait =@"pragma foreign_keys = ON";
    if(sqlite3_prepare_v2(database, [constrait UTF8String], -1, &statement, NULL) == SQLITE_OK)//先开启外键约束功能
    {
        if(sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(NO,@"数据库操作失败。");
    }
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM game WHERE gameId = '%d'", gameId];
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            game.gameId = sqlite3_column_int(statement, 0);
            game.gameNum = sqlite3_column_int(statement, 1);
            game.starNum = sqlite3_column_int(statement, 2);
            game.line = [self findLineByLineId:sqlite3_column_int(statement, 3)];
            game.puzzle = [self findPuzzleByPuzzleId:sqlite3_column_int(statement, 4)];
            game.shoot = [self findShootByShootId:sqlite3_column_int(statement, 5)];
            game.finishId = sqlite3_column_int(statement, 6);
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return game;
}

+ (NSMutableArray*) findAllGames{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM game ORDER BY gameId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Game* game = [[Game alloc]init];
            game.gameId = sqlite3_column_int(statement, 0);
            game.gameNum = sqlite3_column_int(statement, 1);
            game.starNum = sqlite3_column_int(statement, 2);
            game.line = [self findLineByLineId:sqlite3_column_int(statement, 3)];
            game.puzzle = [self findPuzzleByPuzzleId:sqlite3_column_int(statement, 4)];
            game.shoot = [self findShootByShootId:sqlite3_column_int(statement, 5)];
            [array addObject:game];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}


+ (NSMutableArray*) findAllLines{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM line ORDER BY lineId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Line* line = [[Line alloc]init];
            line.lineId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                line.question1 = (NSString*)nil;
            }else {
                line.question1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                line.question2 = (NSString*)nil;
            }else {
                line.question2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                line.question3 = (NSString*)nil;
            }else {
                line.question3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                line.answer1 = (NSString*)nil;
            }else {
                line.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                line.answer2 = (NSString*)nil;
            }else {
                line.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                line.answer3 = (NSString*)nil;
            }else {
                line.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            line.helpId = sqlite3_column_int(statement, 7);
            if ((char *)sqlite3_column_text(statement, 8) == nil) {
                line.lineContent = (NSString*)nil;
            }else {
                line.lineContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            }
            line.answerTimes = sqlite3_column_int(statement, 9);
            line.rightTimes = sqlite3_column_int(statement, 10);
            if ((char *)sqlite3_column_text(statement, 11) == nil) {
                line.answerRightPer = (NSString*)nil;
            }else {
                line.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
            }

            [array addObject:line];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}


+ (NSMutableArray*) findAllPuzzles{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM puzzle ORDER BY puzzleId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Puzzle* puzzle = [[Puzzle alloc]init];
            puzzle.puzzleId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                puzzle.question1 = (NSString*)nil;
            }else {
                puzzle.question1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                puzzle.answer11 = (NSString*)nil;
            }else {
                puzzle.answer11 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                puzzle.answer12 = (NSString*)nil;
            }else {
                puzzle.answer12 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                puzzle.answer13 = (NSString*)nil;
            }else {
                puzzle.answer13 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            puzzle.answer1Num = sqlite3_column_int(statement, 5);
            puzzle.answer1Right = sqlite3_column_int(statement, 6);
            if ((char *)sqlite3_column_text(statement, 7) == nil) {
                puzzle.question2 = (NSString*)nil;
            }else {
                puzzle.question2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            }
            if ((char *)sqlite3_column_text(statement, 8) == nil) {
                puzzle.answer21 = (NSString*)nil;
            }else {
                puzzle.answer21 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            }
            if ((char *)sqlite3_column_text(statement, 9) == nil) {
                puzzle.answer22 = (NSString*)nil;
            }else {
                puzzle.answer22 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
            }
            if ((char *)sqlite3_column_text(statement, 10) == nil) {
                puzzle.answer23 = (NSString*)nil;
            }else {
                puzzle.answer23 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
            }
            puzzle.answer2Num = sqlite3_column_int(statement, 11);
            puzzle.answer2Right = sqlite3_column_int(statement, 12);
            if ((char *)sqlite3_column_text(statement, 13) == nil) {
                puzzle.question3 = (NSString*)nil;
            }else {
                puzzle.question3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
            }
            if ((char *)sqlite3_column_text(statement, 14) == nil) {
                puzzle.answer31 = (NSString*)nil;
            }else {
                puzzle.answer31 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
            }
            if ((char *)sqlite3_column_text(statement, 15) == nil) {
                puzzle.answer32 = (NSString*)nil;
            }else {
                puzzle.answer32 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
            }
            if ((char *)sqlite3_column_text(statement, 16) == nil) {
                puzzle.answer33 = (NSString*)nil;
            }else {
                puzzle.answer33 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
            }
            puzzle.answer3Num = sqlite3_column_int(statement, 17);
            puzzle.answer3Right = sqlite3_column_int(statement, 18);
            if ((char *)sqlite3_column_text(statement, 19) == nil) {
                puzzle.question4 = (NSString*)nil;
            }else {
                puzzle.question4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
            }
            if ((char *)sqlite3_column_text(statement, 20) == nil) {
                puzzle.answer41 = (NSString*)nil;
            }else {
                puzzle.answer41 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
            }
            if ((char *)sqlite3_column_text(statement, 21) == nil) {
                puzzle.answer42 = (NSString*)nil;
            }else {
                puzzle.answer42 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
            }
            if ((char *)sqlite3_column_text(statement, 22) == nil) {
                puzzle.answer43 = (NSString*)nil;
            }else {
                puzzle.answer43 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
            }
            puzzle.answer4Num = sqlite3_column_int(statement, 23);
            puzzle.answer4Right = sqlite3_column_int(statement, 24);
            puzzle.helpId1 = sqlite3_column_int(statement, 25);
            puzzle.helpId2 = sqlite3_column_int(statement, 26);
            puzzle.helpId3 = sqlite3_column_int(statement, 27);
            puzzle.helpId4 = sqlite3_column_int(statement, 28);
            puzzle.answerTimes1 = sqlite3_column_int(statement, 29);
            puzzle.rightTimes1 = sqlite3_column_int(statement, 30);
            if ((char *)sqlite3_column_text(statement, 31) == nil) {
                puzzle.answerRightPer1 = (NSString*)nil;
            }else {
                puzzle.answerRightPer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 31)];
            }
            puzzle.answerTimes2 = sqlite3_column_int(statement, 32);
            puzzle.rightTimes2 = sqlite3_column_int(statement, 33);
            if ((char *)sqlite3_column_text(statement, 34) == nil) {
                puzzle.answerRightPer2 = (NSString*)nil;
            }else {
                puzzle.answerRightPer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 34)];
            }
            puzzle.answerTimes3 = sqlite3_column_int(statement, 35);
            puzzle.rightTimes3 = sqlite3_column_int(statement, 36);
            if ((char *)sqlite3_column_text(statement, 37) == nil) {
                puzzle.answerRightPer3 = (NSString*)nil;
            }else {
                puzzle.answerRightPer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 37)];
            }
            puzzle.answerTimes4 = sqlite3_column_int(statement, 38);
            puzzle.rightTimes4 = sqlite3_column_int(statement, 39);
            if ((char *)sqlite3_column_text(statement, 40) == nil) {
                puzzle.answerRightPer4 = (NSString*)nil;
            }else {
                puzzle.answerRightPer4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 40)];
            }

            [array addObject:puzzle];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}


+ (NSMutableArray*) findAllShoots{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    sqlite3* database = [SqliteUtil openDatabase];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM shoot ORDER BY shootId"];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    if (result == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            Shoot* shoot = [[Shoot alloc]init];
            shoot.shootId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                shoot.question = (NSString*)nil;
            }else {
                shoot.question = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            shoot.answerRight = sqlite3_column_int(statement, 2);
            shoot.answerNum = sqlite3_column_int(statement, 3);
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                shoot.answer1 = (NSString*)nil;
            }else {
                shoot.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                shoot.answer2 = (NSString*)nil;
            }else {
                shoot.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                shoot.answer3 = (NSString*)nil;
            }else {
                shoot.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            shoot.helpId = sqlite3_column_int(statement, 7);
            shoot.answerTimes = sqlite3_column_int(statement, 11);
            shoot.rightTimes = sqlite3_column_int(statement, 12);
            if ((char *)sqlite3_column_text(statement, 13) == nil) {
                shoot.answerRightPer = (NSString*)nil;
            }else {
                shoot.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
            }

            [array addObject:shoot];
        }
    }else {
        NSLog(@"查询数据失败");
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return array;
}

+ (Line*) findLineByLineId:(int)lineId{
    Line* line =[[Line alloc] init];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM line WHERE lineId = '%d'", lineId];
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            line.lineId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                line.question1 = (NSString*)nil;
            }else {
                line.question1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                line.question2 = (NSString*)nil;
            }else {
                line.question2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                line.question3 = (NSString*)nil;
            }else {
                line.question3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                line.answer1 = (NSString*)nil;
            }else {
                line.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                line.answer2 = (NSString*)nil;
            }else {
                line.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                line.answer3 = (NSString*)nil;
            }else {
                line.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
            line.helpId = sqlite3_column_int(statement, 7);
            if ((char *)sqlite3_column_text(statement, 8) == nil) {
                line.lineContent = (NSString*)nil;
            }else {
                line.lineContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            }
            line.answerTimes = sqlite3_column_int(statement, 9);
            line.rightTimes = sqlite3_column_int(statement, 10);
            if ((char *)sqlite3_column_text(statement, 11) == nil) {
                line.answerRightPer = (NSString*)nil;
            }else {
                line.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
            }
        }
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return line;
}

+ (Puzzle*) findPuzzleByPuzzleId:(int)puzzleId{
    Puzzle* puzzle =[[Puzzle alloc] init];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM puzzle WHERE puzzleId = '%d'", puzzleId];
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            puzzle.puzzleId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                puzzle.question1 = (NSString*)nil;
            }else {
                puzzle.question1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            if ((char *)sqlite3_column_text(statement, 2) == nil) {
                puzzle.answer11 = (NSString*)nil;
            }else {
                puzzle.answer11 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            }
            if ((char *)sqlite3_column_text(statement, 3) == nil) {
                puzzle.answer12 = (NSString*)nil;
            }else {
                puzzle.answer12 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            }
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                puzzle.answer13 = (NSString*)nil;
            }else {
                puzzle.answer13 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            puzzle.answer1Num = sqlite3_column_int(statement, 5);
            puzzle.answer1Right = sqlite3_column_int(statement, 6);
            if ((char *)sqlite3_column_text(statement, 7) == nil) {
                puzzle.question2 = (NSString*)nil;
            }else {
                puzzle.question2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            }
            if ((char *)sqlite3_column_text(statement, 8) == nil) {
                puzzle.answer21 = (NSString*)nil;
            }else {
                puzzle.answer21 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            }
            if ((char *)sqlite3_column_text(statement, 9) == nil) {
                puzzle.answer22 = (NSString*)nil;
            }else {
                puzzle.answer22 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
            }
            if ((char *)sqlite3_column_text(statement, 10) == nil) {
                puzzle.answer23 = (NSString*)nil;
            }else {
                puzzle.answer23 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
            }
            puzzle.answer2Num = sqlite3_column_int(statement, 11);
            puzzle.answer2Right = sqlite3_column_int(statement, 12);
            if ((char *)sqlite3_column_text(statement, 13) == nil) {
                puzzle.question3 = (NSString*)nil;
            }else {
                puzzle.question3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
            }
            if ((char *)sqlite3_column_text(statement, 14) == nil) {
                puzzle.answer31 = (NSString*)nil;
            }else {
                puzzle.answer31 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
            }
            if ((char *)sqlite3_column_text(statement, 15) == nil) {
                puzzle.answer32 = (NSString*)nil;
            }else {
                puzzle.answer32 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
            }
            if ((char *)sqlite3_column_text(statement, 16) == nil) {
                puzzle.answer33 = (NSString*)nil;
            }else {
                puzzle.answer33 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
            }
            puzzle.answer3Num = sqlite3_column_int(statement, 17);
            puzzle.answer3Right = sqlite3_column_int(statement, 18);
            if ((char *)sqlite3_column_text(statement, 19) == nil) {
                puzzle.question4 = (NSString*)nil;
            }else {
                puzzle.question4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
            }
            if ((char *)sqlite3_column_text(statement, 20) == nil) {
                puzzle.answer41 = (NSString*)nil;
            }else {
                puzzle.answer41 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
            }
            if ((char *)sqlite3_column_text(statement, 21) == nil) {
                puzzle.answer42 = (NSString*)nil;
            }else {
                puzzle.answer42 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
            }
            if ((char *)sqlite3_column_text(statement, 22) == nil) {
                puzzle.answer43 = (NSString*)nil;
            }else {
                puzzle.answer43 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
            }
            puzzle.answer4Num = sqlite3_column_int(statement, 23);
            puzzle.answer4Right = sqlite3_column_int(statement, 24);
            puzzle.helpId1 = sqlite3_column_int(statement, 25);
            puzzle.helpId2 = sqlite3_column_int(statement, 26);
            puzzle.helpId3 = sqlite3_column_int(statement, 27);
            puzzle.helpId4 = sqlite3_column_int(statement, 28);
            puzzle.answerTimes1 = sqlite3_column_int(statement, 29);
            puzzle.rightTimes1 = sqlite3_column_int(statement, 30);
            if ((char *)sqlite3_column_text(statement, 31) == nil) {
                puzzle.answerRightPer1 = (NSString*)nil;
            }else {
                puzzle.answerRightPer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 31)];
            }
            puzzle.answerTimes2 = sqlite3_column_int(statement, 32);
            puzzle.rightTimes2 = sqlite3_column_int(statement, 33);
            if ((char *)sqlite3_column_text(statement, 34) == nil) {
                puzzle.answerRightPer2 = (NSString*)nil;
            }else {
                puzzle.answerRightPer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 34)];
            }
            puzzle.answerTimes3 = sqlite3_column_int(statement, 35);
            puzzle.rightTimes3 = sqlite3_column_int(statement, 36);
            if ((char *)sqlite3_column_text(statement, 37) == nil) {
                puzzle.answerRightPer3 = (NSString*)nil;
            }else {
                puzzle.answerRightPer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 37)];
            }
            puzzle.answerTimes4 = sqlite3_column_int(statement, 38);
            puzzle.rightTimes4 = sqlite3_column_int(statement, 39);
            if ((char *)sqlite3_column_text(statement, 40) == nil) {
                puzzle.answerRightPer4 = (NSString*)nil;
            }else {
                puzzle.answerRightPer4 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 40)];
            }
        }
        
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return puzzle;
}

+ (Shoot*) findShootByShootId:(int)shootId{
    Shoot* shoot =[[Shoot alloc] init];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM shoot WHERE shootId = '%d'", shootId];
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW) {
            shoot.shootId = sqlite3_column_int(statement, 0);
            if ((char *)sqlite3_column_text(statement, 1) == nil) {
                shoot.question = (NSString*)nil;
            }else {
                shoot.question = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            }
            shoot.answerRight = sqlite3_column_int(statement, 2);
            shoot.answerNum = sqlite3_column_int(statement, 3);
            if ((char *)sqlite3_column_text(statement, 4) == nil) {
                shoot.answer1 = (NSString*)nil;
            }else {
                shoot.answer1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            }
            if ((char *)sqlite3_column_text(statement, 5) == nil) {
                shoot.answer2 = (NSString*)nil;
            }else {
                shoot.answer2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            }
            if ((char *)sqlite3_column_text(statement, 6) == nil) {
                shoot.answer3 = (NSString*)nil;
            }else {
                shoot.answer3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            }
           shoot.helpId = sqlite3_column_int(statement, 7);
            shoot.answerTimes = sqlite3_column_int(statement, 8);
            shoot.rightTimes = sqlite3_column_int(statement, 9);
            if ((char *)sqlite3_column_text(statement, 10) == nil) {
                shoot.answerRightPer = (NSString*)nil;
            }else {
                shoot.answerRightPer = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
            }
        }
        
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return shoot;
}

+ (int) updateLine:(Line*)line{
    int success = 1;
    if (line.answerTimes > 0) {
        float x = (float)line.rightTimes/(float)line.answerTimes;
        NSString* percent = [DataUtil floatToPercent:x];
        line.answerRightPer = percent;
    }else{
        line.answerRightPer = nil;
    }
    NSLog(@"linePer!!!!!!!!!!!!%@",line.answerRightPer);
    NSString *query = [NSString stringWithFormat:@"UPDATE line SET answerTimes = '%d', rightTimes = '%d', answerPer = '%@' WHERE lineId = '%d'", line.answerTimes,  line.rightTimes,  line.answerRightPer, line.lineId];
    
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        NSLog(@"linePer!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

+ (int) updatePuzzle:(Puzzle *)puzzle{
    int success = 1;
    if (puzzle.answerTimes1 > 0) {
        float x = (float)puzzle.rightTimes1/(float)puzzle.answerTimes1;
        NSString* percent = [DataUtil floatToPercent:x];
        puzzle.answerRightPer1 = percent;
    }else{
        puzzle.answerRightPer1 = nil;
    }
    if (puzzle.answerTimes2 > 0) {
        float x = (float)puzzle.rightTimes2/(float)puzzle.answerTimes2;
        NSString* percent = [DataUtil floatToPercent:x];
        puzzle.answerRightPer2 = percent;
    }else{
        puzzle.answerRightPer2 = nil;
    }
    if (puzzle.answerTimes3 > 0) {
        float x = (float)puzzle.rightTimes3/(float)puzzle.answerTimes3;
        NSString* percent = [DataUtil floatToPercent:x];
        puzzle.answerRightPer3 = percent;
    }else{
        puzzle.answerRightPer3 = nil;
    }
    if (puzzle.answerTimes4 > 0) {
        float x = (float)puzzle.rightTimes4/(float)puzzle.answerTimes4;
        NSString* percent = [DataUtil floatToPercent:x];
        puzzle.answerRightPer4 = percent;
    }else{
        puzzle.answerRightPer4 = nil;
    }
  //  NSLog(@"!!!!!!!!!!!!%@",line.answerRightPer);
    NSString *query = [NSString stringWithFormat:@"UPDATE puzzle SET answerTimes1 = '%d', rightTimes1 = '%d', answerPer1 = '%@', answerTimes2 = '%d', rightTimes2 = '%d', answerPer2 = '%@', answerTimes3 = '%d', rightTimes3 = '%d', answerPer3 = '%@', answerTimes4 = '%d', rightTimes4 = '%d', answerPer4 = '%@' WHERE puzzleId = '%d'", puzzle.answerTimes1,  puzzle.rightTimes1,  puzzle.answerRightPer1,puzzle.answerTimes2,  puzzle.rightTimes2,  puzzle.answerRightPer2,puzzle.answerTimes3,  puzzle.rightTimes3,  puzzle.answerRightPer3,puzzle.answerTimes4,  puzzle.rightTimes4,  puzzle.answerRightPer4, puzzle.puzzleId];
    
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        NSLog(@"puzzlePer!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}

+ (int) updateShoot:(Shoot *)shoot{
    int success = 1;
    if (shoot.answerTimes > 0) {
        float x = (float)shoot.rightTimes/(float)shoot.answerTimes;
        NSString* percent = [DataUtil floatToPercent:x];
        shoot.answerRightPer = percent;
    }else{
        shoot.answerRightPer = nil;
    }
    NSString *query = [NSString stringWithFormat:@"UPDATE shoot SET answerTimes = '%d', rightTimes = '%d', answerPer = '%@' WHERE shootId = '%d'", shoot.answerTimes,  shoot.rightTimes,  shoot.answerRightPer, shoot.shootId];
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        NSLog(@"shootPer!!!");
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}
+ (int) updateGameFinishId:(Game*)game{
    int success = 1;
    
    NSString *query = [NSString stringWithFormat:@"UPDATE game SET finishId = '%d' WHERE gameId = '%d'", game.finishId, game.gameId];
    
    sqlite3* database = [SqliteUtil openDatabase];
    sqlite3_stmt *statement;
    int result = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
    
    if (result == SQLITE_OK)
    {
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);//结束之前清除statement对象
    sqlite3_close(database);//关闭数据库
    return success;
}


@end
