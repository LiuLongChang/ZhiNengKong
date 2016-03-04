//
//  Model/PostUploadAvatarsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PostUploadAvatarsModel.h"

NSString *const kPostUploadAvatarsModelUN = @"UN";
NSString *const kPostUploadAvatarsModelAccessToken = @"AccessToken";
NSString *const kPostUploadAvatarsModelExt = @"Ext";
NSString *const kPostUploadAvatarsModelImageData = @"ImageData";

@interface PostUploadAvatarsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PostUploadAvatarsModel

@synthesize uN = _uN;
@synthesize accessToken = _accessToken;
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
        self.uN = [self objectOrNilForKey:kPostUploadAvatarsModelUN fromDictionary:dict];
        self.accessToken = [self objectOrNilForKey:kPostUploadAvatarsModelAccessToken fromDictionary:dict];
        self.ext = [self objectOrNilForKey:kPostUploadAvatarsModelExt fromDictionary:dict];
        self.imageData = [self objectOrNilForKey:kPostUploadAvatarsModelImageData fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.uN forKey:kPostUploadAvatarsModelUN];
	[mutableDict setValue:self.accessToken forKey:kPostUploadAvatarsModelAccessToken];
	[mutableDict setValue:self.ext forKey:kPostUploadAvatarsModelExt];
	[mutableDict setValue:self.imageData forKey:kPostUploadAvatarsModelImageData];
    
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

	self.uN = [aDecoder decodeObjectForKey:kPostUploadAvatarsModelUN];
	self.accessToken = [aDecoder decodeObjectForKey:kPostUploadAvatarsModelAccessToken];
	self.ext = [aDecoder decodeObjectForKey:kPostUploadAvatarsModelExt];
	self.imageData = [aDecoder decodeObjectForKey:kPostUploadAvatarsModelImageData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_uN forKey:kPostUploadAvatarsModelUN];
	[aCoder encodeObject:_accessToken forKey:kPostUploadAvatarsModelAccessToken];
	[aCoder encodeObject:_ext forKey:kPostUploadAvatarsModelExt];
	[aCoder encodeObject:_imageData forKey:kPostUploadAvatarsModelImageData];
}

- (id)copyWithZone:(NSZone *)zone
{
    PostUploadAvatarsModel *copy = [[PostUploadAvatarsModel alloc] init];
    
    if (copy) {
        
		copy.uN = [self.uN copyWithZone:zone];
		copy.accessToken = [self.accessToken copyWithZone:zone];
		copy.ext = [self.ext copyWithZone:zone];
		copy.imageData = [self.imageData copyWithZone:zone];
    }
    
    return copy;
}


@end