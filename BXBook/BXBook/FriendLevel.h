//
//  FriendLevel.h
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface FriendLevel : BaseControl

@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UITableView *friendTableView;


@end