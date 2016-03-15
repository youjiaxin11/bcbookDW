//
//  GameTaskData.m
//  BXBook
//
//  Created by sunzhong on 15/9/2.
//  Copyright (c) 2015年 cnu. All rights reserved.
//
#import "GameTaskData.h"




@implementation GameTaskData
@synthesize DataTable;


User* userGameTaskData;
NSMutableArray* dataArray1,*dataArray2,*dataArray3,*dataArray4,*dataArray5,*dataArray6,*titleArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    userGameTaskData = self.user;
    
    //任务平均得分
    NSMutableArray* aveScore = [self computeTaskAverageScore];
    NSMutableArray* aveScore2 = [[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        NSString* s = [NSString stringWithFormat:@"任务%d：%.2f",i+1,[[aveScore objectAtIndex:0] floatValue]];
        [aveScore2 addObject:s];
    }
    
    //任务完成人次
    NSMutableArray* doneTimes = [self computeTaskDonePeople];
    NSMutableArray* doneTimes2 = [[NSMutableArray alloc]init];
    for (int i=0; i<6; i++) {
        NSString* s = [NSString stringWithFormat:@"任务%d：%d",i+1,[[doneTimes objectAtIndex:i] integerValue]];
        [doneTimes2 addObject:s];
    }
    
    //通关秘籍浏览人次
    NSMutableArray* help = [HelpDao getAllHelps];
    NSMutableArray* help2 = [[NSMutableArray alloc]init];
    for (int i=0; i<[help count]; i++) {
        Help* hp = [help objectAtIndex:i];
        NSString* s = [NSString stringWithFormat:@"通关秘籍%d：%d",i+1, hp.viewTimes];
        [help2 addObject:s];
    }
    
    //连线题正确率
    NSMutableArray* lineArray = [GameDao findAllLines];
    NSMutableArray* linePer = [[NSMutableArray alloc]init];
    for (int i=0; i<[lineArray count]; i++) {
        Line* ln = [lineArray objectAtIndex:i];
        NSLog(@"gameTaskData:连线题正确率：%@",ln.answerRightPer);
        NSString* s = [NSString stringWithFormat:@"连线题%d：%@", i+1, ln.answerRightPer];
        [linePer addObject:s];
    }
    //拼图题正确率
    NSMutableArray* puzzleArray = [GameDao findAllPuzzles];
    NSMutableArray* puzzlePer = [[NSMutableArray alloc]init];
    for (int i=0; i<[puzzleArray count]; i++) {
        Puzzle* pz = [puzzleArray objectAtIndex:i];
        NSString* s1 = [NSString stringWithFormat:@"拼图题%d-1：%@", i+1, pz.answerRightPer1];
        NSString* s2 = [NSString stringWithFormat:@"拼图题%d-2：%@", i+1, pz.answerRightPer2];
        NSString* s3 = [NSString stringWithFormat:@"拼图题%d-3：%@", i+1, pz.answerRightPer3];
        NSString* s4 = [NSString stringWithFormat:@"拼图题%d-4：%@", i+1, pz.answerRightPer4];
        [puzzlePer addObject:s1];
        [puzzlePer addObject:s2];
        [puzzlePer addObject:s3];
        [puzzlePer addObject:s4];
    }
    //射击题正确率
    NSMutableArray* shootArray = [GameDao findAllShoots];
    NSMutableArray* shootPer = [[NSMutableArray alloc]init];
    for (int i=0; i<[shootArray count]; i++) {
        Shoot* sh = [shootArray objectAtIndex:i];
        NSLog(@"ppppppp:%@",sh.question);
        NSString* s = [NSString stringWithFormat:@"射击题%d：%@", i+1, sh.answerRightPer];
        [shootPer addObject:s];
    }
    
    //初始化tableview
    DataTable = [[UITableView alloc] initWithFrame:CGRectMake(100, 80, 400, 630)];//指定位置大小
    [DataTable setDelegate:self];//指定委托
    [DataTable setDataSource:self];//指定数据委托
    [self.view addSubview:DataTable];//加载tableview
    
    dataArray1 = aveScore2;//任务平均得分
    dataArray2 = doneTimes2;//任务完成人次
    dataArray3 = help2;//通关秘籍浏览人次
    dataArray4 = linePer;//连线题正确率
    dataArray5 = puzzlePer;//拼图题正确率
    dataArray6 = shootPer;//射击题正确率
    titleArray = [[NSMutableArray alloc] initWithObjects:@"任务平均得分", @"任务完成人次",@"通关秘籍浏览人次", @"连线题正确率",@"拼图题正确率",@"射击题正确率",nil];//初始化标题数组
    

}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//计算任务平均得分
-(NSMutableArray*) computeTaskAverageScore{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (int i=1; i<=6; i++) {
        NSMutableArray* taskarray = [TaskDao findUserTaskByTaskId:i];
        int size = [taskarray count];
        float averScore =0;
        
        if (size>0) {
            float sum = 0;
            for (int j=0; j<size; j++) {
                UserTask* ut =[taskarray objectAtIndex:j];
                sum = sum + ut.score;
            }
            averScore = sum/(float)[taskarray count];
        }

        NSNumber* num = [NSNumber numberWithFloat:averScore];
        [array addObject:num];
    }
    return array;
}

//计算任务完成人次
-(NSMutableArray*) computeTaskDonePeople{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (int i=1; i<=6; i++) {
        NSMutableArray* taskarray = [TaskDao findUserTaskByTaskId:i];
        int size = [taskarray count];
        NSNumber* num = [NSNumber numberWithInt:size];
        [array addObject:num];
    }
    return array;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        case 1:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        case 2:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        case 3:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        case 4:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        case 5:
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
        default:
            return @"Unknown";
    }
}



//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
}



//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return  [dataArray1 count];//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            break;
        case 1:
            return  [dataArray2 count];
          break;
        case 2:
            return  [dataArray3 count];//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            break;
        case 3:
            return  [dataArray4 count];
            break;
        case 4:
            return  [dataArray5 count];
            break;
        case 5:
            return  [dataArray6 count];
            break;
        default:
            return 0;
            break;
    }
}



//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    //初始化cell并指定其类型，也可自定义cell
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    　　if(cell == nil)
        　　{
            　　cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] ;
        }
    　　switch (indexPath.section) {
            　　case 0://对应各自的分区
            　　　　[[cell textLabel]  setText:[dataArray1 objectAtIndex:indexPath.row]];//给cell添加数据
        　　　　break;
            　　case 1:
            　　　　[[cell textLabel]  setText:[dataArray2 objectAtIndex:indexPath.row]];
            　　　　break;
        case 2://对应各自的分区
            　　　　[[cell textLabel]  setText:[dataArray3 objectAtIndex:indexPath.row]];//给cell添加数据
            　　　　break;
            　　case 3:
            　　　　[[cell textLabel]  setText:[dataArray4 objectAtIndex:indexPath.row]];
            　　　　break;
        case 4:
            　　　　[[cell textLabel]  setText:[dataArray5 objectAtIndex:indexPath.row]];
            　　　　break;
        case 5:
            　　　　[[cell textLabel]  setText:[dataArray6 objectAtIndex:indexPath.row]];
            　　　　break;
            　　default:
            　　　　[[cell textLabel]  setText:@"Unknown"];
    }
    　　return cell;//返回cell
}

@end