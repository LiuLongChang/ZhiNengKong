//
//  BaseNavigationViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationViewController : UINavigationController<UINavigationControllerDelegate>
-(void)changeState:(UIViewController *)viewController;
@end
