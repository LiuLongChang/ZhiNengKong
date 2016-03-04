//
//  ContactsData.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/5.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface ContactsData : NSObject
@property (strong,nonatomic) NSString *firstNames;
@property (strong,nonatomic) NSString *lastNames;
@property (strong,nonatomic) NSString *fullName;
@property (nonatomic) NSMutableArray *numbers;
@property (nonatomic) NSMutableArray *emails;
@property (nonatomic) UIImage *image;
@property ABRecordID contactId;
@end
