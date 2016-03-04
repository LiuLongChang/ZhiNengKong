//
//  ForgetPwd2ViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ForgetPwd2ViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "Token.h"

@interface ForgetPwd2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *password2TextField;
@end

@implementation ForgetPwd2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _passwordTextField.delegate = self;
    _password2TextField.delegate = self;
    
    [super setClearButtonForTextField:_passwordTextField];
    [super setClearButtonForTextField:_password2TextField];
    [super setRadiusForButton:_submitButton];
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [textField.text mutableCopy];
    
    if (textField == _passwordTextField) {
        return [text length] <= 15;
    }
    
    if (textField == _password2TextField) {
        return [text length] <= 15;
    }
    
    return YES;
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_passwordTextField resignFirstResponder];
    [_password2TextField resignFirstResponder];
}

#pragma mark - 键盘回车事件

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField == _passwordTextField) {
        [_password2TextField becomeFirstResponder];
    }
    
    if (textField == _password2TextField) {
        [self submit];
    }
    
    return YES;
}

-(void)submit{
    if ([_passwordTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入密码" content:nil ok:nil];
        return;
    }
    
    if ([_password2TextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入确认密码" content:nil ok:nil];
        return;
    }
    
    NSString *regexString = @"^[\\S]{6,16}$";
    
    NSPredicate *regex3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
    
    if(![regex3 evaluateWithObject:_passwordTextField.text]){
        [self alertWithTitle:@"密码格式不正确" content:@"密码应为6-16个字符，不能包含空格" ok:nil];
        return;
    }
    
    if(![_passwordTextField.text isEqualToString:_password2TextField.text]){
        [self alertWithTitle:@"两次输入的密码不一致" content:@"请检查后重新输入" ok:nil];
        return;
    }
    
    [CloudBL ResetCode_Phone:_phone Code:_code Password:_passwordTextField.text success:^(NSString *HGUID, Token *token) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}


- (IBAction)submitButtonClick:(id)sender {
    [self submit];
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
