//
//  LoginViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *regButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setClearButtonForTextField:_loginNameTextField];
    [super setClearButtonForTextField:_passwordTextField];
    
    _loginNameTextField.delegate = self;
    _passwordTextField.delegate = self;
   
    [super setRadiusForButton:_loginButton];
    [super setRadiusForButton:_regButton];
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];    
    [self.view addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_loginNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [textField.text mutableCopy];
    
    if (string.length == 0) {
        return YES;
    }
    
    if (textField == _loginNameTextField) {
        return [text length] <= 10;
    }
    
    if (textField == _passwordTextField) {
        return [text length] <= 15;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _loginNameTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [textField resignFirstResponder];
    }
    
    if (textField == _passwordTextField) {
        [self login];
    }
    
    return YES;
}

#pragma mark - 事件

- (IBAction)loginButtonClick:(id)sender {
    [self login];
}
- (IBAction)regButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"reg" sender:sender];
}
- (IBAction)forgetButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"forget" sender:sender];
}
- (IBAction)quickLoginButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"quick" sender:sender];
}

#pragma mark - 登录

-(void)login{
    if ([_loginNameTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入手机号" content:nil ok:nil];
        return;
    }
    
    if ([_passwordTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入密码" content:nil ok:nil];
        return;
    }
    
    [CloudBL PhoneLogin_Phone:_loginNameTextField.text Password:_passwordTextField.text success:^(NSString *HGUID, Token *token, NSString *UserName) {
        [Utils_UserDefaultInfo SetUserIdentifer:HGUID];
        [Utils_UserDefaultInfo SetUserAccessKey:token.accessToken];
        [Utils_UserDefaultInfo SetUserRefreshToken:token.refreshToken];
        [Utils_UserDefaultInfo SetUserName:UserName];
        [Utils_UserDefaultInfo SetUserPhone:_loginNameTextField.text];
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"main"];
        [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [_loginNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
