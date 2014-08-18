//
//  UIViewToImage.m
//  MengMengDa
//
//  Created by zt on 14-8-5.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "UIViewToImage.h"

@implementation UIViewToImage

+(UIImage*)imageForView:(UIView*)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}
@end
