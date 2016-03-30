//
//  User.h
//  BXBook
//
//  Created by sunzhong on 15/7/17.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property int userId;// 主键自增长
@property NSString *loginName;// 登录名
@property NSString *password;//密码
@property int role;//身份
@property NSString *realName;
@property int sex;// 性别
@property int school;//学校
@property int grade;//年级
@property int classNum;//班级
@property int golden;//金币数
@property int receivePraiseNum;//收到的赞数
@property int sendPraiseNum;//发出的赞数
@property int receiveCommentNum;//收到的评论数
@property int sendCommentNum;//发出的评论数
@property int rank;//排行
@property int loginTimes;// 登陆次数
@property int answerTimes;//答题次数
@property int answerRightTimes;//正确次数
@property NSString* answerRightPer;// 正确率
@property int finishId1;//游戏关卡1
@property int finishId2;//游戏关卡2
@property int finishId3;//游戏关卡3
@property int finishId4;//游戏关卡4
@property int finishId5;//游戏关卡5
@property int finishId6;//游戏关卡6
@property int finishId7;//游戏关卡7
@property int finishId8;//游戏关卡8
@property int finishId9;//游戏关卡9
@property int finishId10;//游戏关卡10
@property int finishId11;//游戏关卡11
@property int finishId12;//游戏关卡12
@property int award1;//通关奖励1
@property int award2;//通关奖励2
@property int award3;//通关奖励3
@property int award4;//通关奖励4
@property int award5;//通关奖励5
@property int award6;//通关奖励6
@end