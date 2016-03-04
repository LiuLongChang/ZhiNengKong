//
//  BaseViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/22.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationViewController.h"
#import "MainTabViewController.h"

@interface BaseViewController ()
{
    ALERT_VIEW_BLOCK _okBlock;
    ALERT_VIEW_BLOCK _cancelBlock;
    UIView *_maskView;
}
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    
    if ([self.navigationController isKindOfClass:[BaseNavigationViewController class]]) {
        BaseNavigationViewController *navVC = (BaseNavigationViewController*)self.navigationController;
        [navVC changeState:self];
    }
    
    NSArray *needHiddenViews = @[@"EquipMesssageViewController",
                                 @"EquipDetailViewController",
                                 @"EquipFeedbackViewController",
                                 @"EquipEditViewController",
                                 @"FeedbackPreviewViewController",
                                 @"FriendsViewController",
                                 @"AddFriendViewController",
                                 @"CircleInfoViewController",
                                 @"PickEquipViewController",
                                 @"PickMemberViewController",
                                 @"CircleMessageViewController",
                                 @"CircleViewController"];
    
    if (self.tabBarController) {
        MainTabViewController *tabVC = (MainTabViewController *)self.tabBarController;
        NSString *myClassString = NSStringFromClass([self class]);
        if ([needHiddenViews containsObject:myClassString]) {
            [tabVC setTabBarHidden:YES];
        }else{
            [tabVC setTabBarHidden:NO];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self.navigationController isKindOfClass:[BaseNavigationViewController class]]) {
        BaseNavigationViewController *navVC = (BaseNavigationViewController*)self.navigationController;
        [navVC changeState:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
}

-(void)setClearButtonForTextField:(UITextField *)textField{
    UIButton *clearButton = [textField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"denglu2_icon3"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"denglu2_icon3"] forState:UIControlStateHighlighted];
}

-(void)setRadiusForButton:(UIButton *)button{
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCellAccessory:(UITableViewCell *)cell{
    NSString *myClassString = NSStringFromClass([self class]);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[myClassString isEqualToString:@"EquipDetailViewController"]?@"my3_arrowright":@"sheb_arrow_right"]];
    imageView.backgroundColor = [UIColor clearColor];
    cell.accessoryView = imageView;
}

-(void)setCellStyle:(UITableViewCell *)cell withHeight:(CGFloat)height forTableView:(UITableView *)tableView{
    
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, height - 0.5);
    
    cell.detailTextLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:frame];
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:243.0/255.0 blue:249.0/255.0 alpha:1.0];
    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.backgroundView = backgroundView;
}

-(id)alertWithTitle:(NSString *)title content:(NSString *)content ok:(ALERT_VIEW_BLOCK)ok{
    _okBlock = ok;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    CGFloat contentInsetX = 30.0f;
    CGFloat contentInsetTop = 70.0f;
    CGFloat contentInsetBottom = 15.0f;
    CGFloat buttonBottomInset = 20.0f;
    CGFloat buttonHeight = 30.0f;
    CGFloat buttonWidth = 100.0f;
    CGRect contentRect = CGRectMake(0, contentInsetTop, 0, 0);
    
    
    CGFloat alertInsetX = 20.0f;
    
    CGFloat alertWidth = mainWindow.frame.size.width - (alertInsetX * 2);
    
    CGSize contentSize = CGSizeMake(0.0f, 0.0f);
    
    if (![content isEqualToString:@""] && content !=nil) {
        contentSize = [content boundingRectWithSize:CGSizeMake(alertWidth - (contentInsetX * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    }
    
    CGFloat alertHeight = contentRect.size.height + contentSize.height + contentInsetTop + contentInsetBottom + buttonHeight + buttonBottomInset;
    
    CGRect alertRect = CGRectMake(alertInsetX, (mainWindow.frame.size.height - alertHeight)/2, alertWidth, alertHeight);
    
    
    CGRect okButtonRect = CGRectMake((alertWidth-buttonWidth)/2, alertHeight - (buttonHeight + buttonBottomInset), buttonWidth, buttonHeight);
    
    CGFloat titleUnderLineWidth = 0.5f;
    CGFloat titleInest = 20.0f;
    UIFont *titleFont = [UIFont systemFontOfSize:20.0f];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    CGRect titleRect = CGRectMake((alertWidth - titleSize.width)/2, titleInest, titleSize.width, titleSize.height + titleUnderLineWidth);
    
    UIView *titleView = [[UIView alloc] initWithFrame:titleRect];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleRect.size.width, titleRect.size.height - titleUnderLineWidth)];
    titleLabel.text = title;
    titleLabel.font = titleFont;
    UIView *titleUnderLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleSize.height, titleRect.size.width, titleUnderLineWidth)];
    titleUnderLineView.backgroundColor = [UIColor blackColor];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleUnderLineView];
    
    UILabel *contentView = nil;
    
    if (![content isEqualToString:@""] && content != nil) {
        
        contentView = [[UILabel alloc] initWithFrame:CGRectMake(contentInsetX, contentInsetTop, alertWidth - (contentInsetX * 2), contentSize.height)];
        contentView.font = [UIFont systemFontOfSize:13.0f];
        contentView.textColor = [UIColor colorWithRed:112.0/255.0 green:125.0/255.0 blue:142.0/255.0 alpha:1.0];
        contentView.numberOfLines = 0;
        contentView.text = content;
        contentView.textAlignment = NSTextAlignmentCenter;
    }
    
    UIColor *buttonColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:okButtonRect];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 10.0f;
    okButton.layer.borderWidth = 1.0f;
    okButton.layer.borderColor = buttonColor.CGColor;
    [okButton setBackgroundColor:buttonColor];
    [okButton addTarget:self action:@selector(alertViewOK:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *alertView = [[UIView alloc] initWithFrame:alertRect];
    alertView.backgroundColor = [UIColor whiteColor];
    
    [alertView addSubview:titleView];
    [alertView addSubview:contentView];
    [alertView addSubview:okButton];
    
    return [self showPopView:alertView];
}

-(id)confirmWithTitle:(NSString *)title content:(NSString *)content subView:(UIView *)subView ok:(ALERT_VIEW_BLOCK)ok cancel:(ALERT_VIEW_BLOCK)cancel{
    UIView *confirmView = [self confirmWithTitle:title content:content ok:ok cancel:cancel];
    
    CGFloat contentInsetY = 15.0f;
    CGFloat newContentHeight = confirmView.frame.size.height + subView.frame.size.height + contentInsetY;
    
    CGRect newRect = CGRectMake(confirmView.frame.origin.x, confirmView.frame.origin.y - ((subView.frame.size.height + contentInsetY) / 2.0f), confirmView.frame.size.width, newContentHeight);
    
    confirmView.frame = newRect;
    
    [confirmView addSubview:subView];
    
    CGFloat contentInsetX = 30.0f;
    UIView *okButton = [confirmView viewWithTag:2001];
    UIView *cancelButton = [confirmView viewWithTag:2002];
    CGRect subViewRect = CGRectMake(contentInsetX, okButton.frame.origin.y, newRect.size.width - (contentInsetX * 2), subView.frame.size.height);
    
    CGRect newOKRect = CGRectOffset(okButton.frame, 0, subView.frame.size.height + contentInsetY);
    CGRect newCancelRect = CGRectOffset(cancelButton.frame, 0, subView.frame.size.height + contentInsetY);
    okButton.frame = newOKRect;
    cancelButton.frame = newCancelRect;
    
    subView.frame = subViewRect;
    
    return [self showPopView:confirmView];
}

-(id)confirmWithTitle:(NSString *)title content:(NSString *)content ok:(ALERT_VIEW_BLOCK)ok cancel:(ALERT_VIEW_BLOCK)cancel{
    _okBlock = ok;
    _cancelBlock = cancel;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    CGFloat contentInsetX = 30.0f;
    CGFloat contentInsetTop = 70.0f;
    CGFloat contentInsetBottom = 15.0f;
    CGFloat buttonBottomInset = 20.0f;
    CGFloat buttonHeight = 30.0f;
    CGFloat buttonWidth = 100.0f;
    CGFloat buttonSpacing = 20.0f;
    CGRect contentRect = CGRectMake(0, contentInsetTop, 0, 0);
    
    
    CGFloat alertInsetX = 20.0f;
    
    CGFloat alertWidth = mainWindow.frame.size.width - (alertInsetX * 2);
    
    CGSize contentSize = CGSizeMake(0.0f, 0.0f);
    
    if (![content isEqualToString:@""] && content !=nil) {
        contentSize = [content boundingRectWithSize:CGSizeMake(alertWidth - (contentInsetX * 2), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    }else{
        contentSize = CGSizeMake(0, 0);
        contentRect = CGRectMake(0, 0, 0, 0);
        contentInsetBottom = 0;
    }
    
    CGFloat alertHeight = contentRect.size.height + contentSize.height + contentInsetTop + contentInsetBottom + buttonHeight + buttonBottomInset;
    
    CGRect alertRect = CGRectMake(alertInsetX, (mainWindow.frame.size.height - alertHeight)/2, alertWidth, alertHeight);
    
    
    CGRect cancelButtonRect = CGRectMake((alertWidth-(buttonWidth * 2) - buttonSpacing)/2, alertHeight - (buttonHeight + buttonBottomInset), buttonWidth, buttonHeight);
    
    CGRect okButtonRect = CGRectOffset(cancelButtonRect, buttonSpacing + buttonWidth, 0);
    
    CGFloat titleUnderLineWidth = 0.5f;
    CGFloat titleInest = 20.0f;
    UIFont *titleFont = [UIFont systemFontOfSize:20.0f];
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    CGRect titleRect = CGRectMake((alertWidth - titleSize.width)/2, titleInest, titleSize.width, titleSize.height + titleUnderLineWidth);
    
    UIView *titleView = [[UIView alloc] initWithFrame:titleRect];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleRect.size.width, titleRect.size.height - titleUnderLineWidth)];
    titleLabel.text = title;
    titleLabel.font = titleFont;
    UIView *titleUnderLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleSize.height, titleRect.size.width, titleUnderLineWidth)];
    titleUnderLineView.backgroundColor = [UIColor blackColor];
    [titleView addSubview:titleLabel];
    [titleView addSubview:titleUnderLineView];
    
    UILabel *contentView = nil;
    
    if (![content isEqualToString:@""] && content != nil) {
        
        contentView = [[UILabel alloc] initWithFrame:CGRectMake(contentInsetX, contentInsetTop, alertWidth - (contentInsetX * 2), contentSize.height)];
        contentView.font = [UIFont systemFontOfSize:13.0f];
        contentView.textColor = [UIColor colorWithRed:112.0/255.0 green:125.0/255.0 blue:142.0/255.0 alpha:1.0];
        contentView.numberOfLines = 0;
        contentView.text = content;
        contentView.textAlignment = NSTextAlignmentCenter;
    }
    
    UIColor *buttonColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:okButtonRect];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 10.0f;
    okButton.layer.borderWidth = 1.0f;
    okButton.layer.borderColor = buttonColor.CGColor;
    [okButton setBackgroundColor:buttonColor];
    [okButton addTarget:self action:@selector(alertViewOK:) forControlEvents:UIControlEventTouchUpInside];
    okButton.tag = 2001;
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelButtonRect];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:buttonColor forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 10.0f;
    cancelButton.layer.borderWidth = 1.0f;
    cancelButton.layer.borderColor = buttonColor.CGColor;
    [cancelButton setBackgroundColor:[UIColor whiteColor]];
    [cancelButton addTarget:self action:@selector(alertViewCancel:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 2002;
    
    UIView *alertView = [[UIView alloc] initWithFrame:alertRect];
    alertView.backgroundColor = [UIColor whiteColor];
    
    [alertView addSubview:titleView];
    [alertView addSubview:contentView];
    [alertView addSubview:okButton];
    [alertView addSubview:cancelButton];
    
    return [self showPopView:alertView];
}

-(id)showPopView:(UIView *)popView{
    
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:mainWindow.frame];
        _maskView.tag = 2015;
    }
    
    UIView *maskView = _maskView;
    
    maskView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5f];
    [maskView addSubview:popView];
    _maskView = maskView;
    
    [mainWindow addSubview:_maskView];
    return popView;
}

-(void)alertViewOK:(id)sender{
    [_maskView removeFromSuperview];
    
    if (_okBlock) {
        _okBlock(sender);
    }
}

-(void)alertViewCancel:(id)sender{
    [_maskView removeFromSuperview];
    if (_cancelBlock) {
        _cancelBlock(sender);
    }
}

- (void)hideTabBar {
    if (self.navigationController.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)showTabBar

{
    if (self.navigationController.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
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
