//
//  EquipEditViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/7.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipEditViewController.h"

@interface EquipEditViewController ()

@end

@implementation EquipEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _textField.leftView = paddingView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.text = @"热水器";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)save{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
