//
//  LearningRecord.m
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "LearningRecord.h"
#import "UploadAudio.h"
#import "UploadPhoto.h"
#import "UploadVideo.h"
#import "NotebookController.h"

@implementation LearningRecord
@synthesize loginTimeLbl,loginTimesLbl,goldenlBL,rankLbl,rightLbl;

User* userLearningRecord;

- (void)viewDidLoad {
    [super viewDidLoad];
    userLearningRecord = self.user;
    NSLog(@"%@",userLearningRecord.loginName);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLearningRecord.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"LearningRecord-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    //左上
    [goldenlBL setText:[NSString stringWithFormat:@"%d",userLearningRecord.golden]];
    [loginTimeLbl setText:[self computeLoginTime:userLearningRecord.userId]];
    [loginTimesLbl setText:[NSString stringWithFormat:@"%d",userLearningRecord.loginTimes]];
    [rightLbl setText:userLearningRecord.answerRightPer];
    [rankLbl setText:[NSString stringWithFormat:@"%d",userLearningRecord.rank]];
   //  [rankLbl setText:@"1"];
    
    //右上图表
    CBChartView *chart1 = [[CBChartView alloc] init];
    chart1.frame = CGRectMake(600, 277, 280, 160);
    [self.view addSubview:chart1];
    chart1.xValues = @[@"收评论", @"发评论",@"收赞", @"点赞"];
    if (userLearningRecord.receivePraiseNum==0 &&
        userLearningRecord.sendPraiseNum==0&&
        userLearningRecord.receiveCommentNum==0&&
        userLearningRecord.sendCommentNum==0) {
        chart1.yValues = @[@"0.1",@"0.1",@"0.1",@"0.1"];
    }else{
        chart1.yValues = @[[NSString stringWithFormat:@"%d",userLearningRecord.receiveCommentNum], [NSString stringWithFormat:@"%d",userLearningRecord.sendCommentNum],[NSString stringWithFormat:@"%d",userLearningRecord.receivePraiseNum], [NSString stringWithFormat:@"%d",userLearningRecord.sendPraiseNum]];
    //    chart1.yValues = @[@"8", @"5", @"6", @"7"];
        
    }
    chart1.chartColor = [UIColor blueColor];
    self.chartView1 = chart1;
    
    
    //左下图表
    CBChartView *chart2 = [[CBChartView alloc] init];
    chart2.frame = CGRectMake(205, 500, 280, 160);
    [self.view addSubview:chart2];
    chart2.xValues = @[@"本地",@"网络"];
    if ([self computeOfflineWorkCount:userLearningRecord.userId] ==0 &&
        [self computeOnlineWorkCount:userLearningRecord.userId]==0) {
        chart2.yValues = @[@"0.1",@"0.1"];
     //   chart2.yValues = @[@"3",@"2"];
    }else{
        chart2.yValues = @[[NSString stringWithFormat:@"%d",[self computeOfflineWorkCount:userLearningRecord.userId]],[NSString stringWithFormat:@"%d",[self computeOnlineWorkCount:userLearningRecord.userId]]];
     //   chart2.yValues = @[@"5",@"2"];
        
    }
    chart2.chartColor = [UIColor blueColor];
    self.chartView2 = chart2;
    
    
    //右下图表
    //任务得分
    NSArray* taskScore = [self computeUserTaskScore:userLearningRecord.userId];
    CBChartView *chartView = [[CBChartView alloc] init];
    chartView.frame = CGRectMake(600, 500, 280, 160);
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
      //  chartView.yValues = @[@"3",@"5",@"3",@"4",@"4",@"5"];
        
    }
    chartView.chartColor = [UIColor blueColor];
    self.chartView3 = chartView;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 300,70)];
}
- (void)menuButtonClicked:(int)index{
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userLearningRecord.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"LearningRecord-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userLearningRecord;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userLearningRecord;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userLearningRecord;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userLearningRecord;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
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
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
