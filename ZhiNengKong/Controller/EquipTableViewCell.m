//
//  EquipTableViewCell.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/30.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipTableViewCell.h"

@implementation EquipTableViewCell

@synthesize cellType = _cellType;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    [super willTransitionToState:state];
    
    if ((state & UITableViewCellStateShowingDeleteConfirmationMask) == UITableViewCellStateShowingDeleteConfirmationMask) {
        
        for (UIView *subview in self.subviews) {
            
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
                
                subview.hidden = YES;
                subview.alpha = 0.0;
            }
        }
    }
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];
    
    if (state == UITableViewCellStateShowingDeleteConfirmationMask || state == UITableViewCellStateDefaultMask) {
        for (UIView *subview in self.subviews) {
            NSLog(@"%@",NSStringFromClass([subview class]));
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
                
                UIView *deleteButtonView = (UIView *)[subview.subviews objectAtIndex:0];
                CGRect f = deleteButtonView.frame;
                f.origin.x -= 50;
                deleteButtonView.frame = f; //这里可以改变delete button的大小
                
                subview.hidden = NO;
                
                [UIView beginAnimations:@"anim" context:nil];
                subview.alpha = 1.0;
                [UIView commitAnimations];
            }
        }
    }
}

-(void)setCellType:(int)cellType{
    _cellType = cellType;
   self.acceptButton.hidden = self.refuseButton.hidden = (_cellType != EquipTableViewCellTypeInvitation);
    
    if (cellType == EquipTableViewCellTypeInvitation) {
        
        NSMutableArray *constrains = [NSMutableArray array];
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if (constraint.firstItem == _timeLabel || constraint.secondItem == _timeLabel) {
                [constrains addObject:constraint];
            }
        }
        
        [self.contentView removeConstraints:constrains];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:15.0f]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timeLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_refuseButton attribute:NSLayoutAttributeLeading multiplier:1.0f constant:-15.0f]];
        
    }else if (cellType == EquipTableViewCellTypeShared){
        _shareButton.hidden = YES;
    }
}

@end
