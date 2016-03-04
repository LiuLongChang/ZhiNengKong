//
//  Model/CommandUser.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommandUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic) UIImage *image;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
