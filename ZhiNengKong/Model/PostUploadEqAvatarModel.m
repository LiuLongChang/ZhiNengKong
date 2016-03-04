//
//  Model/PostUploadEqAvatarModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUploadEqAvatarModel.h"

NSString *const kPostUploadEqAvatarModelUN = @"UN";
NSString *const kPostUploadEqAvatarModelAccessToken = @"AccessToken";
NSString *const kPostUploadEqAvatarModelEqID = @"EqID";
NSString *const kPostUploadEqAvatarModelExt = @"Ext";
NSString *const kPostUploadEqAvatarModelImageData = @"ImageData";

@interface PostUploadEqAvatarModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUploadEqAvatarModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
@synthesize eqID = _eqID;
@synthesize ext = _ext;
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
        self.uN = [self objectOrNilForKey:kPostUploadEqAvatarModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUploadEqAvatarModelAccessToken fromDictionary:dict];
        self.eqID = [self objectOrNilForKey:kPostUploadEqAvatarModelEqID fromDictionary:dict];
        self.ext = [self objectOrNilForKey:kPostUploadEqAvatarModelExt fromDictionary:dict];
        self.imageData = [self objectOrNilForKey:kPostUploadEqAvatarModelImageData fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUploadEqAvatarModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUploadEqAvatarModelAccessToken];
	[mutableDict setValue:self.eqID forKey:kPostUploadEqAvatarModelEqID];
	[mutableDict setValue:self.ext forKey:kPostUploadEqAvatarModelExt];
	[mutableDict setValue:self.imageData forKey:kPostUploadEqAvatarModelImageData];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUploadEqAvatarModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUploadEqAvatarModelAccessToken];
	self.eqID = [aDecoder decodeObjectForKey:kPostUploadEqAvatarModelEqID];
	self.ext = [aDecoder decodeObjectForKey:kPostUploadEqAvatarModelExt];
	self.imageData = [aDecoder decodeObjectForKey:kPostUploadEqAvatarModelImageData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUploadEqAvatarModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUploadEqAvatarModelAccessToken];
	[aCoder encodeObject:_eqID forKey:kPostUploadEqAvatarModelEqID];
	[aCoder encodeObject:_ext forKey:kPostUploadEqAvatarModelExt];
	[aCoder encodeObject:_imageData forKey:kPostUploadEqAvatarModelImageData];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUploadEqAvatarModel *copy = [[PostUploadEqAvatarModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.eqID = [self.eqID copyWithZone:zone];
		copy.ext = [self.ext copyWithZone:zone];
		copy.imageData = [self.imageData copyWithZone:zone];
    }
    
    return copy;
}


@end