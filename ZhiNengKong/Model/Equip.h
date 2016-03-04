//
//  Model/Equip.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Equip : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *eqID;
@property (nonatomic, strong) NSNumber *isOwner;
@property (nonatomic, strong) NSString *equipName;
@property (nonatomic, strong) NSString *equipAlias;
@property (nonatomic, strong) NSString *equipAvatar;
@property (nonatomic) UIImage *image;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
