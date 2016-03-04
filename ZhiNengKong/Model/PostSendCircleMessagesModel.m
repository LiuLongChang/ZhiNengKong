//
//  Model/PostSendCircleMessagesModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSendCircleMessagesModel.h"

NSString *const kPostSendCircleMessagesModelUN = @"UN";
NSString *const kPostSendCircleMessagesModelAccessToken = @"AccessToken";
NSString *const kPostSendCircleMessagesModelCircleID = @"CircleID";
NSString *const kPostSendCircleMessagesModelEqIDs = @"EqIDs";
NSString *const kPostSendCircleMessagesModelText = @"Text";
NSString *const kPostSendCircleMessagesModelTS = @"TS";

@interface PostSendCircleMessagesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSendCircleMessagesModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize circleID = _circleID;
@synthesize eqIDs = _eqIDs;
@synthesize text = _text;
@synthesize tS = _tS;

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
        self.uN = [self objectOrNilForKey:kPostSendCircleMessagesModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSendCircleMessagesModelAccessToken fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kPostSendCircleMessagesModelCircleID fromDictionary:dict];
        self.eqIDs = [self objectOrNilForKey:kPostSendCircleMessagesModelEqIDs fromDictionary:dict];
        self.text = [self objectOrNilForKey:kPostSendCircleMessagesModelText fromDictionary:dict];
        self.tS = [self objectOrNilForKey:kPostSendCircleMessagesModelTS fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSendCircleMessagesModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostSendCircleMessagesModelAccessToken];
	[mutableDict setValue:self.circleID forKey:kPostSendCircleMessagesModelCircleID];
	[mutableDict setValue:self.eqIDs forKey:kPostSendCircleMessagesModelEqIDs];
	[mutableDict setValue:self.text forKey:kPostSendCircleMessagesModelText];
	[mutableDict setValue:self.tS forKey:kPostSendCircleMessagesModelTS];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelAccessToken];
	self.circleID = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelCircleID];
	self.eqIDs = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelEqIDs];
	self.text = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelText];
	self.tS = [aDecoder decodeObjectForKey:kPostSendCircleMessagesModelTS];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSendCircleMessagesModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostSendCircleMessagesModelAccessToken];
	[aCoder encodeObject:_circleID forKey:kPostSendCircleMessagesModelCircleID];
	[aCoder encodeObject:_eqIDs forKey:kPostSendCircleMessagesModelEqIDs];
	[aCoder encodeObject:_text forKey:kPostSendCircleMessagesModelText];
	[aCoder encodeObject:_tS forKey:kPostSendCircleMessagesModelTS];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSendCircleMessagesModel *copy = [[PostSendCircleMessagesModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.eqIDs = [self.eqIDs copyWithZone:zone];
		copy.text = [self.text copyWithZone:zone];
		copy.tS = [self.tS copyWithZone:zone];
    }
    
    return copy;
}


@end