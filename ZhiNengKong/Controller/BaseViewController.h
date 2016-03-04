//
//  BaseViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ALERT_VIEW_BLOCK)(id sender);

@interface BaseViewController : UIViewController

-(void)setClearButtonForTextField:(UITextField *)textField;

-(void)setRadiusForButton:(UIButton *)button;

-(void)setCellStyle:(UITableViewCell *)cell withHeight:(CGFloat)height forTableView:(UITableView *)tableView;

-(void)setCellAccessory:(UITableViewCell *)cell;

-(id)confirmWithTitle:(NSString *)title content:(NSString *)content subView:(UIView *)subView ok:(ALERT_VIEW_BLOCK)ok cancel:(ALERT_VIEW_BLOCK)cancel;

-(id)confirmWithTitle:(NSString *)title content:(NSString *)content ok:(ALERT_VIEW_BLOCK)ok cancel:(ALERT_VIEW_BLOCK)cancel;

-(id)alertWithTitle:(NSString *)title content:(NSString *)content ok:(ALERT_VIEW_BLOCK)ok;

- (void)showTabBar;

- (void)hideTabBar;
@end
