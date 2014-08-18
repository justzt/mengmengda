//
//  CroppingView.m
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "CroppingView.h"

@interface CroppingView(){
    __block void(^cropCompleteBlock)(UIImage*img);
    BOOL firstEidt;
    
    UIImage *originImage;
    CGRect originFrame;
    UIView *contentView;
    CGFloat imageScale;//default zoomscale
    UIImageView *originImageView;//原图view
}

@end

@implementation CroppingView

- (id)initWithFrame:(CGRect)frame image:(UIImage*)img CompleteBlock:(void (^)(UIImage *img))block{
    self = [super initWithFrame:frame];
    if (self) {
        firstEidt = NO;
        
        originImage = img;
        cropCompleteBlock = block;
        
        originImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        originImageView.image = img;
        [originImageView setContentMode:UIViewContentModeScaleAspectFit];
        originFrame = originImageView.frame;
        [self addSubview:originImageView];
        [self addUserGustrue];
    }
    return self;
}


- (void)cropImage{
    float zoomScale = originImageView.frame.size.height/originImage.size.height;
    CGFloat originX = self.frame.origin.x-originImageView.frame.origin.x;
    CGFloat originY = self.frame.origin.y-originImageView.frame.origin.y;
    CGSize cropSize = CGSizeMake(self.frame.size.width/zoomScale, self.frame.size.height/zoomScale);
    
    
    CGRect cropRect = CGRectMake(originX/zoomScale, originY/zoomScale, cropSize.width, cropSize.height);
    NSLog(@"originX:%lf originY:%lf,corpRect:%@",originX,originY,[NSValue valueWithCGRect:cropRect]);
    
    CGImageRef tmp = CGImageCreateWithImageInRect([originImage CGImage], cropRect);
    self.croppedImage = [UIImage imageWithCGImage:tmp scale:originImage.scale orientation:originImage.imageOrientation];
    NSLog(@"image size:%@",[NSValue valueWithCGSize:self.croppedImage.size]);
}

// 添加手势
- (void)addUserGustrue{
    UIPinchGestureRecognizer *scaleGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImage:)];
    [self addGestureRecognizer:scaleGes];
    
    
    UIPanGestureRecognizer *moveGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    [moveGes setMinimumNumberOfTouches:1];
    [moveGes setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:moveGes];
}

// 处理缩放
float _lastScale = 1.0;
- (void)scaleImage:(UIPinchGestureRecognizer *)sender{
    if([sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
        return;
    }
    
    if (firstEidt == NO) {
        [self.delegate croppingView:self replacheOriginImage:originImage];
        firstEidt = YES;
    }
    
    CGFloat scale = [sender scale]/_lastScale;
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        // 超出可以移动范围
        [self stopChangeOriginImageView];
    }
    
    CGAffineTransform currentTransform = originImageView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [originImageView setTransform:newTransform];
    
    
    _lastScale = [sender scale];
}

// 处理移动
float _lastTransX = 0.0, _lastTransY = 0.0;
- (void)moveImage:(UIPanGestureRecognizer *)sender{
    CGPoint translatedPoint = [sender translationInView:contentView];
    
    if([sender state] == UIGestureRecognizerStateBegan) {
        _lastTransX = 0.0;
        _lastTransY = 0.0;
    }
    
    if (firstEidt == NO) {
        [self.delegate croppingView:self replacheOriginImage:originImage];
        firstEidt = YES;
    }
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        // 超出可以移动范围
        [self stopChangeOriginImageView];
    }
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translatedPoint.x - _lastTransX, translatedPoint.y - _lastTransY);
    CGAffineTransform newTransform = CGAffineTransformConcat(originImageView.transform, trans);
    _lastTransX = translatedPoint.x;
    _lastTransY = translatedPoint.y;
    
    originImageView.transform = newTransform;
}

// 检查图片移动是否超过范围，
- (BOOL)stopChangeOriginImageView{
    if(!CGRectContainsRect(originImageView.frame, originImageView.bounds)){
        [self resetOriginImageViewStatus];
        return YES;
    }
    return NO;
    
    CGFloat left = CGRectGetWidth(self.bounds)*0.2;
    CGFloat right = CGRectGetWidth(self.frame)*0.8;
    CGFloat top = CGRectGetHeight(self.bounds)*0.3;
    CGFloat bottom = CGRectGetHeight(self.bounds)*0.7;

    if( CGRectGetMaxX(originImageView.frame) < right ||
       CGRectGetMinX(originImageView.frame) > left ||
       CGRectGetMinY(originImageView.frame) > top ||
       CGRectGetMaxY(originImageView.frame) < bottom){
        [self resetOriginImageViewStatus];
        return YES;
    }
    return NO;
}

// 还原图片
- (void)resetOriginImageViewStatus{
    originImageView.transform = CGAffineTransformIdentity;
    originImageView.frame = originFrame;
}

- (void)changeEditImage:(UIImage*)img{
    originImageView.image = img;
//    [self resetOriginImageViewStatus];
}
@end
