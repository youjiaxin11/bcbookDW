//
//  WorksCell.m
//  BXBook
//
//  Created by sunzhong on 15/8/20.
//  Copyright (c) 2015年 cnu. All rights reserved.
//

#import "WorksCell.h"

@implementation WorksCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageview];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imageview.frame=CGRectInset(self.bounds, 0, 2);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end
