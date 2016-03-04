//
//  Model/PostUserFeedbackModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUserFeedbackModel.h"

NSString *const kPostUserFeedbackModelUN = @"UN";
NSString *const kPostUserFeedbackModelAccessToken = @"AccessToken";
NSString *const kPostUserFeedbackModelFeedBackID = @"FeedBackID";
NSString *const kPostUserFeedbackModelContent = @"Content";

@interface PostUserFeedbackModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUserFeedbackModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize feedBackID = _feedBackID;
@synthesize content = _content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.uN = [self objectOrNilForKey:kPostUserFeedbackModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUserFeedbackModelAccessToken fromDictionary:dict];
        self.feedBackID = [self objectOrNilForKey:kPostUserFeedbackModelFeedBackID fromDictionary:dict];
        self.content = [self objectOrNilForKey:kPostUserFeedbackModelContent fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUserFeedbackModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUserFeedbackModelAccessToken];
	[mutableDict setValue:self.feedBackID forKey:kPostUserFeedbackModelFeedBackID];
	[mutableDict setValue:self.content forKey:kPostUserFeedbackModelContent];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

	self.uN = [aDecoder decodeObjectForKey:kPostUserFeedbackModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUserFeedbackModelAccessToken];
	self.feedBackID = [aDecoder decodeObjectForKey:kPostUserFeedbackModelFeedBackID];
	self.content = [aDecoder decodeObjectForKey:kPostUserFeedbackModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUserFeedbackModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUserFeedbackModelAccessToken];
	[aCoder encodeObject:_feedBackID forKey:kPostUserFeedbackModelFeedBackID];
	[aCoder encodeObject:_content forKey:kPostUserFeedbackModelContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUserFeedbackModel *copy = [[PostUserFeedbackModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.feedBackID = [self.feedBackID copyWithZone:zone];
		copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end