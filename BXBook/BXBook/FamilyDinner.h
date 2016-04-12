//
//  FamilyDinner.h
//  BCBookDW
//
//  Created by sunzhong on 16/1/25.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "DragonBoat.h"
#import "FamilyDinnerQuestion.h"
@interface FamilyDinner : BaseControl
@property (assign, nonatomic) int gameIdFamilyDinner;//关卡及难度数，1-12
@property (assign, nonatomic) User *user;//当前登录用户
@property(nonatomic,strong)NSMutableArray *questionsFamilyDinner;//用一个数组来保存当前关卡下的所有题目

@property (weak, nonatomic) IBOutlet UIButton *fbutton;
@property (weak, nonatomic) IBOutlet UIButton *mbutton;
@property (weak, nonatomic) IBOutlet UIButton *gfbutton;
@property (weak, nonatomic) IBOutlet UIButton *gmbutton;
@property (assign, nonatomic) int fanswerTotalNum;
@property (assign, nonatomic)int fquestionRightNum1;
@property (assign, nonatomic)int fquestionRightNum2;
@property (assign, nonatomic)int fquestionRightNum3;
@property (assign, nonatomic)int fquestionRightNum4;
@property (assign, nonatomic) int findex;

@property (strong, nonatomic) IBOutlet UIImageView *finallyImage;
@property (strong, nonatomic) IBOutlet UIButton *nextGameButton;


@end
