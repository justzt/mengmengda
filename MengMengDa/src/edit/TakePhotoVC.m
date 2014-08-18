//
//  TakePhotoVC.m
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "TakePhotoVC.h"
#import "CptureSessionManager.h"
#import "MaskView.h"
#import "EditVC.h"
#import "ImageRotation.h"

@interface TakePhotoVC ()<MaskViewDelegate>{
    UIDeviceOrientation deviceOrientation;
    CptureSessionManager *sessionManager;
    MaskView *maskView;
}

@end

@implementation TakePhotoVC

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    deviceOrientation = [MotionOrientation sharedInstance].deviceOrientation;
    
    // session init
    sessionManager = [[CptureSessionManager alloc] init];
    [sessionManager embedPreviewInView:self.view];
    
    // 操作view
    maskView = [[MaskView alloc] initWithFrame:self.view.bounds];
    maskView.delegate = self;
    [self.view addSubview:maskView];
}


// 拍照
- (void)takePhoto{
    deviceOrientation = [MotionOrientation sharedInstance].deviceOrientation;
    //UIDeviceOrientationLandscapeLeft, UIDeviceOrientationLandscapeRight,
    // 除了最后一张行驶本，其他5张都需要横屏
    if (deviceOrientation != UIDeviceOrientationPortrait) {
        DLogF(@"请使用竖屏拍摄");
        return;
    }
    
    // 捕获图片
    [sessionManager captureStillImageSuccessBlock:^(UIImage *image) {
        self.resutlImage = [ImageRotation rotateImage:image orientation:UIImageOrientationDown];
        DLogF(@"image size:%@",[NSValue valueWithCGSize:self.resutlImage.size]);
        [maskView showPreviewImage:self.resutlImage];
    }];
}

- (void)writeIamgeToAlbum:(UIImage *)img{
    //@selector(image:didFinishSavingWithError:contextInfo:)
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:) ,nil);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (error != nil) {
        NSLog(@"save error:%@",error);
    }
}

#pragma mark - MaskViewDelegate
- (void)maskView:(UIView *)view actionButtonClickedAtIndex:(int)index{
    switch (index) {
        case 0:{
            // 取消
            [maskView setMaskViewPreviewModel:NO];
        }
            break;
        case 1:{
            // 拍照
            [self takePhoto];
            [maskView setMaskViewPreviewModel:YES];
        }
            break;
        case 2:{
            // 确认
            EditVC *vc = [[EditVC alloc] initImage:self.resutlImage];
            [self.navigationController pushViewController:vc animated:YES];
            
            [maskView setMaskViewPreviewModel:NO];
        }
            break;
        default:
            break;
    }
}
@end
