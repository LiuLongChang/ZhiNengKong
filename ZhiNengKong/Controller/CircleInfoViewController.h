//
//  CircleInfoViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface CircleInfoViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSString *circleId;
@property (nonatomic,strong) NSString *circleName;
@property (nonatomic) BOOL isCreator;
@end
