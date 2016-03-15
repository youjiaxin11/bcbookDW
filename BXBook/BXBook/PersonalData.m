//
//  PersonalData.m
//  BXBook
//
//  Created by sunzhong on 15/8/31.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "PersonalData.h"




@implementation PersonalData
@synthesize nameLbl, xuehaoLbl, loginTimeLbl, rightLbl,offlineWorkLbl,onlineWorkLbl,recComLbl,recPraiseLbl,senComLbl,senPraiseLbl,work1Lbl,work2Lbl,work3Lbl,work4Lbl,work5Lbl,work6Lbl,goldenlBL,loginTimesLbl,rankLbl;


User* userData;

- (void)viewDidLoad {
    [super viewDidLoad];
    userData = self.user;
    [nameLbl setText:userData.realName];
    [xuehaoLbl setText:userData.loginName];
    [goldenlBL setText:[NSString stringWithFormat:@"%d",userData.golden]];
    [recPraiseLbl setText:[NSString stringWithFormat:@"%d",userData.receivePraiseNum]];
    [senPraiseLbl setText:[NSString stringWithFormat:@"%d",userData.sendPraiseNum]];
    [recComLbl setText:[NSString stringWithFormat:@"%d",userData.receiveCommentNum]];
    [senComLbl setText:[NSString stringWithFormat:@"%d",userData.sendCommentNum]];
    [loginTimeLbl setText:[self computeLoginTime:userData.userId]];
    [loginTimesLbl setText:[NSString stringWithFormat:@"%d",userData.loginTimes]];
    [offlineWorkLbl setText:[NSString stringWithFormat:@"%d",[self computeOfflineWorkCount:userData.userId]]];
    [onlineWorkLbl setText:[NSString stringWithFormat:@"%d",[self computeOnlineWorkCount:userData.userId]]];
    [rightLbl setText:userData.answerRightPer];
    [rankLbl setText:[NSString stringWithFormat:@"%d",userData.rank]];
    //任务得分
    NSArray* taskScore = [self computeUserTaskScore:userData.userId];
    [work1Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:0] floatValue]]];
    [work2Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:1] floatValue]]];
    [work3Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:2] floatValue]]];
    [work4Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:3] floatValue]]];
    [work5Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:4] floatValue]]];
    [work6Lbl setText:[NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:5] floatValue]]];
    
    
    // 使用方法
 //   CBChartView *chartView = [CBChartView charView];
    CBChartView *chartView = [[CBChartView alloc] init];
    chartView.frame = CGRectMake(500, 400, 300, 220);
    [self.view addSubview:chartView];
    chartView.xValues = @[@"1", @"2",@"3", @"4", @"5", @"6"];
    NSString* s1= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:0] floatValue]];
    NSString* s2= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:1] floatValue]];
    NSString* s3= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:2] floatValue]];
    NSString* s4= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:3] floatValue]];
    NSString* s5= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:4] floatValue]];
    NSString* s6= [NSString stringWithFormat:@"%.2f",[[taskScore objectAtIndex:5] floatValue]];
    if ([s1 floatValue]==0.00 &&
        [s2 floatValue]==0.00 &&
        [s3 floatValue]==0.00 &&
        [s4 floatValue]==0.00 &&
        [s5 floatValue]==0.00 &&
        [s6 floatValue]==0.00 ) {
        chartView.yValues = @[@"0.1",@"0.1",@"0.1",@"0.1",@"0.1",@"0.1"];
    }else{
        chartView.yValues = @[s1,s2,s3,s4,s5,s6];

    }
    chartView.chartColor = [UIColor greenColor];
    self.chartView = chartView;
 
    
}

//登录时长计算
-(NSString*)computeLoginTime:(int)userId {
    NSMutableArray* userLoginArray  = [UserDao findUserLoginByuserId:userId];
    NSTimeInterval timeAll = 0;
    for (int i = 0; i<[userLoginArray count]; i++) {
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

-(int)computeOfflineWorkCount:(int)userId{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    array = [WorkDao findWorkByUserId:userId];
    return [array count];
}

-(int)computeOnlineWorkCount:(int)userId{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    array = [WorkDao findOnlineWorkByUserId:userId];
    return [array count];
}

//计算某个人的所有任务得分
-(NSArray*)computeUserTaskScore:(int)userId{
    NSMutableArray* array1 = [TaskDao findUserTaskByUserId:userId Task:1];
    NSMutableArray* array2 = [TaskDao findUserTaskByUserId:userId Task:2];
    NSMutableArray* array3 = [TaskDao findUserTaskByUserId:userId Task:3];
    NSMutableArray* array4 = [TaskDao findUserTaskByUserId:userId Task:4];
    NSMutableArray* array5 = [TaskDao findUserTaskByUserId:userId Task:5];
    NSMutableArray* array6 = [TaskDao findUserTaskByUserId:userId Task:6];

    float score1=0,score2=0,score3=0,score4=0,score5=0,score6=0;
    UserTask* ut = [[UserTask alloc]init];
    if ([array1 count]>0) {
        for (int i = 0; i<[array1 count]; i++) {
            ut = [array1 objectAtIndex:i];
            score1 = score1 + (float)ut.score;
        }
        score1 = score1/[array1 count];
    }
    if ([array2 count]>0) {
        for (int i = 0; i<[array2 count]; i++) {
            ut = [array2 objectAtIndex:i];
            score2 = score2 + (float)ut.score;
        }
        score2 = score2/[array2 count];
    }
    if ([array3 count]>0) {
        for (int i = 0; i<[array3 count]; i++) {
            ut = [array3 objectAtIndex:i];
            score3 = score3 + (float)ut.score;
        }
        score3 = score3/[array3 count];
    }
    if ([array4 count]>0) {
        for (int i = 0; i<[array4 count]; i++) {
            ut = [array4 objectAtIndex:i];
            score4 = score4 + (float)ut.score;
        }
        score4 = score4/[array4 count];
    }
    if ([array5 count]>0) {
        for (int i = 0; i<[array5 count]; i++) {
            ut = [array5 objectAtIndex:i];
            score5 = score5 + (float)ut.score;
        }
        score5 = score5/[array5 count];
    }
    if ([array6 count]>0) {
        for (int i = 0; i<[array6 count]; i++) {
            ut = [array6 objectAtIndex:i];
            score6 = score6 + (float)ut.score;
        }
        score6 = score6/[array6 count];
    }
    NSNumber* num1 = [NSNumber numberWithFloat:score1];
    NSNumber* num2 = [NSNumber numberWithFloat:score2];
    NSNumber* num3 = [NSNumber numberWithFloat:score3];
    NSNumber* num4 = [NSNumber numberWithFloat:score4];
    NSNumber* num5 = [NSNumber numberWithFloat:score5];
    NSNumber* num6 = [NSNumber numberWithFloat:score6];
    
    NSArray* scoreArray = [NSArray arrayWithObjects: num1,num2,num3,num4,num5,num6,nil];
    return scoreArray;
}

//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//跳转到任务游戏数据
- (IBAction)gametaskdataCenter:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GameTaskData *next = [mainStoryboard instantiateViewControllerWithIdentifier:@"GameTaskData"];
    next.user = userData;
    [next setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:next animated:YES completion:nil];
    
}

@end
