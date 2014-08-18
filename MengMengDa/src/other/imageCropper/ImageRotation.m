//
//  ImageRotation.m
//  MengMengDa
//
//  Created by zt on 14-8-5.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "ImageRotation.h"

@implementation ImageRotation
// 旋转照片
static inline double radians (double degrees) {return degrees * M_PI/180;}
+ (UIImage*) rotateImage:(UIImage*) src  orientation:(UIImageOrientation) orientation{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
