//
//  Zongzi.h
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import "BaseControl.h"
#import "Makezongzi.h"
@interface Zongzi: BaseControl
@property (assign, nonatomic) User *user;//当前登录用户
@property (strong, nonatomic) IBOutlet UIWebView *ZongziGif;


@end