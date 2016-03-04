//
//  RegViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "RegViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"

@interface RegViewController ()
{
    BOOL _isVerify;
    NSTimer *_verifyTimer;
    int _verifySeconds;
}
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setClearButtonForTextField:_loginNameTextField];
    [super setClearButtonForTextField:_verifyCodeTextField];
    [super setClearButtonForTextField:_passwordTextField];
    _loginNameTextField.delegate = self;
    _verifyCodeTextField.delegate = self;
    _passwordTextField.delegate = self;
    [super setRadiusForButton:_verifyButton];
    [super setRadiusForButton:_submitButton];
    _isVerify = NO;
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    [self.view addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_loginNameTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [[textField.text stringByAppendingString:string] mutableCopy];
    
    if (string.length == 0) {
        return YES;
    }
    
    if (textField == _loginNameTextField) {
        return [text length] <= 11;
    }
    
    if (textField == _verifyCodeTextField) {
        return [text length] <= 6;
    }
    
    if (textField == _passwordTextField) {
        return [text length] <= 16;
    }
    
    return YES;
}

#pragma mark - 键盘回车事件

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField == _loginNameTextField) {
        if (_isVerify) {
            //正在验证，则跳到输入下一项
            [_verifyCodeTextField becomeFirstResponder];
            return YES;
        }else{
            //尚未获取验证码，则获取验证码
            [self getVerifyCode];
            return YES;
        }
    }
    
    if (textField == _verifyCodeTextField) {
        [_passwordTextField becomeFirstResponder];
        return YES;
    }
    
    if (textField == _passwordTextField) {
        [self reg];
    }

    return YES;
}

#pragma mark - 设置获取验证码按钮状态
-(void)setVerifyState:(BOOL) isEnabled
{
    if (isEnabled) {
        _isVerify = NO;
        _verifySeconds = 0;
        _loginNameTextField.returnKeyType = UIReturnKeyGo;
        _verifyButton.enabled = YES;
        _verifyButton.backgroundColor = [UIColor colorWithRed:94.0/255.0 green:147.0/255.0 blue:225.0/255.0 alpha:1.0];
        [_verifyTimer invalidate];
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _isVerify = YES;
        _verifySeconds = 60;
        _loginNameTextField.returnKeyType = UIReturnKeyNext;
        _verifyButton.enabled = NO;
        _verifyButton.backgroundColor = [UIColor lightGrayColor];
        _verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerSeconds:) userInfo:nil repeats:YES];
    }
}

#pragma mark - 读秒，更新获取验证码按钮文字

-(void)timerSeconds:(NSTimer *)theTimer
{
    _verifySeconds--;
    if (_verifySeconds > 0) {
        [self.verifyButton setTitle:[NSString stringWithFormat:@"重新发送(%d)",_verifySeconds] forState:UIControlStateDisabled];
    }else{
        [self setVerifyState:YES];
    }
}

#pragma mark - 点击获取验证码按钮

- (IBAction)verifyCodeButtonClick:(id)sender {
    [self getVerifyCode];
    [_verifyCodeTextField becomeFirstResponder];
}
- (IBAction)submitButtonClick:(id)sender {
    [self reg];
}

- (IBAction)agreementButtonClick:(id)sender {
    
}

#pragma mark - 获取验证码

-(void)getVerifyCode{
    NSString *regexString = @"1[0-9]{10}";
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    
    if(![regex evaluateWithObject:_loginNameTextField.text]){
        [self alertWithTitle:@"手机号格式不正确" content:nil ok:nil];
        return;
    }
    
    [self setVerifyState:NO];
    
    [CloudBL GetRegisterVerityCode_Phone:_loginNameTextField.text success:^{
        
    } failure:^(NSString *errorMessage) {
        [self setVerifyState:YES];
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

#pragma mark - 提交注册

-(void)reg{
    
    if ([_loginNameTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入手机号" content:nil ok:nil];
        return;
    }
    
    if ([_verifyCodeTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入验证码" content:nil ok:nil];
        return;
    }
    
    if ([_passwordTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入密码" content:nil ok:nil];
        return;
    }
    
    NSString *regexString = @"^1[0-9]{10}$";
    
    NSPredicate *regex1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    
    if(![regex1 evaluateWithObject:_loginNameTextField.text]){
        [self alertWithTitle:@"手机号格式不正确" content:@"手机号应为11位数字" ok:nil];
        return;
    }
    
    regexString = @"^[0-9]{6}$";
    
    NSPredicate *regex2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    
    if(![regex2 evaluateWithObject:_verifyCodeTextField.text]){
        [self alertWithTitle:@"验证码格式不正确" content:@"验证码应为6位数字" ok:nil];
        return;
    }
    
    regexString = @"^[\\S]{6,16}$";
    
    NSPredicate *regex3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    
    if(![regex3 evaluateWithObject:_passwordTextField.text]){
        [self alertWithTitle:@"密码格式不正确" content:@"密码应为6-16个字符，不能包含空格" ok:nil];
        return;
    }
    
    //调用验证接口
    [CloudBL VerityRegisterCode_Phone:_loginNameTextField.text Code:_verifyCodeTextField.text success:^(BOOL VerityisSuccess) {
        [self setVerifyState:YES];
        if (!VerityisSuccess) {
            [self alertWithTitle:@"验证失败" content:@"请检查输入的验证码是否正确" ok:nil];
        }else{
            //调用注册接口
            [CloudBL RegisterUser_Phone:_loginNameTextField.text Code:_verifyCodeTextField.text Password:_passwordTextField.text success:^(NSString *iDentity, Token *token) {
                [self setVerifyState:YES];
                [Utils_UserDefaultInfo SetUserIdentifer:iDentity];
                [Utils_UserDefaultInfo SetUserAccessKey:token.accessToken];
                [Utils_UserDefaultInfo SetUserRefreshToken:token.refreshToken];
                
                UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"main"];
                [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
                
            } failure:^(NSString *errorMessage) {
                [self setVerifyState:YES];
                [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
            }];
        }
        
    } failure:^(NSString *errorMessage) {
        [self setVerifyState:YES];
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
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
