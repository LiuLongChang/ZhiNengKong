//
//  MessageTableViewCell.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/7.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    [self drawFrom];
    self.headImageView.layer.cornerRadius = 28.0f;
    self.headImageView.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)drawFrom{
    
    if (_messageColor == nil) {
        _messageColor = [UIColor colorWithRed:118.0/255.0 green:174.0/255.0 blue:241.0/255.0 alpha:1.0];
    }
    
    if (_messageColor == nil) {
        _messageColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    }
    
    //圆角半径
    CGFloat cornerRadius = 20.0f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //消息框宽度（1/2cell宽）
    CGFloat msgBoxWidth = self.contentView.frame.size.width / 2.0;
    CGFloat msgInsetX = 10.0f;
    CGFloat msgInsetY = 10.0f;
    
    NSDictionary *textAttrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:_fontColor};
    
    CGSize messageSize = [_message boundingRectWithSize:CGSizeMake(msgBoxWidth - msgInsetX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrDic context:nil].size;
    
    if (messageSize.width < msgBoxWidth - (msgInsetX * 2)) {
        msgBoxWidth = messageSize.width + msgInsetX;
    }
    
    //贝塞尔曲线起点
    CGFloat startX = _headImageView.frame.origin.x + _headImageView.frame.size.width - 5.0f;
    CGPoint startPoint = CGPointMake(startX, _headImageView.frame.origin.y + 5.0f);
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:startPoint];
    
    //画顶部直线
    CGPoint point1 = CGPointMake(startPoint.x + messageSize.width + msgInsetX, startPoint.y);
    [aPath addLineToPoint:point1];
    
    //画右上角圆角
    CGPoint point2 = CGPointMake(point1.x + cornerRadius, point1.y + cornerRadius);
    CGPoint ctrlPoint2 = CGPointMake(point1.x + cornerRadius, point1.y);
    [aPath addCurveToPoint:point2 controlPoint1:ctrlPoint2 controlPoint2:ctrlPoint2];
    
    //画右侧直线
    CGPoint point3 = CGPointMake(point2.x, point2.y + messageSize.height - cornerRadius);
    [aPath addLineToPoint:point3];
    //画右下角圆角
    CGPoint point4 = CGPointMake(point3.x - cornerRadius, point3.y + cornerRadius);
    CGPoint ctrlPoint4 = CGPointMake(point3.x, point3.y+cornerRadius);
    [aPath addCurveToPoint:point4 controlPoint1:ctrlPoint4 controlPoint2:ctrlPoint4];
    
    //画底部直线
    CGPoint point5 = CGPointMake(startX + (cornerRadius * 1.5), point4.y);
    [aPath addLineToPoint:point5];
    
    //画左下角圆角
    CGPoint point6 = CGPointMake(point5.x - cornerRadius, point5.y - cornerRadius);
    CGPoint ctrlPoint6 = CGPointMake(point5.x - cornerRadius, point5.y);
    [aPath addCurveToPoint:point6 controlPoint1:ctrlPoint6 controlPoint2:ctrlPoint6];
    
    //画左上角圆角
    CGPoint ctrlPoint7 = CGPointMake(startPoint.x + (cornerRadius * 0.5), startPoint.y + (cornerRadius * 0.5));
    [aPath addCurveToPoint:startPoint controlPoint1:ctrlPoint7 controlPoint2:ctrlPoint7];
    
    CGContextSetFillColor(context, CGColorGetComponents(_messageColor.CGColor));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1.0, [[UIColor lightGrayColor]CGColor]);
    
    //填充
    [aPath fill];
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, [UIColor clearColor].CGColor);
    
    CGRect messageRect = CGRectMake(startPoint.x + (msgInsetX * 2), startPoint.y + msgInsetY, messageSize.width, messageSize.height);
    
    [_message drawWithRect:messageRect options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrDic context:[[NSStringDrawingContext alloc] init]];
    
    NSDictionary *timeAttrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    
    CGSize timeSize = [_time boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:timeAttrDic context:nil].size;

    CGRect timeRect = CGRectMake(startPoint.x + msgBoxWidth + cornerRadius + msgInsetX, startPoint.y + (messageSize.height - timeSize.height + (msgInsetY * 2)) , timeSize.width, timeSize.height);
    
    [_time drawWithRect:timeRect options:NSStringDrawingUsesLineFragmentOrigin attributes:timeAttrDic context:[[NSStringDrawingContext alloc] init]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
