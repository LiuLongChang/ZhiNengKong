//
//  ContactTableViewCell.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/5.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end
