//
//  EditVC.m
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "EditVC.h"
#import "CroppingView.h"
#import "UIViewToImage.h"
#import "UIImageCrop.h"
#import "UIAlertView+Blocks.h"

@interface EditVC ()<CroppingViewDelegate>{
    UIImage *originImage;
    UIImage *resultImage;
    UIImageView *resultImageView;
    
    UIView *editView;//编辑区域
    
    UIButton *saveButton;//
}

@end

@implementation EditVC


- (id)initImage:(UIImage*)image{
    self = [super init];
    if (self) {
        originImage = image;
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNavbarButtons];
    [self originImageFitEdit];
    [self showEditViews];
}

// 检查原图是否符合要求
- (BOOL)originImageFitEdit{
    CGFloat widht = 960;
    CGFloat height = 1280.00;
    // 1 原图必须是竖屏的
    if (originImage.size.width > originImage.size.height) {
        [UIAlertView showWithTitle:@"图片必须是竖屏拍摄的哦"
                           message:nil
                 cancelButtonTitle:@"知道了" otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              [self.navigationController popViewControllerAnimated:YES];
        }];
        return NO;
    }
    
    // 2 图片尺寸必须大于640*960
    if (originImage.size.width<widht || originImage.size.height<height) {
        [UIAlertView showWithTitle:@"图片太小不够清晰"
                           message:nil
                 cancelButtonTitle:@"知道了" otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              [self.navigationController popViewControllerAnimated:YES];
                          }];
        return NO;
    }
    
    [self originImageScaleToFit];
    
    // 3 将照片裁剪成2:3的比例
    CGPoint center = CGPointMake(originImage.size.width/2, originImage.size.height/2);
    CGFloat originX = center.x - widht/2;
    CGFloat originY = center.y - height/2;
    CGRect rect = CGRectMake(originX, originY, widht, height);
    originImage = [UIImageCrop cropImage:originImage withRect:rect];
    
//    [self writeIamgeToAlbum:originImage];
    return YES;
}

// 将原图缩放到适合3：2的最佳大小，不是真的3：2，比这个所产生的图片大一些
- (void)originImageScaleToFit{
    CGFloat widht = 960.00/2*1.125;
    CGFloat scale =  originImage.size.width/widht;
    CGSize size = CGSizeMake(originImage.size.width/scale, originImage.size.height/scale);
    originImage = [UIImageCrop resizeImage:originImage newSize:size];
//    [self writeIamgeToAlbum:originImage];
}

// 顶部按钮
- (void)setNavbarButtons{
    // 保存按钮
    saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat _oriY = (44-30)/2 + self.navBar.originY;
    saveButton.frame = CGRectMake((320-45)/2, _oriY, 45, 30);
    [saveButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.navBar addSubview:saveButton];
    
    // 分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _oriY = (44-30)/2 + self.navBar.originY;
    [shareButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    shareButton.frame = CGRectMake(320-45-10, _oriY, 45, 30);
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.navBar addSubview:shareButton];
}

// 结果展示
- (void)showResultImage{
    resultImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    resultImageView.image = resultImage;
    [self.view addSubview:resultImageView];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(30, CGRectGetHeight(self.view.frame)-50-20, 50, 50);
    [closeButton addTarget:self action:@selector(closeResultView:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    closeButton.backgroundColor = ColorWithRGB(255, 204, 92);
    [self.view addSubview:closeButton];
}

// 一个editview,宽度195 高度95
- (void)addEditViewWithIndex:(int)index{
    CGFloat height = 130;
    CGFloat width = 260;
    CGFloat leftSpace = 30;
    CGFloat topSpace = 5;
    CGFloat originY = topSpace*(index+1) + height*index + (iphone5 ? 30 : 3);
    CGRect frame = CGRectMake(leftSpace, originY, width, height);

    UIImage *img = [UIImageCrop cropImageForEditViewImage:originImage atIndex:index];
    CroppingView *cropView = [[CroppingView alloc] initWithFrame:frame image:img CompleteBlock:^(UIImage *img) {
        
    }];
    cropView.delegate = self;
    cropView.tag = index;
    cropView.clipsToBounds = YES;
    
    
    [editView addSubview:cropView];
}

// 显示3个可编辑区域
- (void)showEditViews{
    CGFloat height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navBar.frame);
    CGRect rect = CGRectMake(0, CGRectGetHeight(self.navBar.frame), CGRectGetWidth(self.view.frame), height);
    editView = [[UIView alloc] initWithFrame:rect];
    editView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:editView];
    
    for (int i=0; i<3; i++) {
        [self addEditViewWithIndex:i];
    }
}

// 保存结果
- (void) saveButtonAction:(UIButton*)button{
    button.enabled = NO;
    
    [SCHudManager showHUD];
    resultImage = [UIViewToImage imageForView:editView];
    [self showResultImage];
    [self writeIamgeToAlbum:resultImage];
}

// 分享按钮
- (void)shareButtonAction:(UIButton*)button{
    
}

// 保存图片到相册
- (void)writeIamgeToAlbum:(UIImage *)img{
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:) ,nil);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (error != nil) {
        NSLog(@"save error:%@",error);
        [SCHudManager showHudWithImage:kHudErrorImage title:FormatStr(@"%@", error)];
    }else{
        [SCHudManager showHudWithImage:kHudOKImage title:@"已保存"];
    }
}

// 关闭预览
- (void)closeResultView:(UIButton*)button{
    saveButton.enabled = YES;
    
    [button removeFromSuperview];
    [resultImageView removeFromSuperview];
}

#pragma mark - CroppingViewDelegate
- (void)croppingView:(UIView *)view replacheOriginImage:(UIImage *)image{
//    int index = view.tag;
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
    
//    image = originImage;
    [(CroppingView*)view changeEditImage:originImage];

    // 3 将照片裁剪成2:3的比例
//    CGFloat widht = 960;
//    CGFloat height = 1440;
//    CGPoint center = CGPointMake(self.bigOriginImage.size.width/2, self.bigOriginImage.size.height/2);
//    CGFloat originX = center.x - widht/2;
//    CGFloat originY = center.y - height/2;
//    CGRect rect = CGRectMake(originX, originY, widht, height);
//    
//    resultImage = [UIImageCrop cropImage:self.bigOriginImage withRect:rect];
//    resultImage = self.bigOriginImage;
//    [self showResultImage];
//    [self writeIamgeToAlbum:self.bigOriginImage];
}
@end
