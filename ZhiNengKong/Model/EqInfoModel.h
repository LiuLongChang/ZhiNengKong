//
//  Model/EqInfoModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EqInfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *uniCode;
@property (nonatomic, strong) NSString *eqName;
@property (nonatomic, strong) NSString *eqAvatar;
@property (nonatomic) UIImage *image;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
