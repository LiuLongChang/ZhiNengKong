//
//  EditProfileViewController.h
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol EditProfileViewControllerDelegate <NSObject>

-(void)saveTextWithTitle:(NSString *)title text:(NSString *)text;

@end

@interface EditProfileViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet NSString *fieldName;
@property (strong, nonatomic) IBOutlet NSString *editText;
@property (weak,nonatomic) id<EditProfileViewControllerDelegate> delegate;
@end
