//
//  Makezongzi.h
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "Mybag.h"
#import "Zongzi.h"
@interface Makezongzi: BaseControl
@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UIButton *button6;

@property (strong, nonatomic) IBOutlet UITextField *step1;
@property (strong, nonatomic) IBOutlet UITextField *step2;
@property (strong, nonatomic) IBOutlet UITextField *step3;
@property (strong, nonatomic) IBOutlet UITextField *step4;
@property (strong, nonatomic) IBOutlet UITextField *step5;
@property (strong, nonatomic) IBOutlet UITextField *step6;
- (IBAction)finish:(UIButton *)sender;

@end