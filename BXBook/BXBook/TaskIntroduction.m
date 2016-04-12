//
//  TaskIntroduction.m
//  BXBook
//
//  Created by Jack on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "TaskIntroduction.h"
#import "NotebookController.h"

@implementation TaskIntroduction

User* userTaskIntroduction;
Task* taskTaskIntroduction;

- (void)viewDidLoad {
    [super viewDidLoad];
    userTaskIntroduction = self.user;
    taskTaskIntroduction = [TaskDao findTaskByTaskId:_taskChoiceId];
//    [_taskMessageText setText:taskTaskIntroduction.taskMessage];
    NSString *three = taskTaskIntroduction.evaluation1;
    NSString *four = taskTaskIntroduction.evaluation2;
    NSString *five = taskTaskIntroduction.evaluation3;
    NSString *str1 = [three stringByAppendingString:[NSString stringWithFormat:@"\n%@", four]];
    NSString *str2 = [str1 stringByAppendingString:[NSString stringWithFormat:@"\n%@", five]];
//    [_evaluateText setText:str2];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:24],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _evaluateText.attributedText = [[NSAttributedString alloc] initWithString:str2 attributes:attributes];
    _taskMessageText.attributedText = [[NSAttributedString alloc] initWithString:taskTaskIntroduction.taskMessage attributes:attributes];
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userTaskIntroduction.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = [[NSString alloc ]initWithFormat:@"TaskIntroduction-(void)viewDidLoad-任务id:%d", _taskChoiceId];
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
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
    behaviour.userId = userTaskIntroduction.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"TaskIntroduction-(void)menuButtonClicked:(int)index";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (index == 0) {
        UploadPhoto *uploadphoto = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadPhoto"];
        uploadphoto.user = userTaskIntroduction;
        uploadphoto.task = nil;
        [uploadphoto setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadphoto animated:YES completion:nil];
    }else if (index == 1){
        UploadVideo *uploadvideo = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadVideo"];
        uploadvideo.user = userTaskIntroduction;
        uploadvideo.task = nil;
        [uploadvideo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadvideo animated:YES completion:nil];
    }else if (index == 2){
        UploadAudio *uploadaudio = [mainStoryboard instantiateViewControllerWithIdentifier:@"UploadAudio"];
        uploadaudio.user = userTaskIntroduction;
        uploadaudio.task = nil;
        [uploadaudio setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:uploadaudio animated:YES completion:nil];
    }else if (index == 3){
        
        NotebookController *notebookController = [mainStoryboard instantiateViewControllerWithIdentifier:@"NotebookController"];
        
        notebookController.user = userTaskIntroduction;
        
        notebookController.task = nil;
        
        [notebookController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        [self presentViewController:notebookController animated:YES completion:nil];
        
    }
}
- (IBAction)goToTaskInfo:(id)sender {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TaskInfo *taskinfo = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
//    taskinfo.user = userTaskIntroduction;
//    taskinfo.taskChoiceId = _taskChoiceId;
//    [taskinfo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//    [self presentViewController:taskinfo animated:YES completion:nil];
    Activity *taskinfo = [mainStoryboard instantiateViewControllerWithIdentifier:@"Activity"];
    taskinfo.user = userTaskIntroduction;
    taskinfo.task = taskTaskIntroduction;
    [taskinfo setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:taskinfo animated:YES completion:nil];

}
//左滑返回上一页
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"lefttaskinfo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)goBack:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end