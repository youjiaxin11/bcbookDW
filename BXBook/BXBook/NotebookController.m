//
//  UploadPhoto.m
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "NotebookController.h"

@implementation NotebookController
@synthesize saveNoteBtn,clearNoteBtn,noteTextView;

User* userNotebook;
Task* taskNotebook;


- (void)viewDidLoad {
    [super viewDidLoad];
    userNotebook = self.user;
    taskNotebook = self.task;
    NSLog(@"@photo : %@",userNotebook.loginName);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userNotebook.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"NotebookController-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
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
- (IBAction)saveNote:(id)sender {
}
- (IBAction)clearNote:(id)sender {
}

@end

