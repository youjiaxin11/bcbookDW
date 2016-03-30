//
//  Zongzi.m
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Zongzi.h"
@interface Zongzi()
@end

@implementation Zongzi
@synthesize user,buttonz;
User *userZongzi;
- (void)viewDidLoad {
    [super viewDidLoad];
    userZongzi = self.user;
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userZongzi.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"Zongzi-(void)viewDidLoad"];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    [self prompt:@"恭喜你成功制作一个粽子啦！" ];
    UIImage *image1=[UIImage imageNamed:@"zongzi"];
    [buttonz setBackgroundImage:image1 forState:UIControlStateNormal];
    
    
    
}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
       usercenter.user = userZongzi;
        [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:usercenter animated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserCenter *usercenter = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserCenter"];
    usercenter.user = userZongzi;
    [usercenter setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:usercenter animated:YES completion:nil];
}

@end
