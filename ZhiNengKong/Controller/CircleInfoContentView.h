//
//  CircleInfoContentView.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleInfoContentView : UIView
@property (weak, nonatomic) IBOutlet UITextField *circleNameTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *circleCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *memberHeightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *memberCollectionView;
@end
