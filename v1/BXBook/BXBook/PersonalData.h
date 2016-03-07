//
//  PersonalData.h
//  BXBook
//
//  Created by sunzhong on 15/8/31.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "CBChartView.h"
#import "GameTaskData.h"


@interface PersonalData : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) int taskChoiceId;//选择任务卡的id

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *xuehaoLbl;
@property (strong, nonatomic) IBOutlet UILabel *loginTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *goldenlBL;
@property (strong, nonatomic) IBOutlet UILabel *rightLbl;
@property (strong, nonatomic) IBOutlet UILabel *rankLbl;
@property (strong, nonatomic) IBOutlet UILabel *onlineWorkLbl;
@property (strong, nonatomic) IBOutlet UILabel *offlineWorkLbl;
@property (strong, nonatomic) IBOutlet UILabel *recPraiseLbl;
@property (strong, nonatomic) IBOutlet UILabel *senPraiseLbl;
@property (strong, nonatomic) IBOutlet UILabel *recComLbl;
@property (strong, nonatomic) IBOutlet UILabel *senComLbl;
@property (strong, nonatomic) IBOutlet UILabel *work1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *work2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *work3Lbl;
@property (strong, nonatomic) IBOutlet UILabel *work4Lbl;
@property (strong, nonatomic) IBOutlet UILabel *work5Lbl;
@property (strong, nonatomic) IBOutlet UILabel *work6Lbl;
@property (strong, nonatomic) IBOutlet UILabel *loginTimesLbl;

-(NSString*) computeLoginTime:(int)userId;


@property (weak, nonatomic) CBChartView *chartView;

@end