//
//  AtEquipViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/28.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@protocol AtEquipDelegate <NSObject>

-(void)AtEquip:(NSString *)eqID withName:(NSString *)eqName;

@end

@interface AtEquipViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSString *circleId;
@property (nonatomic,weak) id<AtEquipDelegate> atEqiupDelegate;
@end
