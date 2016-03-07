
//
//  LineControl.h
//  BXBook
//
//  Created by sunzhong on 15/7/17.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "PuzzleControl.h"

@interface LineControl : BaseControl

@property (assign, nonatomic) int gameChoiceNum;//关卡及难度数，1-12
@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Game *game;//存放数据表中关卡表game的实体类和对象
@property (weak, nonatomic) IBOutlet UIButton *button1;

@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

- (IBAction)button7:(UIButton *)sender;
- (IBAction)button8:(UIButton *)sender;
- (IBAction)button9:(UIButton *)sender;
- (IBAction)button10:(UIButton *)sender;
- (IBAction)button11:(UIButton *)sender;
- (IBAction)button12:(UIButton *)sender;
- (IBAction)tijiao:(UIButton *)sender;
- (IBAction)qingchu:(UIButton *)sender;
-(void) huaxian1:(UIButton *)btn1 btn:(UIButton *)btn2;
-(void) huaxian2:(UIButton *)btn1 btn:(UIButton *)btn2;
-(void) huaxian3:(UIButton *)btn1 btn:(UIButton *)btn2;
-(void)nextpage1;
-(void)nextpage2;
-(void)deleteline;
@property (strong, nonatomic) IBOutlet UILabel *goldenLbl;
@property (strong, nonatomic) IBOutlet UILabel *lineContentLbl;
@end