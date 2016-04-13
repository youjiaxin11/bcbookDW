//
//  User.m
//  BXBook
//
//  Created by sunzhong on 15/7/17.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userId;// 主键自增长
@synthesize loginName;// 登录名
@synthesize password;//密码
@synthesize role;//身份
@synthesize realName;
@synthesize sex;// 性别
@synthesize school;//学校
@synthesize grade;//年级
@synthesize classNum;//班级
@synthesize golden;//金币数
@synthesize receivePraiseNum;//收到的赞数
@synthesize sendPraiseNum;//发出的赞数
@synthesize receiveCommentNum;//收到的评论数
@synthesize sendCommentNum;//发出的评论数
@synthesize  rank;//排行
@synthesize loginTimes,answerRightPer,answerRightTimes,answerTimes;
@synthesize  finishId1,finishId2,finishId3,finishId4,finishId5,finishId6,finishId7,finishId8,finishId9,finishId10,finishId11,finishId12;//12关游戏关卡
@synthesize award1,award2,award3,award4,award5,award6;//6种通关奖励
@synthesize loginLength;
@end