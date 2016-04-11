//
//  UploadPhoto.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface NotebookController : BaseControl{
    
}

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Task *task;//当前任务卡
@property (strong, nonatomic) IBOutlet UIButton *saveNoteBtn;
@property (strong, nonatomic) IBOutlet UIButton *clearNoteBtn;

@property (strong, nonatomic) IBOutlet UITextView *noteTextView;


@end