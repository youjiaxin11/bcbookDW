//
//  AppDelegate.m
//  BXBook
//
//  Created by sunzhong on 15/7/7.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UserDao.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

int loginState = 0;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [application beginBackgroundTaskWithExpirationHandler:^(){
        //程序在10分钟内未被系统关闭或者强制关闭，则程序会调用此代码块，可以在这里做一些保存或者清理工作
        NSString* timeNow = [TimeUtil getTimeNow];
        NSLog(@"退出的时间：%@", timeNow);
        
        //加载数据
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray* array = [userDefaults objectForKey:@"userInfo1"];
        int loginId = [[array objectAtIndex:0] intValue];
        NSLog(@"login id :  %d", loginId);
        [UserDao updateUserLoginLogoutTime:loginId logoutTime:timeNow];
        
        UserLogin * userLogin = [UserDao findUserLoginByuserloginId:loginId];
     
        //更新登录时长
        NSMutableArray* userLoginArray  = [UserDao findUserLoginByuserId:userLogin.userId];
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
        [UserDao updateUserLoginLength:userLogin.userId loginLength:timeContent];
        loginState = 1;
        
        NSLog(@"程序在后台被默默关闭");
        
        //记录行为数据
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = userLogin.userId;
        behaviour.doWhat = @"退出";
        behaviour.doWhere = @"AppDelegate-(void)applicationDidEnterBackground:(UIApplication *)application";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSString* timeNow = [TimeUtil getTimeNow];
    NSLog(@"从后台回到前台的时间：%@", timeNow);
    NSArray * array = [[NSArray alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (loginState == 1) {//end
        [userDefaults synchronize];
        array = [userDefaults objectForKey:@"userInfo1"];
        NSString *loginName = [array objectAtIndex:1];
        User *userLogin = [UserDao findUserByLoginName:loginName];
        [UserDao insertUserLogin:userLogin.userId loginTime:timeNow logoutTime:NULL loginState:1];
        loginState = 0;
        NSLog(@"重新登录");
        
        
        //获取最近登录的Userlogin
        int k = [UserDao getUserLoginCount];
        UserLogin *userlogin = [UserDao findUserLoginByuserloginId:k];
        NSArray* array2  = [NSArray  arrayWithObjects:[NSString stringWithFormat:@"%d", userlogin.userLoginId],  userLogin.loginName, nil ];
        //保存数据
        [userDefaults setObject:array2  forKey:@"userInfo1"];
        
        //记录行为数据
        Behaviour *behaviour = [[Behaviour alloc]init];
        behaviour.userId = userlogin.userId;
        behaviour.doWhat = @"登录";
        behaviour.doWhere = @"AppDelegate-(void)applicationWillEnterForeground:(UIApplication *)application";
        behaviour.doWhen = timeNow;
        [BehaviourDao addBehaviour:behaviour];

    }else if (loginState == 0){//not end
        [userDefaults synchronize];
        NSLog(@"未退出继续");
        
    }

   }

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSString* timeNow = [TimeUtil getTimeNow];
    NSLog(@"退出的时间：%@", timeNow);
    
    //加载数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* array = [userDefaults objectForKey:@"userInfo1"];
    int loginId = [[array objectAtIndex:0] intValue];
    NSLog(@"login id :  %d", loginId);
    [UserDao updateUserLoginLogoutTime:loginId logoutTime:timeNow];
  //  [userDefaults removeObjectForKey:@"userInfo1"];
    UserLogin * userLogin = [UserDao findUserLoginByuserloginId:loginId];

    loginState = 1;
    
    //更新登录时长
    NSMutableArray* userLoginArray  = [UserDao findUserLoginByuserId:userLogin.userId];
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
    NSLog(@"登录时长：%@",timeContent);
   
    [UserDao updateUserLoginLength:userLogin.userId loginLength:timeContent];
    
    
    NSLog(@"程序强制关闭");
    
    //记录行为数据
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLogin.userId;
    behaviour.doWhat = @"退出";
    behaviour.doWhere = @"AppDelegate-(void)applicationWillTerminate:(UIApplication *)application";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
}

@end
