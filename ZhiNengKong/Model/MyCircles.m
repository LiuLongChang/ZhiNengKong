//
//  Model/MyCircles.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MyCircles.h"

NSString *const kMyCirclesName = @"Name";
NSString *const kMyCirclesAvatar = @"Avatar";
NSString *const kMyCirclesCircleID = @"CircleID";
NSString *const kMyCirclesIsCreater = @"IsCreater";

@interface MyCircles ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyCircles

@synthesize name = _name;
@synthesize avatar = _avatar;
@synthesize circleID = _circleID;
@synthesize isCreater = _isCreater;

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
        self.name = [self objectOrNilForKey:kMyCirclesName fromDictionary:dict];
        self.avatar = [self objectOrNilForKey:kMyCirclesAvatar fromDictionary:dict];
        self.circleID = [self objectOrNilForKey:kMyCirclesCircleID fromDictionary:dict];
        self.isCreater = [self objectOrNilForKey:kMyCirclesIsCreater fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.name forKey:kMyCirclesName];
	[mutableDict setValue:self.avatar forKey:kMyCirclesAvatar];
	[mutableDict setValue:self.circleID forKey:kMyCirclesCircleID];
	[mutableDict setValue:self.isCreater forKey:kMyCirclesIsCreater];
    
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

	self.name = [aDecoder decodeObjectForKey:kMyCirclesName];
	self.avatar = [aDecoder decodeObjectForKey:kMyCirclesAvatar];
	self.circleID = [aDecoder decodeObjectForKey:kMyCirclesCircleID];
	self.isCreater = [aDecoder decodeObjectForKey:kMyCirclesIsCreater];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_name forKey:kMyCirclesName];
	[aCoder encodeObject:_avatar forKey:kMyCirclesAvatar];
	[aCoder encodeObject:_circleID forKey:kMyCirclesCircleID];
	[aCoder encodeObject:_isCreater forKey:kMyCirclesIsCreater];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyCircles *copy = [[MyCircles alloc] init];
    
    if (copy) {
        
		copy.name = [self.name copyWithZone:zone];
		copy.avatar = [self.avatar copyWithZone:zone];
		copy.circleID = [self.circleID copyWithZone:zone];
		copy.isCreater = [self.isCreater copyWithZone:zone];
    }
    
    return copy;
}


@end