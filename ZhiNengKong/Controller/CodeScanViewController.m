//
//  CodeScanViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CodeScanViewController.h"
#import "ZBarSDK.h"

@interface CodeScanViewController ()
{
    ZBarReaderView *readerView;
}
@end

@implementation CodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScanView];
}

-(void)viewWillAppear:(BOOL)animated{
    [readerView start];
}

-(void)createScanView{
    readerView = [[ZBarReaderView alloc]init];
    readerView.frame = self.view.frame;
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //扫描区域
    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(readerView.frame) - 126, 200, 200);
//    CGRect scanMaskRect = CGRectMake(50.0f, 100.0f, self.view.frame.size.width - 100.0f, self.view.frame.size.width - 100.0f);
    
    UIView *maskView = [[UIView alloc] initWithFrame:scanMaskRect];
    maskView.layer.borderWidth = 1.0f;
    maskView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    
    //扫描区域计算
    readerView.scanCrop = [self getLandscapeModeScanCropRect:maskView scanView:readerView];
    [readerView start];
    
    [self.view addSubview:readerView];
    [self.view addSubview:maskView];
}

//The region of the video image that will be scanned, in normalized image coordinates. Note that the video image is in landscape mode (default {{0, 0}, {1, 1}})
- (CGRect)getLandscapeModeScanCropRect:(UIView*)readerView
                              scanView:(UIView*)scanView
{
    CGRect scanCropRect = CGRectMake(0, 0, 1, 1); /*default full screen*/
    
    CGFloat x,y,width,height;
    x = scanView.frame.origin.x / readerView.bounds.size.width;
    y = scanView.frame.origin.y / readerView.bounds.size.height;
    width = scanView.frame.size.width / readerView.bounds.size.width;
    height = scanView.frame.size.height / readerView.bounds.size.height;
    
    scanCropRect = CGRectMake(x, y, width, height);
    return scanCropRect;
}

//CGRect scanCrop

//The region of the video image that will be scanned, in normalized image coordinates. Note that assuming your coordinates refer to points in portrait orientation, using the default camera image size, located at the default location and taking into account that the camera image is rotated


- (CGRect)getPortraitModeScanCropRect:(CGRect)overlayCropRect
                       forOverlayView:(UIView*)readerView
{
    CGRect scanCropRect = CGRectMake(0, 0, 1, 1); /*default full screen*/
    
    float x = overlayCropRect.origin.x;
    float y = overlayCropRect.origin.y;
    float width = overlayCropRect.size.width;
    float height = overlayCropRect.size.height;
    
    
    float A = y / readerView.bounds.size.height;
    float B = 1 - (x + width) / readerView.bounds.size.width;
    float C = (y + height) / readerView.bounds.size.height;
    float D = 1 - x / readerView.bounds.size.width;
    
    scanCropRect = CGRectMake( A, B, C, D );
    
    return scanCropRect;
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols) {
        NSLog(@"%@", symbol.data);
        break;
    }
    
    [readerView stop];
    [self performSegueWithIdentifier:@"add" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
