//
//  UploadPhoto.h
//  BXBook
//
//  Created by sunzhong on 15/7/23.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface UploadPhoto : BaseControl{
    UITextView *contenttextview;
    UIImageView *contentimageview;
    NSString *lastChosenMediaType;
    
}

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) Task *task;//当前任务卡
@property (strong, nonatomic) IBOutlet UIButton *addPhotoBtn;
@property(nonatomic,retain) IBOutlet UITextView *contenttextview;
@property(nonatomic,retain)  IBOutlet   UIImageView *contentimageview;
@property(nonatomic,copy)        NSString *lastChosenMediaType;

@end