//
//  UIImageCrop.m
//  MengMengDa
//
//  Created by zt on 14-8-5.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "UIImageCrop.h"

@implementation UIImageCrop
// 根据index裁剪图片
+ (UIImage *)cropImageForEditViewImage:(UIImage *)image atIndex:(int)index{
    
//    CGFloat height = image.size.height*.5;
//    CGFloat originY = 0;
//    if (index == 1) {
//        originY = image.size.height*0.33;
//    }else if(index == 2){
//        originY = image.size.height*0.5;
//    }
//    CGRect rect = CGRectMake(0, originY, image.size.width, height);
//    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
//    UIImage *cropimage = [[UIImage alloc] initWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    return cropimage;
    
    
    CGFloat height = image.size.height*0.33;
    CGFloat originY = height*index;
    CGRect rect = CGRectMake(0, originY, image.size.width, height);
    return  [UIImageCrop cropImage:image withRect:rect];
}

// 将一个图片裁剪成给定的rect
+ (UIImage*)cropImage:(UIImage*)image withRect:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *cropimage = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropimage;
}

// 将原始图片变成实际可用图片
+ (UIImage*)convertOriginImageToEditImage:(UIImage*)oriImage{
    CGFloat widht = 960.0;
    CGFloat scale = oriImage.size.width/widht;
    CGFloat height = oriImage.size.height/scale;
    return [UIImageCrop scaleImage:oriImage toSize:CGSizeMake(widht, height)];
}

//等比例缩放
+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
