//
//  ForgetPwd2ViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPwd2ViewController : BaseViewController<UITextFieldDelegate>
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *code;
@end
