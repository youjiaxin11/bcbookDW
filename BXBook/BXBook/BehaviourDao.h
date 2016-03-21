//
//  BehaviourDao.h
//  BCBookDW
//
//  Created by sunzhong on 16/3/21.
//  Copyright © 2016年 cnu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "SqliteUtil.h"
#import "Behaviour.h"
#import "DataUtil.h"

@interface BehaviourDao : NSObject

//添加behaviour
+ (int) addBehaviour:(Behaviour*)behaviour;

@end
