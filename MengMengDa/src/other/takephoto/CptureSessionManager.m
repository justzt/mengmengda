//
//  CptureSessionManager.m
//  AVCaptureSession相机
//
//  Created by zt on 14-4-1.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "CptureSessionManager.h"

@implementation CptureSessionManager

- (id)init{
    self = [super init];
    if (self) {
        self.session = [[AVCaptureSession alloc] init];
        [self configSession];
        [self.session startRunning];
    }
    return self;
}

// 配置
- (void)configSession{
    // 1.图片的大小
    self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    // 2.输入设备
    NSError *error = nil;
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *d in devices) {
        if ([d hasMediaType:AVMediaTypeVideo]) {
            if ([d position] == AVCaptureDevicePositionBack){
                backCamera = d;
                break;
            }
        }
    }
    AVCaptureDeviceInput *inputDevice = [[AVCaptureDeviceInput alloc] initWithDevice:backCamera error:&error];
    if (error) {
        NSLog(@"AVCaptureDeviceInput:%@",error);
    }
    [self.session addInput:inputDevice];
    
    // 3.输出设备
    self.outputDevice = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    self.outputDevice.outputSettings = outputSettings;
    [self.session addOutput:self.outputDevice];
}


// 插入预览视图到视图中
- (void)embedPreviewInView: (UIView *) aView {
    if (!self.session){
        return;
    }
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    self.preview.frame = aView.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [aView.layer addSublayer: self.preview];
}

// 拍照
- (void)captureStillImageSuccessBlock:(void(^)(UIImage*img))successBlock{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in self.outputDevice.connections) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	NSLog(@"about to request a capture from: %@", self.outputDevice);
	[self.outputDevice captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                             UIImage *image = [[UIImage alloc] initWithData:imageData];
                                                             successBlock(image);
                                                         }];
}

// 停止
- (void)stopRunning{
    [self.session stopRunning];
}
@end
