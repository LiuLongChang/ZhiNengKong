//
//  Model/MyEquipsModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEquipsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSNumber *tS;
@property (nonatomic, strong) NSArray *equips;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
