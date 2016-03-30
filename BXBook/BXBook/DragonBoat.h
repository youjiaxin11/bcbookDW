//
//  DragonBoat.h
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "TaskChoice.h"
#import "Mybag.h"
@interface DragonBoat : BaseControl

@property (assign, nonatomic) int gameIdDragonBoat;//关卡及难度数，1-12
@property (assign, nonatomic) User *user;//当前登录用户
@property(nonatomic,strong)NSMutableArray *questionsDragonBoat;//用一个数组来保存当前关卡下的所有题目

@property (weak, nonatomic) IBOutlet UILabel *DBQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *DBAnswer1;
@property (weak, nonatomic) IBOutlet UIButton *DBAnswer2;
@property (weak, nonatomic) IBOutlet UIButton *DBAnswer3;
@property (weak, nonatomic) IBOutlet UIButton *DBBeginBtn;
@property (weak, nonatomic) IBOutlet UILabel *DBTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *DBUsePrompt;

@property (assign,nonatomic) int DBFinalTimeUsing;
@property (assign,nonatomic) NSInteger DBCurrentQuestionNumber;
@property (assign,nonatomic) Questions *DBQuestionEntity;
@property (nonatomic,assign) int DBTimeCount;

@end
