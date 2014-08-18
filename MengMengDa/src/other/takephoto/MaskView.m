//
//  MaskView.m
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MaskView.h"

@interface MaskView(){
    UIImageView *previewIamge;
    UIButton *cancelButton;
    UIButton *takeButton;
    UIButton *confirmButtom;
}

@end

@implementation MaskView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // init previewIamge
        previewIamge = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:previewIamge];
        
        [self showActionView];
        [self setMaskViewPreviewModel:NO];
    }
    return self;
}

- (void)showActionView{
    CGFloat height= 80;
    CGFloat originY = CGRectGetHeight(self.bounds) - height;
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(0, originY, 320, height)];
    actionView.backgroundColor = [UIColor clearColor];
    
    // 取消按钮
    cancelButton = [self addActionButtonWithIndex:0];
    [actionView addSubview:cancelButton];
    
    // 拍照按钮
    takeButton = [self addActionButtonWithIndex:1];
    [actionView addSubview:takeButton];
    
    // 确定按钮
    confirmButtom = [self addActionButtonWithIndex:2];
    [actionView addSubview:confirmButtom];
    
    [self addSubview:actionView];
}

// 根据当前模式设置按钮的可用状态
- (void)setMaskViewPreviewModel:(BOOL)preview{
    cancelButton.hidden = !preview;
    confirmButtom.hidden = !preview;
    takeButton.hidden = preview;
    
    if (preview == NO) {
        [self showPreviewImage:nil];
    }
}

- (UIButton*)addActionButtonWithIndex:(int)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    CGFloat width = 57;
    button.frame = CGRectMake(37*(index+1)+index*width, (80-width)/2, width, width);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    viewroundCorner(button, kMaicheMainColor, 1, width/2);
    NSString *title = @"拍照";
    switch (index) {
        case 0:
            title = @"X";
            break;
        case 2:
            title = @"√";
            break;
        default:
            break;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = kMaicheMainColor;
    return button;
}

- (void)buttonAction:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(maskView:actionButtonClickedAtIndex:)]) {
        [self.delegate maskView:self actionButtonClickedAtIndex:(int)button.tag];
    }
}

- (void)showPreviewImage:(UIImage*)image{
    previewIamge.image = image;
}
@end
