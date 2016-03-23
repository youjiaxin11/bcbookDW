//
//  ChangePwd.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "ChangePwd.h"

@implementation ChangePwd


User* userChangePwd;

- (void)viewDidLoad {
    [super viewDidLoad];
    userChangePwd = self.user;
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userChangePwd.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"ChangePwd-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}
- (IBAction)inputOldPwd:(id)sender {
    [_oldPwdText setText:nil];
    [_oldPwdText setTextColor:[UIColor blackColor]];
}

- (IBAction)inputNewPwd:(id)sender {
    [_pwdText setText:nil];
    [_pwdText setTextColor:[UIColor blackColor]];
}

- (IBAction)inputNewPwd2:(id)sender {
    [_pwdText2 setText:nil];
    [_pwdText2 setTextColor:[UIColor blackColor]];
}

- (IBAction)changePwd:(id)sender {
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userChangePwd.userId;
    behaviour.doWhat = @"修改密码";
    behaviour.doWhere = @"ChangePwd-(IBAction)changePwd:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    if (_oldPwdText.text == nil || _pwdText == nil || _pwdText2 == nil || [_oldPwdText.text isEqualToString:@""] || [_pwdText.text isEqualToString:@""] || [_pwdText2.text isEqualToString:@""]) {
        [self prompt:@"输入不完整"];
    } else if([_pwdText.text isEqualToString:_pwdText2.text]){
        NSLog(@"11111:%d",[UserDao changePassword:userChangePwd.loginName pwd:_pwdText.text] );
        if([UserDao changePassword:userChangePwd.loginName pwd:_pwdText.text] == 1){
             [self prompt:@"密码修改成功"];
        }else [self prompt:@"密码修改失败"];
    }else
        [self prompt:@"两次输入的新密码不一致"];
    
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end