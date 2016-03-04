//
//  BaseNavigationViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "FeedbackPreviewViewController.h"
#import "EquipDetailViewController.h"
#import "EquipFeedbackViewController.h"
#import "EquipEditViewController.h"

@interface BaseNavigationViewController ()
@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    //自定义返回按钮
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back_button"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back_button"]];
    self.navigationBar.tintColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0f];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self changeState:viewController];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self changeState:viewController];
}

-(void)changeState:(UIViewController *)viewController{
    //不显示返回按钮文字
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //登录页、我的页不显示导航栏
    if ([viewController isKindOfClass:[LoginViewController class]] || [viewController isKindOfClass:[MineViewController class]]) {
        self.navigationBarHidden = YES;
    }else{
        self.navigationBarHidden = NO;
    }
    
    if ([viewController isKindOfClass:[EquipDetailViewController class]] || [viewController isKindOfClass:[EquipEditViewController class]] || [viewController isKindOfClass:[EquipFeedbackViewController class]]) {
        [self.navigationBar setBackgroundImage:[UIImage new]
                                 forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage new];
        self.navigationBar.translucent = YES;
        self.navigationBar.tintColor = [UIColor whiteColor];
        
        NSDictionary *dic = self.navigationBar.titleTextAttributes;
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        mDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        self.navigationBar.titleTextAttributes = mDic;
        
    }else{
        self.navigationBar.shadowImage = nil;
        self.navigationBar.tintColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0f];
        NSDictionary *dic = self.navigationBar.titleTextAttributes;
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        mDic[NSForegroundColorAttributeName] = [UIColor blackColor];
        self.navigationBar.titleTextAttributes = mDic;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
