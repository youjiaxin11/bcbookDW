//
//  BaseControl.m
//  BXBook
//
//  Created by sunzhong on 15/7/16.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "WebUtil.h"

@implementation BaseControl

@synthesize leftSwipeGestureRecognizer, rightSwipeGestureRecognizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //以下为设置页面左滑和右滑手势
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    //测拉
    NSArray *imageList = @[[UIImage imageNamed:@"side1.png"], [UIImage imageNamed:@"side2.png"], [UIImage imageNamed:@"side3.png"], [UIImage imageNamed:@"side4.png"],[UIImage imageNamed:@"menuClose.png"]];
    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    sideBar.delegate = self;
}

//左滑和右滑的实现
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prompt:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];

}


- (void) prompt2:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void) prompt3:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"再学一会"  otherButtonTitles:@"退出课程", nil];
    [alert show];
}

//Puzzle
- (void) promptPuzzle:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) promptCheats:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"放弃答题" otherButtonTitles:@"通关秘籍", nil];
    [alert show];
}

- (void) promptNotFinish:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"继续答题" otherButtonTitles:nil, nil];
    [alert show];
}


//Line
- (void) promptLine1:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"下一关"  otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void) promptLine2:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"通关秘籍" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void) promptLine3:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void) promptLine4:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"继续答题"  otherButtonTitles:@"开启下一关", nil];
    [alert show];
    
    
}
//Shoot
- (void) promptGoldenNotEnough:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"获取金币" otherButtonTitles:nil, nil];
    [alert show];
}
- (void) promptShootFinish:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"开启任务" otherButtonTitles:nil, nil];
    [alert show];
}
- (void) promptShootNotFinish:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"通关秘籍" otherButtonTitles:nil, nil];
    [alert show];
}

//DragonBoat
- (void) promptCheatsDragonBoat:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"继续答题" otherButtonTitles:@"通关秘籍", nil];
    alert.tag = 20;
    [alert show];
}

//没有通关秘籍的提示框
- (void) promptNoCheats:(NSString*) message{
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"继续答题" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark 请求TCK服务器
#pragma _partUrl 接口路径，只需要后面一截
#pragma _param 参数，多个参数用&隔开
#pragma _callback 回调函数的block
#pragma is_loading 如果为yes就表示要开启一个UIActivityIndicatorView
#pragma is_backup 是否需要备份数据(一般查询的数据需要备份，提交的数据不需要)
#pragma is_solveFail 调用接口失败时，是否内部处理错误
#pragma _frequency 调用接口的频率(单位：秒)，及时调接口，就传入0
- (void)requestTck:(NSString*)_partUrl _param:(NSString*)_param _callback:(ResponseCallback)_callback is_loading:(BOOL)is_loading is_backup:(BOOL)is_backup is_solveFail:(BOOL)is_solveFail _frequency:(int)_frequency {
    WebUtil *util = [[WebUtil alloc] initWithTck:_partUrl _param:_param _control:self];
    [util requestTck:_callback is_loading:is_loading is_backup:is_backup is_solveFail:is_solveFail _frequency:_frequency];
}

#pragma 获取导航条上级控制器
- (BaseControl*)getNavigationControl {
    return [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
}

//登录时长计算
-(NSString*)computeLoginTime:(int)userId {
    NSMutableArray* userLoginArray  = [UserDao findUserLoginByuserId:userId];
    NSTimeInterval timeAll = 0;
    for (int i = 0; i<[userLoginArray count]; i++) {
        NSLog(@"输出时间" );
        UserLogin* ul = [[UserLogin alloc]init];
        ul = [userLoginArray objectAtIndex:i];
        NSTimeInterval time = 0;
        if(ul.loginTime == nil || ul.logoutTime == nil || [ul.loginTime isEqualToString: @""] || [ul.logoutTime isEqualToString:@""]){
        }else{
            time = [TimeUtil allDateContent:ul.loginTime date2:ul.logoutTime];
        }
        timeAll = timeAll + time;
    }
    NSString* timeContent = [TimeUtil computeDateContent:timeAll];
    return timeContent;
}




- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

//向提示视图添加一些自定义内容
- (UIView *)createDemoView:(NSString*)text image:(UIImage*)image
{
    //UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    [imageView setImage:image];
    [demoView addSubview:imageView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 80, 300, 240)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    [textView setBackgroundColor:[UIColor clearColor]];
    [demoView addSubview:textView];

    
    return demoView;
}




- (void)createSelfPrompt:(NSString*)text image:(UIImage*)image{
    [self.view endEditing:YES];
    //[self promptMoon:@"点击月亮呈现出的文字"];
    // Here we need to pass a full frame 这里我们需要跳转到一个全框架
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view 向提示视图添加一些自定义内容
    [alertView setContainerView:[self createDemoView:text image:image]];
    
    // Modify the parameters 修改参数
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"确定", nil]];//修改按钮标题
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate. 你可以用一个Block（闭包：就是能够读取其它函数内部变量的函数），而不是一个Delegate
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
    
}



@end