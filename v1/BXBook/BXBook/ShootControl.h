//
//  ShootControl.h
//  BXBook
//
//  Created by sunzhong on 15/7/18.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "Cheats.h"
#import "TaskChoice.h"

@interface ShootControl : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (weak, nonatomic) IBOutlet UIButton *image2;
@property (weak, nonatomic) IBOutlet UIButton *image3;
@property (weak, nonatomic) IBOutlet UIButton *sound1;
@property (weak, nonatomic) IBOutlet UIButton *sound2;
@property (weak, nonatomic) IBOutlet UIButton *sound3;
-(int)returngameId;
@property (strong, nonatomic) IBOutlet UILabel *goldenLbl;

@end