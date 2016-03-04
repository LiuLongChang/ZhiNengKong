//
//  EquipMesssageViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "Equip.h"
@interface EquipMesssageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (strong,nonatomic) Equip *equip;
@end
