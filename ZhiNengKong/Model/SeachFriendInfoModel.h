//
//  Model/SeachFriendInfoModel.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeachFriendInfoModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *fID;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
