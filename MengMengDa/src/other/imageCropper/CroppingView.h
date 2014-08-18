//
//  CroppingView.h
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CroppingViewDelegate <NSObject>


- (void)croppingView:(UIView*)view replacheOriginImage:(UIImage*)image;

@end

@interface CroppingView : UIView
@property (nonatomic,retain) UIImage *croppedImage;
@property (nonatomic,weak)  id<CroppingViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame image:(UIImage*)iamge CompleteBlock:(void (^)(UIImage *img))block;

- (void)changeEditImage:(UIImage*)img;
@end
