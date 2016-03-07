//
//  MyWorks.h
//  BXBook
//
//  Created by sunzhong on 15/8/12.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "BaseControl.h"

@interface MyWorks : BaseControl{
    NSMutableArray *itms;
}

@property (assign, nonatomic) User *user;//当前登录用户
@property (assign, nonatomic) int taskId;//任务id
@property (assign, nonatomic) int pageType;//页面类型，0:某任务下我的作品，1:我的全部作品
@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;
@end
