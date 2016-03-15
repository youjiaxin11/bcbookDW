//
//  Game.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"
#import "Puzzle.h"
#import "Shoot.h"

@interface Game : NSObject

@property int gameId;// 主键自增长
@property int gameNum;// 骰子数
@property int starNum;// 星星数
@property Line *line;// 外键连线题
@property Puzzle *puzzle;// 外键拼图题
@property Shoot *shoot;// 外键射击题
@property int finishId;// 该关卡是否完成的标志位
@end
