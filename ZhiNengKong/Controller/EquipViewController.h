//
//  EquipViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/29.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ContactsData.h"
#import "MGSwipeTableCell.h"

@interface EquipViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate>
@property (strong,nonatomic) ContactsData *sharedPerson;
@property (strong,nonatomic) NSString *selectedEqid;
@end
