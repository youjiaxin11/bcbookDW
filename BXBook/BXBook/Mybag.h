//
//  Mybag.h
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "DragonBoat.h"
#import "Makezongzi.h"
#import "UserCenter.h"
@interface Mybag : BaseControl
@property (assign, nonatomic) User *user;//当前登录用户

@property(nonatomic, strong) NSMutableArray * photos;

@property (strong, nonatomic) IBOutlet UITextField *baward1;
@property (strong, nonatomic) IBOutlet UITextField *baward2;
@property (strong, nonatomic) IBOutlet UITextField *baward3;
@property (strong, nonatomic) IBOutlet UITextField *baward4;
@property (strong, nonatomic) IBOutlet UITextField *baward5;
@property (strong, nonatomic) IBOutlet UITextField *presentaward;

@property (strong, nonatomic) IBOutlet UITextField *baward6;
- (IBAction)Makezongzi:(UIButton *)sender;




@end
