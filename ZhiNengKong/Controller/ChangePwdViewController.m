//
//  ChangePwdViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"

@interface ChangePwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *password2TextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _oldPasswordTextField.delegate = self;
    _passwordTextField.delegate = self;
    _password2TextField.delegate = self;
    [super setClearButtonForTextField:_oldPasswordTextField];
    [super setClearButtonForTextField:_passwordTextField];
    [super setClearButtonForTextField:_password2TextField];
    [super setRadiusForButton:_submitButton];
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [textField.text mutableCopy];
    
    if (textField == _oldPasswordTextField) {
        return [text length] <= 16;
    }
    
    if (textField == _passwordTextField) {
        return [text length] <= 16;
    }
    
    if (textField == _password2TextField) {
        return [text length] <= 16;
    }
    
    return YES;
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_oldPasswordTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_password2TextField resignFirstResponder];
}

#pragma mark - 键盘回车事件

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (textField == _oldPasswordTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    
    if (textField == _passwordTextField) {
        [_password2TextField becomeFirstResponder];
    }
    
    if (textField == _password2TextField) {
        [self submit];
    }
    
    return YES;
}

-(void)submit{
    
    if ([_oldPasswordTextField.text isEqualToString:@""]) {
        [self alertWithTitle:@"请输入密码" content:nil ok:nil];
        return;
    }
    
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
    
    [CloudBL ChangePassword_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] OldPassword:_oldPasswordTextField.text NewPassword:_passwordTextField.text success:^(NSString *HGUID, Token *token) {
//        [Utils_UserDefaultInfo SetUserIdentifer:HGUID];
//        [Utils_UserDefaultInfo SetUserAccessKey:token.accessToken];
//        [Utils_UserDefaultInfo SetUserRefreshToken:token.refreshToken];
        [_oldPasswordTextField resignFirstResponder];
        [_passwordTextField resignFirstResponder];
        [_password2TextField resignFirstResponder];
        [self alertWithTitle:@"修改成功" content:@"修改密码后需要重新登录" ok:^(id sender){
            [Utils_UserDefaultInfo SetUserIdentifer:nil];
            [Utils_UserDefaultInfo SetUserAccessKey:nil];
            [Utils_UserDefaultInfo SetUserRefreshToken:nil];
            
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"login"];
            [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
        }];
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
