//
//  InsetTextField.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "InsetTextField.h"

@implementation InsetTextField

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 10);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 10, 10);
}

@end
