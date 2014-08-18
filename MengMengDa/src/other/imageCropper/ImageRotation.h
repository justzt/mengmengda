//
//  ImageRotation.h
//  MengMengDa
//
//  Created by zt on 14-8-5.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageRotation : NSObject
// 旋转照片
+ (UIImage*) rotateImage:(UIImage*) src  orientation:(UIImageOrientation) orientation;
@end
