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
NSString* taskTitle_note;

- (void)viewDidLoad {
    [super viewDidLoad];
    userNotebook = self.user;
    taskNotebook = self.task;
    NSLog(@"@photo : %@",userNotebook.loginName);
    
    if (taskNotebook == nil) {
        taskTitle_note = @"笔记";
    }else{
        taskTitle_note = taskNotebook.taskTitle;
    }
     NSLog(@"tasktitle:%@",taskTitle_note);
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userNotebook.userId;
    behaviour.doWhat = @"浏览";
    behaviour.doWhere = @"NotebookController-(void)viewDidLoad";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:24],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };

    //首先展示笔记
    Note* note = [[Note alloc]init];
    note = [NoteDao getNoteFromUserId:userNotebook.userId];
    if (note == nil) {
        //noteTextView.text = @"sss";
    }else{
      //  noteTextView.text = note.note;
        noteTextView.attributedText = [[NSAttributedString alloc] initWithString:note.note attributes:attributes];
        
    }
    
    
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
    
    //记录行为数据
    NSString* timeNow = [TimeUtil getTimeNow];
    Behaviour *behaviour = [[Behaviour alloc]init];
    behaviour.userId = userNotebook.userId;
    behaviour.doWhat = @"笔记－本地";
    behaviour.doWhere = @"NotebookController-(IBAction)saveNote:(id)sender";
    behaviour.doWhen = timeNow;
    [BehaviourDao addBehaviour:behaviour];
    
        NSLog(@"note : %@",noteTextView.text);
       // NSString* timeNow = [TimeUtil getTimeNow];
        Note* note = [NoteDao getNoteFromUserId:userNotebook.userId];
        if (note == nil) {//如果是新笔记，添加
            Note* noteNew = [[Note alloc]init];
            noteNew.userId = userNotebook.userId;
            noteNew.note = noteTextView.text;
            noteNew.updateTime = timeNow;
            [NoteDao addNote:noteNew];
        }else{//如果是旧笔记，更新
            note.note = noteTextView.text;
            note.updateTime = timeNow;
            [NoteDao updateNote:note];
        }
    
}
- (IBAction)clearNote:(id)sender {
    noteTextView.text = nil;
}

@end

