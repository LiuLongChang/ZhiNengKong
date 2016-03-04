//
//  FeedbackPreviewViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/27.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FeedbackPreviewViewController : BaseViewController<UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic) NSMutableArray *images;
@property (nonatomic) UIImage *currentImage;
@end
