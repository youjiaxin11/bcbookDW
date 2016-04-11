//
//  ViewController.m
//  BXBook
//
//  Created by sunzhong on 15/7/7.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 设定位置和大小
//    CGRect frame = CGRectMake(0,0,0,0);
//    frame.size = [UIImage imageNamed:@"0欢迎页GIF2.gif"].size;
//    // 读取gif图片数据
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"0欢迎页GIF2" ofType:@"gif"]];
//    // view生成
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
//    webView.userInteractionEnabled = NO;//用户不可交互
//    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [self.view addSubview:webView];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        [SqliteUtil copySqliteToSandbox];//拷贝sqlite数据库到沙盒中
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginview:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginView *loginview = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [loginview setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:loginview animated:YES completion:nil];
}

- (IBAction)clickMoon:(id)sender {
    
    [self moonCheat];
}

- (void)moonCheat{
    //[self promptMoon:@"点击月亮呈现出的文字"];
    // Here we need to pass a full frame 这里我们需要跳转到一个全框架
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view 向提示视图添加一些自定义内容
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters 修改参数
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"好的", nil]];//修改按钮标题
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

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView//向提示视图添加一些自定义内容
{
    //UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 458, 432)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 458, 432)];
    [imageView setImage:[UIImage imageNamed:@"demo"]];
    [demoView addSubview:imageView];
    
    return demoView;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Index"];
    //[viewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];//上推效果，默认
    //[viewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];//水平反转
    //[viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];//隐出隐现
    //[viewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];//翻页效果
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //animation.type = @"pageCurl";//向上翻一页
    //animation.type = @"pageUnCurl";//向下翻一页
    animation.type = @"rippleEffect";//滴水效果(效果合适)
    //animation.type = @"suckEffect";//收缩效果，如一块布被抽走
    //animation.type = @"cube";//立方体效果
    //animation.type = @"oglFlip";//左右翻转效果
    //animation.type = kCATransitionFade;//淡出
    //animation.type = kCATransitionMoveIn;//从左向右覆盖原图
    //animation.type = kCATransitionPush;//推出
    //animation.type = kCATransitionReveal;//跟推出差不多

    //animation.subtype = kCATransitionFromRight;
    animation.subtype = kCATransitionFromLeft;// 默认值
    //animation.subtype = kCATransitionFromTop;
    //animation.subtype = kCATransitionFromBottom;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:viewController animated:NO completion:nil];
}

@end
