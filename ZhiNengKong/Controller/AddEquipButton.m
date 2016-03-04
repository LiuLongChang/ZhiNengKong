//
//  AddEquipButton.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/29.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddEquipButton.h"

@interface AddEquipButton ()

@end

@implementation AddEquipButton

//-(id)initWithCoder:(NSCoder *)aDecoder{
//    _radius = 50.0f;
//    return [super initWithCoder:aDecoder];
//}

//-(instancetype)initWithFrame:(CGRect)frame{
//    _radius = frame.size.height > frame.size.width ? frame.size.width / 2.0f : frame.size.height / 2.0f;
//    return [super initWithFrame:frame];
//}

-(void)drawRect:(CGRect)rect{
    _radius = self.bounds.size.width / 2.0f;
    CGFloat radius2 = _radius - 1.0f;
    CGFloat radius3 = _radius - 10.0f;
    CGFloat radius4 = _radius - 15.0f;
    
    CGPoint pCenter = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, rect);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:208.0/255.0 green:223.0/255.0 blue:242.0/255.0 alpha:1.0f].CGColor);
    CGContextAddArc(context, pCenter.x, pCenter.y, _radius, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:238.0/255.0 green:243.0/255.0 blue:249.0/255.0 alpha:1.0f].CGColor);
    CGContextAddArc(context, pCenter.x, pCenter.y, radius2, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:208.0/255.0 green:223.0/255.0 blue:242.0/255.0 alpha:1.0f].CGColor);
    CGContextAddArc(context, pCenter.x, pCenter.y, radius3, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0f].CGColor);
    CGContextAddArc(context, pCenter.x, pCenter.y, radius4, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attDic = @{
                            NSFontAttributeName:self.titleLabel.font,
                            NSParagraphStyleAttributeName:style,
                            NSForegroundColorAttributeName:self.tintColor
                            };
    
    NSString *title = @"当前无设备\n在这添加";
    
    CGSize size = [title sizeWithAttributes:attDic];
    
    [title drawWithRect:CGRectMake(pCenter.x - (size.width / 2.0f), pCenter.y - (size.height / 2.0f), size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:[[NSStringDrawingContext alloc] init]];
    
}

@end
