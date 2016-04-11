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
    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuMap.png"],[UIImage imageNamed:@"menuClose.png"]];
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


@end