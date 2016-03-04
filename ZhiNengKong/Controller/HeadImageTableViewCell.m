//
//  HeadImageTableViewCell.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "HeadImageTableViewCell.h"

@implementation HeadImageTableViewCell

- (void)awakeFromNib {
    _headImageView.layer.cornerRadius = 40;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.borderWidth = 2.0f;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setHeadImage:[UIImage imageNamed:@"default"]];
}

-(void)setHeadImage:(UIImage *)image{
    
    _headImageView.image = image;
    
    /**** 放大原图 *****/
    
    //高斯模糊边界大小
    CGFloat borderWidth = 40.0f;
    
    CGSize originSize = self.bounds.size;
    
    //放大后的尺寸
    CGSize bigSize =CGSizeMake(originSize.width + (borderWidth * 2.0f), originSize.height + (borderWidth * 2.0f));
    
    //开始绘图
    UIGraphicsBeginImageContext(bigSize);
    //原图放大
    [image drawInRect:CGRectMake(0, 0, bigSize.width, bigSize.height)];
    //取得放大后的图片
    UIImage *bigImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘图
    UIGraphicsEndImageContext();
    
    /**** 高斯模糊 *****/
    
    //开始处理图片
    CIContext *context = [CIContext contextWithOptions:nil];
    //传入放大后的图片
    CIImage *bigCIImage = [[CIImage alloc] initWithImage:bigImage];
    //高斯模糊滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:bigCIImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:20.0] forKey:@"inputRadius"];
    //应用滤镜
    CIImage *bigResultCIImage = [filter valueForKey:kCIOutputImageKey];
    //取得应用滤镜后的图片
    CGImageRef bigResultCGImage = [context createCGImage:bigResultCIImage fromRect:[bigResultCIImage extent]];
    UIImage *bigResultImage = [UIImage imageWithCGImage:bigResultCGImage];
    //释放CG
    CGImageRelease(bigResultCGImage);
    
    /**** 裁边 *****/
    
    //画布匹配原尺寸
    UIGraphicsBeginImageContext(originSize);
    //从放大模糊的图片中截取（截掉边缘）
    CGImageRef subImageRef = CGImageCreateWithImageInRect(bigResultImage.CGImage, CGRectMake(borderWidth, borderWidth, originSize.width, originSize.height));
    UIImage *originSizeImage = [UIImage imageWithCGImage:subImageRef];
    //设置处理完的图片给背景
    _backgroundImageView.image = originSizeImage;
    
    //释放资源
    CGImageRelease(subImageRef);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
