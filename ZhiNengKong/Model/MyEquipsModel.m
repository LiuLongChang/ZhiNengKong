//
//  Model/MyEquipsModel.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/25.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MyEquipsModel.h"

NSString *const kMyEquipsModelTS = @"TS";
NSString *const kMyEquipsModelEquips = @"Equips";

@interface MyEquipsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyEquipsModel

@synthesize tS = _tS;
@synthesize equips = _equips;

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
        self.tS = [self objectOrNilForKey:kMyEquipsModelTS fromDictionary:dict];
        self.equips = [self objectOrNilForKey:kMyEquipsModelEquips fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.tS forKey:kMyEquipsModelTS];
	[mutableDict setValue:self.equips forKey:kMyEquipsModelEquips];
    
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

	self.tS = [aDecoder decodeObjectForKey:kMyEquipsModelTS];
	self.equips = [aDecoder decodeObjectForKey:kMyEquipsModelEquips];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
	[aCoder encodeObject:_tS forKey:kMyEquipsModelTS];
	[aCoder encodeObject:_equips forKey:kMyEquipsModelEquips];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyEquipsModel *copy = [[MyEquipsModel alloc] init];
    
    if (copy) {
        
		copy.tS = [self.tS copyWithZone:zone];
		copy.equips = [self.equips copyWithZone:zone];
    }
    
    return copy;
}


@end