//
//  EquipTableViewCell.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/30.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

#ifndef EquipTableViewCellTypeNormal
#define EquipTableViewCellTypeNormal 0
#endif

#ifndef EquipTableViewCellTypeShared
#define EquipTableViewCellTypeShared 1
#endif

#ifndef EquipTableViewCellTypeInvitation
#define EquipTableViewCellTypeInvitation 2
#endif
@interface EquipTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *equipNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;
@property (nonatomic) int cellType;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@end
