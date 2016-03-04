//
//  Model/PostInvitationResponseModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostInvitationResponseModel.h"

NSString *const kPostInvitationResponseModelUN = @"UN";
NSString *const kPostInvitationResponseModelAccessToken = @"AccessToken";
NSString *const kPostInvitationResponseModelShareID = @"ShareID";
NSString *const kPostInvitationResponseModelIsApproved = @"IsApproved";

@interface PostInvitationResponseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostInvitationResponseModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize shareID = _shareID;
@synthesize isApproved = _isApproved;

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
        self.uN = [self objectOrNilForKey:kPostInvitationResponseModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostInvitationResponseModelAccessToken fromDictionary:dict];
        self.shareID = [self objectOrNilForKey:kPostInvitationResponseModelShareID fromDictionary:dict];
        self.isApproved = [self objectOrNilForKey:kPostInvitationResponseModelIsApproved fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostInvitationResponseModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostInvitationResponseModelAccessToken];
	[mutableDict setValue:self.shareID forKey:kPostInvitationResponseModelShareID];
	[mutableDict setValue:self.isApproved forKey:kPostInvitationResponseModelIsApproved];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostInvitationResponseModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostInvitationResponseModelAccessToken];
	self.shareID = [aDecoder decodeObjectForKey:kPostInvitationResponseModelShareID];
	self.isApproved = [aDecoder decodeObjectForKey:kPostInvitationResponseModelIsApproved];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostInvitationResponseModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostInvitationResponseModelAccessToken];
	[aCoder encodeObject:_shareID forKey:kPostInvitationResponseModelShareID];
	[aCoder encodeObject:_isApproved forKey:kPostInvitationResponseModelIsApproved];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostInvitationResponseModel *copy = [[PostInvitationResponseModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.shareID = [self.shareID copyWithZone:zone];
		copy.isApproved = [self.isApproved copyWithZone:zone];
    }
    
    return copy;
}


@end