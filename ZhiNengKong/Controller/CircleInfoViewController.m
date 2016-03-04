//
//  CircleInfoViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CircleInfoViewController.h"
#import "CircleInfoContentView.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "Equip.h"
#import "GetFriendsListModel.h"
#import "PickEquipViewController.h"
#import "PickMemberViewController.h"
#import "ImageCollectionViewCell.h"

@interface CircleInfoViewController ()
{
    //设备列表
    NSMutableArray *_equips;
    
    //成员列表
    NSMutableArray *_members;
    
    //ScrollView内容视图
    CircleInfoContentView *_contentView;
    
    //编辑设备圈名
    UITextField *_circleNameEditTextField;
    
    UIView *_confirmView;
    
    BOOL _isEditingEquip;
    BOOL _isEditingMember;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CircleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _equips = [NSMutableArray array];
    _members = [NSMutableArray array];
    _isEditingEquip = NO;
    _isEditingMember = NO;
    [self initContentView];
    [self resizeCollectionView];
    _contentView.circleNameTextField.delegate = self;
    
    if (_isCreator) {
        [self createSaveButton];
    }
    
    [self loadData];
}

-(void)loadData{
    _equips = [NSMutableArray array];
    _members = [NSMutableArray array];
    
    if (_circleId != nil && _circleName !=nil) {
        _contentView.circleNameTextField.text = _circleName;
        [CloudBL GetCircleDetail_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circleId success:^(NSArray *EqInfo, NSArray *UserInfo) {
            
            for (NSDictionary *dic in EqInfo) {
                EqInfoModel *equipInfo = [EqInfoModel modelObjectWithDictionary:dic];
                Equip *equip = [[Equip alloc] init];
                equip.eqID = equipInfo.uniCode;
                equip.equipName = equipInfo.eqName;
                equip.equipAvatar = equipInfo.eqAvatar;
                
                UIImage *img = [UIImage imageNamed:@"mysheb_icon_1"];
                
                if (![@"" isEqualToString:equip.equipAvatar] && equip.equipAvatar!=nil) {
                    
                    img = [Utils_UserDefaultInfo GetAvatarWithUrl:equip.equipAvatar image:nil];
                    
                    if (img == nil) {
                        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:equip.equipAvatar]]];
                        [Utils_UserDefaultInfo SetAvatarWithUrl:equip.equipAvatar image:img];
                    }
                }
                
                equip.image = img;
                [_equips addObject:equip];
            }
            
            for (NSDictionary *dic in UserInfo) {
                UserInfoModel *user = [UserInfoModel modelObjectWithDictionary:dic];
                
                GetFriendsListModel *member = [[GetFriendsListModel alloc] init];
                member.fID = user.userID;
                member.phone = user.phone;
                member.avatar = user.avatar;
                member.name = user.nickName;
                
                UIImage *img = [UIImage imageNamed:@"default"];
                
                if (![@"" isEqualToString:user.avatar] && user.avatar!=nil) {
                    img = [Utils_UserDefaultInfo GetAvatarWithUrl:user.avatar image:nil];
                    
                    if (img == nil) {
                        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar]]];
                        [Utils_UserDefaultInfo SetAvatarWithUrl:user.avatar image:img];
                    }
                    
                }
                
                member.image = img;
                [_members addObject:member];
            }
            
            [_contentView.circleCollectionView reloadData];
            [_contentView.memberCollectionView reloadData];
            [self resizeCollectionView];
            
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    }else{
        _isCreator = YES;
        [self createSaveButton];
        [_contentView.circleCollectionView reloadData];
        [_contentView.memberCollectionView reloadData];
        [self resizeCollectionView];
    }
}

-(void)createSaveButton{
    UIColor *buttonColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] init];
    [rightButton setTitle:@"保存"];
    [rightButton setTintColor:buttonColor];
    rightButton.target = self;
    rightButton.action = @selector(save);
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_contentView.circleCollectionView reloadData];
    [_contentView.memberCollectionView reloadData];
    [self resizeCollectionView];
}

-(void)save{
    _isEditingMember = _isEditingEquip = NO;
    [_contentView.memberCollectionView reloadData];
    [_contentView.circleCollectionView reloadData];
    
    NSString *circleName = _contentView.circleNameTextField.text;
    if (circleName == nil || [@"" isEqualToString:circleName]) {
        [self alertWithTitle:@"请输入设备圈名" content:@"" ok:nil];
        return;
    }
    
    NSMutableArray *eqids = [NSMutableArray array];
    NSMutableArray *uids = [NSMutableArray array];
    
    for (Equip *equip in _equips) {
        [eqids addObject:equip.eqID];
    }
    
    for (GetFriendsListModel *member in _members) {
        [uids addObject:member.fID];
    }
    
    if (_circleId !=nil && ![@"" isEqualToString:_circleId]) {
        //编辑
        [CloudBL UpdateCircle_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circleId Name:_contentView.circleNameTextField.text EqIDs:eqids UserIDs:uids success:^(NSNumber *IsSuccess, NSArray *Errors) {
            [self alertWithTitle:@"保存成功" content:@"" ok:nil];
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    }else{
        [CloudBL AddCircle_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] Name:_contentView.circleNameTextField.text EqIDs:eqids UserIDs:uids success:^(NSNumber *IsSuccess, NSArray *Errors) {
            [self alertWithTitle:@"创建成功" content:@"" ok:^(id sender){
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_isCreator) {
        [self editCircleName];
    }
    
    return NO;
}

-(void)editCircleName{
    _circleNameEditTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _circleNameEditTextField.text = _contentView.circleNameTextField.text;
    _circleNameEditTextField.layer.borderColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
    _circleNameEditTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [_circleNameEditTextField addTarget:self action:@selector(offsetConfirmWindow) forControlEvents:UIControlEventEditingDidBegin];
    [_circleNameEditTextField addTarget:self action:@selector(originConfirmWindow) forControlEvents:UIControlEventEditingDidEnd];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent = 10.0;
    
    _circleNameEditTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入设备圈名" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0],NSParagraphStyleAttributeName:paragraphStyle}];
    
    _confirmView = [self confirmWithTitle:@"设备圈名" content:@"" subView:_circleNameEditTextField ok:^(id sender){
        [self changeCircleName];
    } cancel:nil];
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *maskView = [mainWindow viewWithTag:2015];
    maskView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    [maskView addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [_circleNameEditTextField endEditing:YES];
}

-(void)offsetConfirmWindow{
    _confirmView.frame = CGRectOffset(_confirmView.frame, 0, -100.0f);
}

-(void)originConfirmWindow{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    _confirmView.frame = CGRectMake((mainWindow.frame.size.width - _confirmView.frame.size.width)/2.0f, (mainWindow.frame.size.height - _confirmView.frame.size.height)/2.0f, _confirmView.frame.size.width, _confirmView.frame.size.height);
}

-(void)changeCircleName{
    NSString *circleName = _circleNameEditTextField.text;
    if (circleName == nil || [@"" isEqualToString:circleName]) {
        [self alertWithTitle:@"请输入设备圈名" content:@"" ok:nil];
    }else{
        _contentView.circleNameTextField.text = _circleNameEditTextField.text;
    }
}

-(void)resizeCollectionView{
    _contentView.circleHeightConstraint.constant = [_contentView.circleCollectionView.collectionViewLayout collectionViewContentSize].height;
    _contentView.memberHeightConstraint.constant = [_contentView.memberCollectionView.collectionViewLayout collectionViewContentSize].height;
}

-(void)initContentView{
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    _contentView=[[[NSBundle mainBundle] loadNibNamed:@"CircleInfoContentView" owner:self options:nil] objectAtIndex:0];
    
    _contentView.circleCollectionView.dataSource = self;
    _contentView.circleCollectionView.delegate = self;
    
    [_contentView.circleCollectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"equip_cell"];
    
    _contentView.memberCollectionView.dataSource = self;
    _contentView.memberCollectionView.delegate = self;
    
    [_contentView.memberCollectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"member_cell"];
    
    _contentView.circleNameTextField.layer.borderWidth = 1.0f;
    _contentView.circleNameTextField.layer.borderColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
    _contentView.circleNameTextField.textColor = [UIColor colorWithRed:183.0/255.0 green:187.0/255.0 blue:191.0/255.0 alpha:1.0];
    _contentView.circleNameTextField.text = @"设备圈名";
    _contentView.circleNameTextField.font = [UIFont systemFontOfSize:16.0f];
    _contentView.circleNameTextField.backgroundColor = [UIColor whiteColor];
    _contentView.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView addSubview:_contentView];
    _scrollView.contentSize = CGSizeMake(mainWindow.frame.size.width, _contentView.bounds.size.height);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _contentView.circleCollectionView) {
        
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"equip_cell" forIndexPath:indexPath];
        
        if (indexPath.row == _equips.count) {   //倒数第二
            cell.imageView.image = [UIImage imageNamed:@"shebquan_icon5"];
        }else if (indexPath.row == _equips.count + 1) {   //倒数第一
            cell.imageView.image = [UIImage imageNamed:@"shebquan_icon6"];
        }else{
            cell.imageView.userInteractionEnabled = NO;
            Equip *equip = _equips[indexPath.row];
            
            cell.imageView.image = equip.image;
            
            CGSize imageSize = CGSizeMake(50.0,50.0);
            
            UIGraphicsBeginImageContext(imageSize);
            [cell.imageView.image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.imageView.image = _isEditingEquip? [UIImage imageNamed:@"shebquan_icon6"]:newImage;
            cell.imageView.layer.cornerRadius = 25.0f;
            cell.imageView.layer.masksToBounds = YES;
        }
        
        return cell;
    }else{
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"member_cell" forIndexPath:indexPath];
        
        if (indexPath.row == _members.count) {   //倒数第二
            cell.imageView.image = [UIImage imageNamed:@"shebquan_icon5"];
        }else if (indexPath.row == _members.count + 1) {   //倒数第一
            cell.imageView.image = [UIImage imageNamed:@"shebquan_icon6"];
        }else{
            GetFriendsListModel *friend = _members[indexPath.row];
            
            cell.imageView.image = friend.image;
            
            CGSize imageSize = CGSizeMake(50.0,50.0);
            
            UIGraphicsBeginImageContext(imageSize);
            [cell.imageView.image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.imageView.image = _isEditingMember && ![friend.fID isEqualToString:[Utils_UserDefaultInfo GetUserIdentifer:nil]]?[UIImage imageNamed:@"shebquan_icon6"]: newImage;
            cell.imageView.layer.cornerRadius = 25.0f;
            cell.imageView.layer.masksToBounds = YES;
        }
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _contentView.circleCollectionView) {
        if (indexPath.row == _equips.count) {   //倒数第二
            [self pickEquip];
        }else if (indexPath.row == _equips.count + 1) {   //倒数第一
            [self removeEquip];
        }else{
            if (_isEditingEquip) {
                [_equips removeObjectAtIndex:indexPath.row];
                [_contentView.circleCollectionView reloadData];
            }else{
                [self performSegueWithIdentifier:@"detail" sender:self];
            }
        }
    }else{
        if (indexPath.row == _members.count) {   //倒数第二
            [self pickMember];
        }else if (indexPath.row == _members.count + 1) {   //倒数第一
            [self removeMember];
        }else{
            GetFriendsListModel *friend = _members[indexPath.row];
            if (_isEditingMember && ![friend.fID isEqualToString:[Utils_UserDefaultInfo GetUserIdentifer:nil]]) {
                [_members removeObjectAtIndex:indexPath.row];
                [_contentView.memberCollectionView reloadData];
            }
        }
    }
}

-(void)removeEquip{
    _isEditingEquip = !_isEditingEquip;
    [_contentView.circleCollectionView reloadData];
}

-(void)removeMember{
    _isEditingMember = !_isEditingMember;
    [_contentView.memberCollectionView reloadData];
}

-(void)pickEquip{
    _isEditingEquip = NO;
    [self performSegueWithIdentifier:@"equip" sender:self];
}

-(void)pickMember{
    _isEditingMember = NO;
    [self performSegueWithIdentifier:@"member" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"equip" isEqualToString:segue.identifier]) {
        PickEquipViewController *vc = segue.destinationViewController;
        vc.selectedEquips = _equips;
    }
    
    if ([@"member" isEqualToString:segue.identifier]) {
        PickMemberViewController *vc = segue.destinationViewController;
        vc.selectedMembers = _members;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _contentView.circleCollectionView) {
        return _isCreator? _equips.count + 2 : _equips.count;
    }else{
        return _isCreator? _members.count + 2 : _members.count;
    }
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
