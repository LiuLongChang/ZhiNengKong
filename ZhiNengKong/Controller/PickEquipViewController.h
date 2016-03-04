//
//  PickEquipViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface PickEquipViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSMutableArray *selectedEquips;
@end
