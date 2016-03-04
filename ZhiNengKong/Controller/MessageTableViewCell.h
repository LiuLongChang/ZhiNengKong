//
//  MessageTableViewCell.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/7.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong,nonatomic) NSString *message;
@property (strong,nonatomic) NSString *time;
@property (nonatomic) UIColor *messageColor;
@property (nonatomic) UIColor *fontColor;
@end
