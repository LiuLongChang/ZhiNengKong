//
//  ShareEquipViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/5.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareEquipViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
@property (strong,nonatomic) NSString *selectedEqid;
@end
