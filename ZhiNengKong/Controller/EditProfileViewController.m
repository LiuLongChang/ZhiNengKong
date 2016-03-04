//
//  EditProfileViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EditProfileViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "BaseNavigationViewController.h"

@interface EditProfileViewController ()


@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *buttonColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] init];
    [leftButton setTitle:@"取消"];
    [leftButton setTintColor:buttonColor];
    leftButton.target = self;
    leftButton.action = @selector(cancel);
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    [rightButton setTitle:@"保存"];
    [rightButton setTintColor:buttonColor];
    rightButton.target = self;
    rightButton.action = @selector(save);
    
    self.textField.text = self.editText;
    self.textField.delegate = self;
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap];
    [self setClearButtonForTextField:_textField];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [textField.text mutableCopy];
    
    if (string.length == 0) {
        return YES;
    }
    
    if ([_fieldName isEqualToString:@"UserName"]) {
        return [text length] <= 31;
    }
    
    return YES;
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_textField resignFirstResponder];
}


-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save{
    
    [_textField resignFirstResponder];
    
    if ([_textField.text isEqualToString:@""]) {
        [self alertWithTitle:[NSString stringWithFormat:@"请输入%@",self.title] content:nil ok:nil];
        return;
    }
    
    if ([_fieldName isEqualToString:@"UserName"]) {
        NSString *regexString = @"^[\\s\\S]{0,32}$";
        
        NSPredicate *regex1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexString];
        
        if(![regex1 evaluateWithObject:_textField.text]){
            [self alertWithTitle:@"昵称格式不正确" content:@"最长可设定16个字（32个字母）" ok:nil];
            return;
        }
    }
    
    NSArray *jsonArray = @[@{@"Field":_fieldName,@"Value":_textField.text}];
    
    [CloudBL SetUserInfo_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] Changes:jsonArray success:^(int IsSuccess, NSArray *Errors) {
        if (self.delegate) {
            [self.delegate saveTextWithTitle:self.title text:self.textField.text];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *errorMessage) {
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
