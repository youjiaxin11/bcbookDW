//
//  MyWorkDao.m
//  BCBookDW
//
//  Created by sunzhong on 16/4/12.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "MyWorkDao.h"

@implementation MyWorkDao

+(NSArray *)getAllMyWork{
    
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"MY_WORK"];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array!=nil) {
        NSLog(@"查看作品");
        MyWork *work = [[MyWork alloc]init];
        for ( int i =0; i<array.count; i++) {
            NSLog(@"我的第%d个作品：%@",i,work);
            NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        }
        return array;
    }else{
        return @[];
    }
}

+(void)addMyWork:(MyWork *)myWork{
    // 获得Key对应的对象数组
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"MY_WORK"];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array!=nil) {
        NSMutableArray * muArr = [[NSMutableArray alloc] initWithArray:array];
        
        // 添加新的对象
        [muArr addObject:myWork];
        
        //  数据归档
        NSData *myWorkData = [NSKeyedArchiver archivedDataWithRootObject:muArr];
        
        // 更新Key对应的对象的数据
        [[NSUserDefaults standardUserDefaults] setObject:myWorkData forKey:@"MY_WORK"];
        
        // 同步存储到磁盘
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSMutableArray * muArr = [[NSMutableArray alloc] init];
        
        // 添加新的对象
        [muArr addObject:myWork];
        
        //  数据归档
        NSData *myWorkData = [NSKeyedArchiver archivedDataWithRootObject:muArr];
        
        // 更新Key对应的对象的数据
        [[NSUserDefaults standardUserDefaults] setObject:myWorkData forKey:@"MY_WORK"];
        
        // 同步存储到磁盘
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

+(void)addMyWork:(int)workId andUserId:(int)userId andTaskTitle:(NSString *)taskTitle andUploadTime:(NSString *)uploadTime andType:(int)type andFilePath:(NSString *)filePath{
    
    // 获得Key对应的对象数组
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"MY_WORK"];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array!=nil) {
        NSLog(@"++++数据不为空！");
        
        MyWork *work = [[MyWork alloc]init];
        for ( int i =0; i<array.count; i++) {
            NSLog(@"我的第%d个作品：%@",i,work);
            NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        }

        NSMutableArray * muArr = [[NSMutableArray alloc] initWithArray:array];
        //MyWork *work = [[MyWork alloc]init];
        
        work.workId = workId;
        work.userId = userId;
        work.taskTitle = taskTitle;
        work.uploadTime = uploadTime;
        work.type = type;
        work.filePath = filePath;
        
        NSLog(@"----即将添加的作品");
        NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        
        // 添加新的对象
        [muArr addObject:work];
        
        //  数据归档
        NSData *myWorkData = [NSKeyedArchiver archivedDataWithRootObject:muArr];
        
        // 更新Key对应的对象的数据
        [[NSUserDefaults standardUserDefaults] setObject:myWorkData forKey:@"MY_WORK"];
        
        // 同步存储到磁盘
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSLog(@"++++数据为空！");
        
        NSMutableArray * muArr = [[NSMutableArray alloc] init];
        MyWork *work = [[MyWork alloc]init];
        
        work.workId = workId;
        work.userId = userId;
        work.taskTitle = taskTitle;
        work.uploadTime = uploadTime;
        work.type = type;
        work.filePath = filePath;
        
        NSLog(@"----即将添加的作品");
        NSLog(@"作品信息：1:%d－－－2:%d－－－3:%@－－－4:%@－－－5:%d－－－6:%@",work.workId,work.userId,work.uploadTime,work.taskTitle,work.type,work.filePath);
        
        // 添加新的对象
        [muArr addObject:work];
        
        //  数据归档
        NSData *myWorkData = [NSKeyedArchiver archivedDataWithRootObject:muArr];
        
        // 更新Key对应的对象的数据
        [[NSUserDefaults standardUserDefaults] setObject:myWorkData forKey:@"MY_WORK"];
        
        // 同步存储到磁盘
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)removeWrongQustion:(int)workId andUserId:(int)userId{
    NSData *data =  [[NSUserDefaults standardUserDefaults] objectForKey:@"MY_WORK"];
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * muArr = [NSMutableArray arrayWithArray:array];
    
    MyWork *work = [[MyWork alloc]init];
    // 从后往前便利来删除元素
    for (int i=(int)muArr.count-1; i>=0; i--) {
        work = muArr[i];
        if (work.workId == workId && work.userId == userId) {
            // 删除找到的对象
            [muArr removeObjectAtIndex:i];
        }
    }
    
    // 更新Key对应的对象的数据
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:@"MY_WORK"];
    
    // 同步存储到磁盘
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
