//
//  ContactsViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/5.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSString *selectedEqid;
@end
