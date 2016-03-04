//
//  AddEquipViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddEquipViewController.h"
@import SystemConfiguration.CaptiveNetwork;

@interface AddEquipViewController ()
@property (weak, nonatomic) IBOutlet UIView *ssidView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIButton *ssidButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation AddEquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *borderColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    
    _ssidView.layer.cornerRadius = 10.0f;
    _ssidView.layer.borderColor = borderColor.CGColor;
    _ssidView.layer.borderWidth = 0.5f;
    _ssidView.layer.masksToBounds = NO;
    
    _passwordView.layer.cornerRadius = 10.0f;
    _passwordView.layer.borderColor = borderColor.CGColor;
    _passwordView.layer.borderWidth = 0.5f;
    _passwordView.layer.masksToBounds = NO;
    
    NSDictionary *ssidDic = [self fetchSSIDInfo];
    if (ssidDic[@"SSID"]) {
        [_ssidButton setTitle:ssidDic[@"SSID"] forState:UIControlStateNormal];
    }
    
    [self setRadiusForButton:_connectButton];
}
- (IBAction)connect:(id)sender {
    [self alertWithTitle:@"成功添加设备" content:@"婴儿床已经成功加入大家庭\n编号：EA3D524F" ok:^(id sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

/** Returns first non-empty SSID network info dictionary.
 *  @see CNCopyCurrentNetworkInfo */
- (NSDictionary *)fetchSSIDInfo
{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}


//- (IBAction)ssidClick:(id)sender {
//    [self performSegueWithIdentifier:@"wifi" sender:self];
//}

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
