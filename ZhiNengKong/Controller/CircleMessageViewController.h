//
//  CircleMessageViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "MyCirclesModel.h"
#import "AtEquipViewController.h"

@interface CircleMessageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,AtEquipDelegate>
@property (nonatomic,strong) MyCirclesModel *circle;
@end
