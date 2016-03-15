//
//  UserInfo.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface UserInfo : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UILabel *realNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *loginNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *schoolLbl;
@property (strong, nonatomic) IBOutlet UILabel *gradeLbl;
@property (strong, nonatomic) IBOutlet UILabel *classLbl;
@property (strong, nonatomic) IBOutlet UILabel *goldenLbl;
@property (strong, nonatomic) IBOutlet UILabel *revPraiseLbl;
@property (strong, nonatomic) IBOutlet UILabel *senPraiseLbl;
@property (strong, nonatomic) IBOutlet UILabel *revComLbl;
@property (strong, nonatomic) IBOutlet UILabel *senComLbl;

@end
