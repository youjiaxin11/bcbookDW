//
//  LoginView.m
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()
@property (strong, nonatomic) IBOutlet UITextField *loginNameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation LoginView

static int userLoginId1;
static int userId1;
static NSString* loginTime1;
static NSString* logoutTime1;
static int loginState1;
static User *user;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"userLoginId1：：%d", userLoginId1);
    NSLog(@"userId1：：%d", userId1);
    NSLog(@"loginTime1：：%@", loginTime1);
    NSLog(@"logoutTime1：：%@", logoutTime1);
    NSLog(@"loginState1：：%d", loginState1);
    
    //switch按钮自动为上一次推出时选择
    _rememberPassworld.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchStatus"];
    //按照上一次退出时的选择初始化账号密码
    NSArray *user = [[NSUserDefaults standardUserDefaults] arrayForKey:@"userInfo"];
    _loginNameText.text = [user objectAtIndex:0];
    _passwordText.text = [user objectAtIndex:1];
}

//点击登录按钮，判断用户是否正确，是则跳转
- (IBAction)login:(id)sender {
    if (_loginNameText.text == nil || _passwordText == nil || [_loginNameText.text isEqualToString:@""] || [_passwordText.text isEqualToString:@""]) {
        [self prompt:@"输入不完整"];
    } else {
        //
       // [SqliteUtil copySqliteToSandbox];
    int isExist = [UserDao isExistUser:_loginNameText.text pwd:_passwordText.text];
    if (isExist == 1) {
        user = [[User alloc]init];
        user = [UserDao findUserByLoginName:_loginNameText.text];
        NSLog(@"角色：%d",user.role);
        NSLog(@"学校：%d",user.school);
        user.loginTimes++;
        //数据库更新登录次数
        [UserDao updateUserLoginTimes:user];
        
        //获取当前时间
        NSString* timeNow = [TimeUtil getTimeNow];
        NSLog(@"locationString:%@",timeNow);
        UserLogin* userlogin = [[UserLogin alloc]init];
        //保存在数据库
        [UserDao insertUserLogin:user.userId loginTime:timeNow logoutTime:NULL loginState:1];
        //获取最近登录的Userlogin
        int i = [UserDao getUserLoginCount];
        userlogin = [UserDao findUserLoginByuserloginId:i];
        
        userLoginId1 = userlogin.userLoginId;
        userId1 = userlogin.userId;
        loginTime1 = userlogin.loginTime;
        logoutTime1 = userlogin.logoutTime;
        loginState1 = userlogin.loginState;
        
        
        NSArray *array  = [NSArray  arrayWithObjects:[NSString stringWithFormat:@"%d", userLoginId1],  user.loginName, nil ];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //保存数据
        [userDefaults setObject:array  forKey:@"userInfo1"];
        
        NSLog(@"userloginid:%d",userlogin.userLoginId);

        //记录行为数据
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = userlogin.userId;
        behaviour.doWhat = @"登录";
        behaviour.doWhere = @"LoginView-(IBAction)login:(id)sender";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];
        
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = user;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];
    }else if (isExist == 2){
        [self prompt:@"密码错误"];
    }else if (isExist == 3){
        [self prompt:@"用户名不存在"];
    }}
    
    //是否保存账号密码
    if (_rememberPassworld.isOn) {
        //存账号密码的数组
        NSArray *userInfo  = [NSArray  arrayWithObjects:_loginNameText.text,_passwordText.text,nil ];
        //保存到userDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userInfo forKey:@"userInfo"];
        //保存到磁盘
        [userDefaults synchronize];
    }else{
        //清除保存账号信息
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo removeObjectForKey:@"userInfo"];
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    LearningRecord *record = [[LearningRecord alloc]init];
    int works = [record computeOfflineWorkCount:user.userId];
    int finishNums = [self computeFinishGameNums];
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSString* message = [NSString stringWithFormat:@"亲爱的同学，\n你已通过了%d关，\n完成了%d个作品，\n得到了%d个游戏币，\n在小伙伴中排行第%d名，\n你还要继续学习吗？",finishNums,works,user.golden,user.rank];
        [self prompt3:message];
    }
}

//计算完成关卡数
-(int)computeFinishGameNums {
    int num = 0;
    if (user.finishId1 == 1) {
        num++;
    }
    if (user.finishId2 == 1) {
        num++;
    }
    if (user.finishId3 == 1) {
        num++;
    }
    if (user.finishId4 == 1) {
        num++;
    }
    if (user.finishId5 == 1) {
        num++;
    }
    if (user.finishId6 == 1) {
        num++;
    }
    if (user.finishId7 == 1) {
        num++;
    }
    if (user.finishId8 == 1) {
        num++;
    }
    if (user.finishId9 == 1) {
        num++;
    }
    if (user.finishId10 == 1) {
        num++;
    }
    if (user.finishId11 == 1) {
        num++;
    }
    if (user.finishId12 == 1) {
        num++;
    }
    return num;
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        
        NSString* timeNow = [TimeUtil getTimeNow];
        [UserDao updateUserLoginLogoutTime:userLoginId1 logoutTime:timeNow];
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *viewcontroller = [mainStoryboard instantiateViewControllerWithIdentifier:@"Index"];
        [viewcontroller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:viewcontroller animated:YES completion:nil];
        
        //记录行为数据
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = user.userId;
        behaviour.doWhat = @"退出";
        behaviour.doWhere = @"LoginView-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];

    }
}

//保存switch按钮改变的结果
- (IBAction)switchDidChange:(UISwitch *)sender {
    NSUserDefaults *switchState = [NSUserDefaults standardUserDefaults];
    [switchState setBool:sender.isOn forKey:@"switchStatus"];
}

//点击屏幕，退出键盘
- (IBAction)backgroundTap:(id)sender{
    [self.loginNameText resignFirstResponder];
    [self.passwordText resignFirstResponder];
}

@end
