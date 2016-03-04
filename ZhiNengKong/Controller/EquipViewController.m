//
//  EquipViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/29.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "AddEquipButton.h"
#import "EquipTableViewCell.h"
#import "MyInvitationModel.h"
#import "Equip.h"
#import "ShareConfirmView.h"
#import "ShareEquipViewController.h"
#import "MGSwipeButton.h"
#import "EquipMesssageViewController.h"

@interface EquipViewController ()
{
    NSArray *_equips;
    NSArray *_invitations;
    UIView *_confirmView;
    ShareConfirmView *_confirmSubView;
    Equip *_selectedEquip;
}
@property (weak, nonatomic) IBOutlet AddEquipButton *addEquipButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation
EquipViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _addEquipButton.hidden = YES;
    _tableView.hidden = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:242.0/255.0 alpha:1.0];
    [_tableView registerNib:[UINib nibWithNibName:@"EquipTableViewCell" bundle:nil] forCellReuseIdentifier:@"EquipTableViewCell"];
    
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_sharedPerson != nil) {
        
        ShareConfirmView *subView = [[[NSBundle mainBundle] loadNibNamed:@"ShareConfirmView" owner:self options:nil] lastObject];
        subView.headImageView.image = _sharedPerson.image;
        subView.nameLabel.text = [NSString stringWithFormat:@"%@%@",_sharedPerson.lastNames,_sharedPerson.firstNames];
        subView.phoneLabel.text = _sharedPerson.numbers[0];
        [subView.textField addTarget:self action:@selector(offsetConfirmWindow) forControlEvents:UIControlEventEditingDidBegin];
        [subView.textField addTarget:self action:@selector(originConfirmWindow) forControlEvents:UIControlEventEditingDidEnd];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.firstLineHeadIndent = 10.0;
        
        subView.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"给朋友留言" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
        
        _confirmView = [self confirmWithTitle:@"确定分享给：" content:@"" subView:subView ok:^(id sender){
            [self shareToPerson];
        } cancel:^(id sender){
            _sharedPerson = nil;
        }];
        _confirmSubView = subView;
        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *maskView = [mainWindow viewWithTag:2015];
        maskView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
        
        [maskView addGestureRecognizer:singleTap];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"share" isEqualToString:segue.identifier]) {
        ShareEquipViewController *vc = segue.destinationViewController;
        vc.selectedEqid = _selectedEqid;
    }
    
    if ([@"message" isEqualToString:segue.identifier]) {
        EquipMesssageViewController *vc = segue.destinationViewController;
        vc.equip = _selectedEquip;
    }
}

-(void)shareToPerson{
    
    NSString *message = _confirmSubView.textField.text;
    if (message == nil || [@"" isEqualToString:message]) {
        message = @"邀请你加入";
    }
    
    NSString *phoneNumber = _sharedPerson.numbers[0];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    [CloudBL ShareEq_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:_selectedEqid FriendPhone:_sharedPerson.numbers[0] Message:message success:^{
        [self alertWithTitle:@"分享成功" content:@"分享成功，等待对方验证" ok:nil];
        _sharedPerson = nil;
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        _sharedPerson = nil;
    }];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    if (_confirmView!=nil) {
        [_confirmView endEditing:YES];
    }
}

-(void)offsetConfirmWindow{
    _confirmView.frame = CGRectOffset(_confirmView.frame, 0, -100.0f);
}

-(void)originConfirmWindow{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    _confirmView.frame = CGRectMake((mainWindow.frame.size.width - _confirmView.frame.size.width)/2.0f, (mainWindow.frame.size.height - _confirmView.frame.size.height)/2.0f, _confirmView.frame.size.width, _confirmView.frame.size.height);
}

-(void)loadData{
    
    [CloudBL MyEquips_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] TS:nil success:^(NSNumber *TS, NSArray *Equips) {
        
        if (Equips!=nil) {
            _equips = Equips;
        }else{
            _equips = [NSArray array];
        }
        
        [CloudBL MyInvitation_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSArray *returnValue) {
            if (returnValue!=nil) {
                _invitations = returnValue;
            }else{
                _invitations = [NSArray array];
            }
            
            for (NSDictionary *dic in _invitations) {
                MyInvitationModel *model = [MyInvitationModel modelObjectWithDictionary:dic];
                UIImage *avatarImage = [Utils_UserDefaultInfo GetAvatarWithUrl:model.equipAvatar image:nil];
                
                if (avatarImage == nil) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.equipAvatar]]];
                    [Utils_UserDefaultInfo SetAvatarWithUrl:model.equipAvatar image:image];
                }
            }
            
            if (Equips.count != 0 || _invitations.count !=0) {
                if (_addEquipButton) {
                    [_addEquipButton removeFromSuperview];
                }
                
                UIImage *image = [UIImage imageNamed:@"mysheb_icon_6"];
                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
                rightButton.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
                [rightButton setImage:image forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(addEquip) forControlEvents:UIControlEventTouchUpInside];
                
                UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
                self.navigationItem.rightBarButtonItem = item;
                
                [self createTableView];
                [_tableView reloadData];
            }else{
                self.navigationItem.rightBarButtonItem = nil;
                if (_tableView) {
                    [_tableView removeFromSuperview];
                }
                
                [self createInitView];
            }
            
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)createTableView{
    _addEquipButton.hidden = YES;
    _tableView.hidden = NO;
    _addEquipButton.radius = 50.0f;
}

-(void)createInitView{
    _tableView.hidden = YES;
    _addEquipButton.hidden = NO;
//    _addEquipButton.layer.cornerRadius = 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? _equips.count : _invitations.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _selectedEquip =[Equip modelObjectWithDictionary:_equips[indexPath.row]];
    }
    [self performSegueWithIdentifier:@"message" sender:self];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EquipTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"EquipTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        cell.cellType = EquipTableViewCellTypeInvitation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MyInvitationModel *model =[MyInvitationModel modelObjectWithDictionary:_invitations[indexPath.row]];
        cell.equipNameLabel.text = model.equipName;
        if (model.equipAvatar !=nil && ![@"" isEqualToString:model.equipAvatar]) {
            
           UIImage *image = [Utils_UserDefaultInfo GetAvatarWithUrl:model.equipAvatar image:nil];
            if (image == nil) {
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.equipAvatar]]];
                [Utils_UserDefaultInfo SetAvatarWithUrl:model.equipAvatar image:image];
            }
            
            cell.avatarImageView.image = image;
        }else{
            cell.avatarImageView.image = [UIImage imageNamed:@"mysheb_icon_1"];
        }
        
        cell.messageLabel.text = @"邀请你加入";
        [cell.acceptButton addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
        [cell.refuseButton addTarget:self action:@selector(refuse:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        Equip *model =[Equip modelObjectWithDictionary:_equips[indexPath.row]];
        cell.equipNameLabel.text = model.equipName;
        cell.delegate = self;
        cell.allowsMultipleSwipe = YES;
        if ([model.isOwner intValue] == 1) {
            cell.cellType = EquipTableViewCellTypeNormal;
        }else{
            cell.cellType = EquipTableViewCellTypeShared;
            cell.avatarImageView.image = [UIImage imageNamed:@"mysheb_icon_1"];
            UIImageView *shareIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mysheb_icon_4"]];
            CGRect rect = cell.avatarImageView.frame;
            shareIconView.frame = CGRectMake(rect.origin.x + rect.size.width - 10.0f, rect.origin.y - 5.0f, 19.0f, 19.0f);
            [cell.contentView addSubview:shareIconView];
        }
        [cell.shareButton addTarget:self action:@selector(shareEquip:) forControlEvents:UIControlEventTouchUpInside];
        cell.shareButton.tag = indexPath.row;
        cell.shareButton.hidden = YES;
        cell.messageLabel.text = @"";
        
        cell.rightButtons = [self createRightButtons:indexPath.row];
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(detail:)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    //Don't forget to set the userInteractionEnabled to YES, by default It's NO.
    cell.avatarImageView.userInteractionEnabled = YES;
    [cell.avatarImageView addGestureRecognizer:tapRecognizer];
    
    return cell;
}

-(void)detail:(id) sender
{
    [self performSegueWithIdentifier:@"detail" sender:self];
}

-(void)accept:(UIButton *)button{
    InvitationResponseModel *invite = [InvitationResponseModel modelObjectWithDictionary:_invitations[button.tag]];
    [CloudBL InvitationResponse_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] ShareID:invite.shareID IsApproved:[NSNumber numberWithInt:1] success:^(NSString *FromUser, NSString *EqID, NSString *EquipName, NSString *EquipAlias, NSString *EquipAvatar, LastMessage *LastMessage) {
        [self alertWithTitle:@"添加成功" content:@"" ok:nil];
        [self loadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)refuse:(UIButton *)button{
    InvitationResponseModel *invite = [InvitationResponseModel modelObjectWithDictionary:_invitations[button.tag]];
                                       [CloudBL InvitationResponse_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] ShareID:invite.shareID IsApproved:[NSNumber numberWithInt:0] success:^(NSString *FromUser, NSString *EqID, NSString *EquipName, NSString *EquipAlias, NSString *EquipAvatar, LastMessage *LastMessage) {
        [self loadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(NSArray *) createRightButtons: (long) number
{
    Equip *equip = [Equip modelObjectWithDictionary:_equips[number]];
    NSMutableArray * result = [NSMutableArray array];
    MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * sender){
        
        if ([equip.isOwner isEqualToNumber:[NSNumber numberWithInt:1]]) {
            NSString *message = @"删除设备后，再次使用将恢复出厂设置，且被分享者也将会被停止使用该设备。";
            UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 40.0f)];
            passwordTextField.secureTextEntry = YES;
            passwordTextField.layer.cornerRadius = 10.0f;
            passwordTextField.layer.borderColor = [UIColor colorWithRed:123.0/255.0 green:172.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor;
            passwordTextField.layer.borderWidth = 1.0f;
            
            passwordTextField.layer.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:243.0/255.0 blue:249.0/255.0 alpha:1.0].CGColor;
            [passwordTextField addTarget:self action:@selector(offsetConfirmWindow) forControlEvents:UIControlEventEditingDidBegin];
            [passwordTextField addTarget:self action:@selector(originConfirmWindow) forControlEvents:UIControlEventEditingDidEnd];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.firstLineHeadIndent = 10.0;
            
            UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
            passwordTextField.leftView = paddingView;
            passwordTextField.leftViewMode = UITextFieldViewModeAlways;
            
            
            passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
            
            _confirmView = [self confirmWithTitle:@"确定删除该设备？" content:message subView:passwordTextField ok:^(id sender){
                [CloudBL DelEq_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:equip.eqID Password:passwordTextField.text success:^{
                    [self alertWithTitle:@"删除成功" content:@"" ok:nil];
                    [self loadData];
                } failure:^(NSString *errorMessage) {
                    [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
                }];
            } cancel:nil];
        }else{
            NSString *message = @"删除设备将放弃使用";
            [self confirmWithTitle:@"确定删除该设备？" content:message ok:^(id sender){
                [CloudBL DelEq_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:equip.eqID Password:@"" success:^{
                    [self alertWithTitle:@"删除成功" content:@"" ok:nil];
                    [self loadData];
                } failure:^(NSString *errorMessage) {
                    [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
                }];
            } cancel:nil];
        }
        return YES;
    }];
    CGRect rect = button.frame;
    button.frame = CGRectMake(rect.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
    [result addObject:button];
    return result;
}
-(void)shareEquip:(UIButton *)sender{
    Equip *selectedEquip = [Equip modelObjectWithDictionary:_equips[sender.tag]];
    _selectedEqid = selectedEquip.eqID;
    [self performSegueWithIdentifier:@"share" sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
- (IBAction)addEquip:(id)sender {
    [self addEquip];
}

-(void)addEquip{
    [self performSegueWithIdentifier:@"new" sender:self];
}

@end
