//
//  MainVC.m
//  MengMengDa
//
//  Created by zt on 14-8-4.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MainVC.h"
#import "TakePhotoVC.h"

#import "TSAssetsPickerController.h"
#import "DummyAssetsImporter.h"
#import "DummyAlbumCell.h"
#import "DummyNoAlbumsCell.h"
#import "DummyAlbumsTableView.h"
#import "DummyAssetCell.h"
#import "DummyAssetsCollectionView.h"
#import "AssetsCollectionViewLayout.h"
#import "DeviceTypesMacros.h"

#import "EditVC.h"
#import "ImageRotation.h"
#import "UIImageCrop.h"
#import "ImageRotation.h"

@interface MainVC ()<TSAssetsPickerControllerDelegate, TSAssetsPickerControllerDataSource>{
    TSAssetsPickerController *_picker;
    UIImageView *testImgView;
}

@end

@implementation MainVC

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.navBar.backButton.hidden = YES;
    [self showButtons];
    
    /*
    testImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 66, 320, 330)];
    [self.view addSubview:testImgView];
    UIImage *originImage = [ImageRotation rotateImage:[UIImage imageNamed:@"test.jpg"] orientation:UIImageOrientationDown];
    
    // 3 将照片裁剪成2:3的比例
    originImage = [UIImageCrop convertOriginImageToEditImage:originImage];
    
    testImgView.image = originImage;
    [self writeIamgeToAlbum:originImage];
     */
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

- (void)showButtons{
    // 选择照片按钮
    UIButton *chooseImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseImageButton.tag = 100;
    chooseImageButton.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-50, 160, 50);
    [chooseImageButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    chooseImageButton.backgroundColor = ColorWithRGB(255, 204, 92);
    [chooseImageButton setTitle:@"相册" forState:UIControlStateNormal];
    [self.view addSubview:chooseImageButton];
    
    // 拍照按钮
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoButton.tag = 101;
    takePhotoButton.backgroundColor = ColorWithRGB(255, 204, 92);
    takePhotoButton.frame = CGRectMake(161, CGRectGetMinY(chooseImageButton.frame), 159, 50);
    [takePhotoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoButton setTitle:@"拍照" forState:UIControlStateNormal];
    [self.view addSubview:takePhotoButton];
}

- (void)buttonAction:(UIButton*)button{
    //选择照片
    if (button.tag == 100) {
        if (!_picker) {
            _picker = [TSAssetsPickerController new];
            _picker.delegate = self;
            _picker.dataSource = self;
        }
        [self presentViewController:_picker animated:YES completion:nil];
    }
    // 拍照
    else{
        TakePhotoVC *takeVC = [[TakePhotoVC alloc] init];
        [self.navigationController pushViewController:takeVC animated:YES];
    }
}



#pragma mark - TSAssetsPickerControllerDataSource
- (NSUInteger)numberOfItemsToSelectInAssetsPickerController:(TSAssetsPickerController *)picker {
    return 1;
}

- (TSFilter *)filterOfAssetsPickerController:(TSAssetsPickerController *)picker {
    return [TSFilter filterWithType:FilterTypeAll];
}

/*
 - (UIActivityIndicatorView *)assetsPickerController:(TSAssetsPickerController *)picker activityIndicatorViewForPlace:(ViewPlace)place {
 UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
 [indicatorView setColor:[UIColor redColor]];
 [indicatorView setHidesWhenStopped:YES];
 return indicatorView;
 }
 
 - (UICollectionViewLayout *)assetsPickerController:(TSAssetsPickerController *)picker needsLayoutForOrientation:(UIInterfaceOrientation)orientation {
 AssetsCollectionViewLayout *layout = [AssetsCollectionViewLayout new];
 if (UIInterfaceOrientationIsPortrait(orientation)) {
 if (IS_IPHONE) {
 [layout setItemSize:CGSizeMake(47, 47)];
 [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
 [layout setInternItemSpacingY:4.0f];
 [layout setNumberOfColumns:6];
 } else {
 [layout setItemSize:CGSizeMake(115, 115)];
 [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
 [layout setInternItemSpacingY:10.0f];
 [layout setNumberOfColumns:6];
 }
 } else {
 if (IS_IPHONE) {
 CGSize itemSize = CGSizeMake(48, 48);
 if (IS_IPHONE_5) {
 itemSize = CGSizeMake(45, 45);
 }
 [layout setItemSize:itemSize];
 [layout setItemInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
 [layout setInternItemSpacingY:4.0f];
 
 NSUInteger columns = IS_IPHONE_5 ? 11 : 9;
 [layout setNumberOfColumns:columns];
 } else {
 [layout setItemSize:CGSizeMake(115, 115)];
 [layout setItemInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)];
 [layout setInternItemSpacingY:10.0f];
 [layout setNumberOfColumns:8];
 }
 }
 
 return layout;
 }
 
 - (NSString *)assetsPickerControllerTitleForAlbumsView:(TSAssetsPickerController *)picker {
 return @"Albums1";
 }
 
 - (NSString *)assetsPickerControllerTitleForCancelButtonInAlbumsView:(TSAssetsPickerController *)picker {
 return @"Cancel1";
 }
 
 - (NSString *)assetsPickerControllerTitleForSelectButtonInAssetsView:(TSAssetsPickerController *)picker {
 return @"Select1";
 }
 
 - (NSString *)assetsPickerControllerTextForCellWhenNoAlbumsAvailable:(TSAssetsPickerController *)picker {
 return @"Can't find any asset. Create some and back.";
 }
 
 - (BOOL)assetsPickerControllerShouldShowEmptyAlbums:(TSAssetsPickerController *)picker {
 return YES;
 }
 
 - (BOOL)assetsPickerControllerShouldDimmCellsForEmptyAlbums:(TSAssetsPickerController *)picker {
 return NO;
 }
 
 - (BOOL)assetsPickerControllerShouldReverseAlbumsOrder:(TSAssetsPickerController *)picker {
 return YES;
 }
 */

#pragma mark - TSAssetsPickerControllerDelegate
- (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

- (void)assetsPickerControllerDidCancel:(TSAssetsPickerController *)picker {
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_picker dismissViewControllerAnimated:YES completion:nil];
        [DummyAssetsImporter importAssets:assets];
    });
    UIImage *img = [self fullResolutionImageFromALAsset:[assets objectAtIndex:0]];
    img = [ImageRotation rotateImage:img orientation:UIImageOrientationDown];
    // 去编辑
    EditVC *vc = [[EditVC alloc] initImage:img];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)assetsPickerController:(TSAssetsPickerController *)picker failedWithError:(NSError *)error {
    if (error) {
        NSLog(@"Error occurs. Show dialog or something. Probably because user blocked access to Camera Roll.");
    }
}


@end
