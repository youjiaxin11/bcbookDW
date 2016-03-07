//
//  DataUtil.m
//  BXBook
//
//  Created by sunzhong on 15/9/1.
//  Copyright (c) 2015年 cnu. All rights reserved.
//


#import "DataUtil.h"

@implementation DataUtil

+(NSString*) floatToPercent:(float)num{
    CFLocaleRef currentLocale = CFLocaleCopyCurrent();
    CFNumberFormatterRef numberFormatter = CFNumberFormatterCreate(NULL, currentLocale, kCFNumberFormatterPercentStyle);
    CFNumberRef number = CFNumberCreate(NULL, kCFNumberFloatType, &num);
    CFStringRef numberString = CFNumberFormatterCreateStringWithNumber(NULL, numberFormatter, number);
    NSString *aNSString = (__bridge NSString*)numberString;
    NSLog(@"%@",numberString);
    return aNSString;
}

@end