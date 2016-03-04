//
//  ForgetPwdViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "CloudBL.h"
#import "ForgetPwd2ViewController.h"
@interface ForgetPwdViewController ()
{
    BOOL _isVerify;
    NSTimer *_verifyTimer;
    int _verifySeconds;
}
@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginNameTextField.delegate = self;
    _verifyCodeTextField.delegate = self;
    
    [super setClearButtonForTextField:_loginNameTextField];
    [super setClearButtonForTextField:_verifyCodeTextField];
    
    [super setRadiusForButton:_verifyButton];
    
    [super setRadiusForButton:_submitButton];
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
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [textField.text mutableCopy];
    
    if (string.length == 0) {
        return YES;
    }
    
    if (textField == _loginNameTextField) {
        return [text length] <= 10;
    }
    
    if (textField == _verifyCodeTextField) {
        return [text length] <= 5;
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
        [self submit];
    }
    
    return YES;
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
    
    [CloudBL VerifyReset_Phone:_loginNameTextField.text success:^{
        
    } failure:^(NSString *errorMessage) {
        [self setVerifyState:YES];
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];

}

- (IBAction)verifyCodeButtonClick:(id)sender {
    [self getVerifyCode];
}
- (IBAction)agreementButtonClick:(id)sender {
    
}
- (IBAction)submitButtonClick:(id)sender {
    [self submit];
}

-(void)submit{
    if ([_loginNameTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入手机号" content:nil ok:nil];
        return;
    }
    
    if ([_verifyCodeTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入验证码" content:nil ok:nil];
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
    
    [CloudBL VerifyResetCode_Phone:_loginNameTextField.text Code:_verifyCodeTextField.text success:^{
        [self setVerifyState:YES];
        [self performSegueWithIdentifier:@"forget2" sender:self];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ForgetPwd2ViewController *vc = segue.destinationViewController;
    vc.phone = _loginNameTextField.text;
    vc.code = _verifyCodeTextField.text;
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
