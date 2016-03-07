//
//  UserInfo.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UserInfo.h"

@implementation UserInfo


User* userUserInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUserInfo = self.user;
    [_realNameLbl setText:userUserInfo.realName];
    [_loginNameLbl setText:userUserInfo.loginName];
    
    if(userUserInfo.school == 1)
        [_schoolLbl setText:@"白家庄小学本部"];
    else if(userUserInfo.school == 2)
        [_schoolLbl setText:@"白家庄小学第一分校"];
    else if(userUserInfo.school == 3)
        [_schoolLbl setText:@"白家庄小学第二分校"];

    [_gradeLbl setText:[NSString stringWithFormat:@"%d年级", userUserInfo.grade]];
    [_classLbl setText:[NSString stringWithFormat:@"%d班", userUserInfo.classNum]];
    [_goldenLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.golden]];
    [_revPraiseLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.receivePraiseNum]];
    [_senPraiseLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.sendPraiseNum]];
    [_revComLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.receiveCommentNum]];
    [_senComLbl setText:[NSString stringWithFormat:@"%d",userUserInfo.sendCommentNum]];
}



//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
