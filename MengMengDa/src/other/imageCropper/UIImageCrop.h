//
//  UIImageCrop.h
//  MengMengDa
//
//  Created by zt on 14-8-5.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageCrop : NSObject
// 根据index裁剪图片
+ (UIImage *)cropImageForEditViewImage:(UIImage *)image atIndex:(int)index;
// 将一个图片裁剪成给定的rect
+ (UIImage*)cropImage:(UIImage*)image withRect:(CGRect)rect;
// 将原始图片变成实际可用图片
+ (UIImage*)convertOriginImageToEditImage:(UIImage*)oriImage;
//等比例缩放
+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)size;
//等比例缩放
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;
@end
