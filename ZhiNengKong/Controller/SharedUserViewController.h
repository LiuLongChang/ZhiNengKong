//
//  SharedUserViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface SharedUserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSString *eqID;
@property (nonatomic) NSMutableArray *users;
@property (nonatomic) NSDictionary *usersDic;
@end
