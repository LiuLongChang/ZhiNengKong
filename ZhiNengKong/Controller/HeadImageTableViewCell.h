//
//  HeadImageTableViewCell.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
-(void)setHeadImage:(UIImage *)image;
@property (weak, nonatomic) IBOutlet UILabel *textField;
@end
