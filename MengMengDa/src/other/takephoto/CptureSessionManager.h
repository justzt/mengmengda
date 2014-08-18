//
//  CptureSessionManager.h
//  AVCaptureSession相机
//
//  Created by zt on 14-4-1.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MotionOrientation.h"

#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"

@interface CptureSessionManager : NSObject

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureStillImageOutput *outputDevice;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *preview;

- (void)embedPreviewInView:(UIView *)aView;
- (void)captureStillImageSuccessBlock:(void(^)(UIImage*img))successBlock;
- (void)stopRunning;
@end
