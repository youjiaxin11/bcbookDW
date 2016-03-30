//
//  XYZPhoto.h
//  BCBookDW
//
//  Created by sunzhong on 16/3/30.
//  Copyright © 2016年 cnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZDrawView.h"

typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};

@interface XYZPhoto : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) XYZDrawView *drawView;
@property (nonatomic) float speed;
@property (nonatomic) CGRect oldFrame;
@property (nonatomic) float oldSpeed;
@property (nonatomic) float oldAlpha;
@property (nonatomic) int state;
@property (nonatomic) int photoId;

- (void)updateImage:(UIImage *)image;
- (void)setImageAlphaAndSpeedAndSize:(float)alpha;
@end
