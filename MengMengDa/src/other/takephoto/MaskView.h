//
//  MaskView.h
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MaskViewDelegate <NSObject>

@required
- (void)maskView:(UIView*)view actionButtonClickedAtIndex:(int)index;

@end

@interface MaskView : UIView
@property (weak,nonatomic) id<MaskViewDelegate> delegate;

- (void)showPreviewImage:(UIImage*)image;
- (void)setMaskViewPreviewModel:(BOOL)preview;
@end
