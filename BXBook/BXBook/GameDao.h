//
//  GameDao.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "Game.h"
#import "DataUtil.h"

@interface GameDao : NSObject

//根据关卡id查找关卡Game表中的信息
+ (Game*) findGameByGameId:(int)gameId;

//根据lineid查找关卡Line表中的信息
+ (Line*) findLineByLineId:(int)lineId;

//根据puzzleid查找关卡Puzzle表中的信息
+ (Puzzle*) findPuzzleByPuzzleId:(int)puzzleId;

//根据shootid查找关卡Shoot表中的信息
+ (Shoot*) findShootByShootId:(int)shootId;

//获取所有game
+ (NSMutableArray*) findAllGames;

//获取所有line
+ (NSMutableArray*) findAllLines;

//获取所有puzzle
+ (NSMutableArray*) findAllPuzzles;

//获取所有shoot
+ (NSMutableArray*) findAllShoots;

//更新line
+ (int) updateLine:(Line*)line;

//更新puzzle
+ (int) updatePuzzle:(Puzzle*)puzzle;

//更新shoot
+ (int) updateShoot:(Shoot*)shoot;
//更新gamefinishId
+ (int) updateGameFinishId:(Game*)game;
@end
