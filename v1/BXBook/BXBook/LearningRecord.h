//
//  LearningRecord.h
//  BXBook
//
//  Created by sunzhong on 15/8/12.r
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "CBChartView.h"

@interface LearningRecord : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (weak, nonatomic) CBChartView *chartView1,*chartView2,*chartView3;
@property (strong, nonatomic) IBOutlet UILabel *loginTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *goldenlBL;
@property (strong, nonatomic) IBOutlet UILabel *rightLbl;
@property (strong, nonatomic) IBOutlet UILabel *rankLbl;
@property (strong, nonatomic) IBOutlet UILabel *loginTimesLbl;

-(int)computeOfflineWorkCount:(int)userId;

-(int)computeOnlineWorkCount:(int)userId;
//登录时长计算
-(NSString*)computeLoginTime:(int)userId;

//计算某个人的所有任务得分
-(NSArray*)computeUserTaskScore:(int)userId;

@end