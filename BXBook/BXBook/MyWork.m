//
//  Work.m
//  BXBook
//
//  Created by sunzhong on 15/8/19.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "MyWork.h"

@implementation MyWork

@synthesize workId,userId,taskTitle,uploadTime,type,filePath;

#pragma mark NSCoding
- (id)initWithCoder:(NSCoder *)coder{
    
    if (self == [super init]) {
        workId = [coder decodeIntForKey:@"MyWork_workId"];
        userId = [coder decodeIntForKey:@"MyWork_userId"];
        taskTitle = [coder decodeObjectForKey:@"MyWork_taskTitle"];
        uploadTime = [coder decodeObjectForKey:@"MyWork_uploadTime"];
        type = [coder decodeIntForKey:@"MyWork_type"];
        filePath = [coder decodeObjectForKey:@"MyWork_filePath"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
     
    [coder encodeInt:workId forKey:@"MyWork_workId"];
    [coder encodeInt:userId forKey:@"MyWork_userId"];
    [coder encodeObject:taskTitle  forKey:@"MyWork_taskTitle"];
    [coder encodeObject:uploadTime forKey:@"MyWork_uploadTime"];
    [coder encodeInt:type forKey:@"MyWork_type"];
    [coder encodeObject:filePath forKey:@"MyWork_filePath"];
    
}
@end
