//
//  UserCenter.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "UserCenter.h"
#import "PersonalData.h"

@implementation UserCenter
@synthesize admDataCen;

User* userUserCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    userUserCenter = self.user;
    if ([userUserCenter.loginName isEqualToString:@"admin"]) {
    }else{
        admDataCen.hidden = YES;
    }
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Information *information = [mainStoryboard instantiateViewControllerWithIdentifier:@"Information"];
        information.user = userUserCenter;
        [information setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:information animated:YES completion:nil];    }
}

//学习轨迹
- (IBAction)learningTrack:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LearningRecord *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"LearningRecord"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//我的好友
- (IBAction)myFriends:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyFriend *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyFriend"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//我的作品
- (IBAction)myWorks:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyWorks *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyWorks"];
    nextpage.user = userUserCenter;
    nextpage.pageType = 1;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//伙伴排行
- (IBAction)friendsRank:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendLevel *nextpage = [mainStoryboard instantiateViewControllerWithIdentifier:@"FriendLevel"];
    nextpage.user = userUserCenter;
    [nextpage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nextpage animated:YES completion:nil];
}

//个人信息
- (IBAction)userInfo:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserInfo *userinfo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserInfo"];
    userinfo.user = userUserCenter;
    [userinfo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:userinfo animated:YES completion:nil];
}

//修改密码
- (IBAction)changePassword:(id)sender{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangePwd *changepwd = [mainStoryboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    changepwd.user = userUserCenter;
    [changepwd setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:changepwd animated:YES completion:nil];
}
//跳转到数据中心
- (IBAction)dataCenter:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalData *next = [mainStoryboard instantiateViewControllerWithIdentifier:@"PersonalData"];
    next.user = userUserCenter;
    [next setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:next animated:YES completion:nil];

}
@end
