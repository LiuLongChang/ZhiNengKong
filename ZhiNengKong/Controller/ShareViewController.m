//
//  ShareViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ShareViewController.h"
#import "Utils_UserDefaultInfo.h"
#import "CloudBL.h"
#import "Equip.h"
#import "SharedUserViewController.h"

@interface ShareViewController ()
{
    NSArray *_equips;
    NSMutableDictionary *_equipUsersDic;
    NSString *_selectedEqID;
    NSMutableDictionary *_usersDic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
}

-(void)loadData{
    _equips = [NSArray array];
    _equipUsersDic = [NSMutableDictionary dictionary];
    _usersDic = [NSMutableDictionary dictionary];
    NSString *un = [Utils_UserDefaultInfo GetUserIdentifer:nil];
    NSString *token = [Utils_UserDefaultInfo GetUserAccessKey:nil];
    [CloudBL MyEquips_UN:un AccessToken:token TS:nil success:^(NSNumber *TS, NSArray *Equips) {
        _equips = Equips;
        [CloudBL UserSharings_UN:un AccessToken:token EqIDs:nil success:^(NSArray *Equips, NSArray *Users){
                
            for (NSDictionary *dic in Equips) {
                NSString *eqID = dic[@"EqId"];
                NSArray *users = dic[@"Users"];
                _equipUsersDic[eqID] = [NSMutableArray arrayWithArray:users];
            }
            
            for (NSDictionary *dic in Users) {
                NSString *uid = [NSString stringWithFormat:@"%d",[dic[@"UserID"] intValue]];
                _usersDic[uid] = dic;
            }
            
            [_tableView reloadData];
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    } failure:^(NSString *errorMessage) {
       [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    if (indexPath) {
        [_tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
    
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView代理

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    Equip *equip = [Equip modelObjectWithDictionary:_equips[indexPath.row]];
    UIImage *image = [UIImage imageNamed:@"mysheb_icon_1"];
    if (![equip.equipAvatar isEqualToString:@""] && equip.equipAvatar != nil) {
        
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:equip.equipAvatar]]];
        [Utils_UserDefaultInfo SetAvatarWithUrl:equip.equipAvatar image:image];
    }
    
    cell.imageView.image = image;
    cell.textLabel.text = equip.equipName;
    cell.textLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    NSArray *userArr = _equipUsersDic[equip.eqID];
    
    if (userArr!=nil) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)userArr.count];
    }else{
        cell.detailTextLabel.text = @"0";
    }
    
    [self setCellStyle:cell withHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath] forTableView:tableView];
    
    [self setCellAccessory:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Equip *equip = [Equip modelObjectWithDictionary:_equips[indexPath.row]];
    
    NSMutableArray *userArr = _equipUsersDic[equip.eqID];
    
    if (userArr!=nil) {
        _selectedEqID = equip.eqID;
        [self performSegueWithIdentifier:@"users" sender:self];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _equips.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SharedUserViewController *vc = segue.destinationViewController;
    vc.eqID = _selectedEqID;
    vc.users = _equipUsersDic[_selectedEqID];
    vc.usersDic = _usersDic;
}

@end
