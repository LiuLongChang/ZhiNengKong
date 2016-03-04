//
//  Model/PostSynClientDataModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostSynClientDataModel.h"

NSString *const kPostSynClientDataModelUN = @"UN";
NSString *const kPostSynClientDataModelAccessToken = @"AccessToken";
NSString *const kPostSynClientDataModelCommandInfo = @"CommandInfo";

@interface PostSynClientDataModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostSynClientDataModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize commandInfo = _commandInfo;

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
        self.uN = [self objectOrNilForKey:kPostSynClientDataModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostSynClientDataModelAccessToken fromDictionary:dict];
        self.commandInfo = [self objectOrNilForKey:kPostSynClientDataModelCommandInfo fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostSynClientDataModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostSynClientDataModelAccessToken];
	[mutableDict setValue:self.commandInfo forKey:kPostSynClientDataModelCommandInfo];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostSynClientDataModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostSynClientDataModelAccessToken];
	self.commandInfo = [aDecoder decodeObjectForKey:kPostSynClientDataModelCommandInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostSynClientDataModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostSynClientDataModelAccessToken];
	[aCoder encodeObject:_commandInfo forKey:kPostSynClientDataModelCommandInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostSynClientDataModel *copy = [[PostSynClientDataModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.commandInfo = [self.commandInfo copyWithZone:zone];
    }
    
    return copy;
}


@end