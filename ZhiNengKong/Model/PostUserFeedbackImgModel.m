//
//  Model/PostUserFeedbackImgModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUserFeedbackImgModel.h"

NSString *const kPostUserFeedbackImgModelUN = @"UN";
NSString *const kPostUserFeedbackImgModelAccessToken = @"AccessToken";
NSString *const kPostUserFeedbackImgModelFeedBackID = @"FeedBackID";
NSString *const kPostUserFeedbackImgModelContent = @"Content";
NSString *const kPostUserFeedbackImgModelImageData = @"ImageData";

@interface PostUserFeedbackImgModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUserFeedbackImgModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize feedBackID = _feedBackID;
@synthesize content = _content;
@synthesize imageData = _imageData;

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
        self.uN = [self objectOrNilForKey:kPostUserFeedbackImgModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUserFeedbackImgModelAccessToken fromDictionary:dict];
        self.feedBackID = [self objectOrNilForKey:kPostUserFeedbackImgModelFeedBackID fromDictionary:dict];
        self.content = [self objectOrNilForKey:kPostUserFeedbackImgModelContent fromDictionary:dict];
        self.imageData = [self objectOrNilForKey:kPostUserFeedbackImgModelImageData fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUserFeedbackImgModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUserFeedbackImgModelAccessToken];
	[mutableDict setValue:self.feedBackID forKey:kPostUserFeedbackImgModelFeedBackID];
	[mutableDict setValue:self.content forKey:kPostUserFeedbackImgModelContent];
	[mutableDict setValue:self.imageData forKey:kPostUserFeedbackImgModelImageData];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUserFeedbackImgModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUserFeedbackImgModelAccessToken];
	self.feedBackID = [aDecoder decodeObjectForKey:kPostUserFeedbackImgModelFeedBackID];
	self.content = [aDecoder decodeObjectForKey:kPostUserFeedbackImgModelContent];
	self.imageData = [aDecoder decodeObjectForKey:kPostUserFeedbackImgModelImageData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUserFeedbackImgModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUserFeedbackImgModelAccessToken];
	[aCoder encodeObject:_feedBackID forKey:kPostUserFeedbackImgModelFeedBackID];
	[aCoder encodeObject:_content forKey:kPostUserFeedbackImgModelContent];
	[aCoder encodeObject:_imageData forKey:kPostUserFeedbackImgModelImageData];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUserFeedbackImgModel *copy = [[PostUserFeedbackImgModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.feedBackID = [self.feedBackID copyWithZone:zone];
		copy.content = [self.content copyWithZone:zone];
		copy.imageData = [self.imageData copyWithZone:zone];
    }
    
    return copy;
}


@end