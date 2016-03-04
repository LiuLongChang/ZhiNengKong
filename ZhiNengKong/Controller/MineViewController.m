//
//  MineViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "HeadImageTableViewCell.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"HeadImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeadImage"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuItem"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)loadData{
    [CloudBL GetUserInfo_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSString *HGUID, NSString *Phone, NSString *Logo, NSString *UserName) {
        if (Logo!=nil && ![Logo isEqualToString:@""] && ![Logo isEqualToString:[Utils_UserDefaultInfo GetUserLogoUrl:nil]]) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Logo]];
            UIImage *image = [UIImage imageWithData:imageData];
            [Utils_UserDefaultInfo SetUserLogo:image];
            [Utils_UserDefaultInfo SetUserName:UserName];
        }
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

#pragma mark - TableView代理

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //创建头像单元格
        return [self createHeadImageCell:indexPath];
    }else{
        //创建菜单选项单元格
        return [self createMenuItemCellWithIndexPath:indexPath];
    }
}

//创建头像单元格
-(UITableViewCell *)createHeadImageCell:(NSIndexPath *)indexPath{
    HeadImageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"HeadImage" forIndexPath:indexPath];
    UIImage *image = [Utils_UserDefaultInfo GetUserLogo:[UIImage imageNamed:@"default"]];
    [cell setHeadImage:image];
    cell.textField.text = [Utils_UserDefaultInfo GetUserName:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    return cell;
}

//创建菜单选项单元格
-(UITableViewCell *)createMenuItemCellWithIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MenuItem" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"my3_icon1"];
            cell.textLabel.text = @"个人资料";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"my3_icon2"];
            cell.textLabel.text = @"我的分享";
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"my3_icon3"];
            cell.textLabel.text = @"反馈";
            break;
        default:
            break;
    }
    
    
    [self setCellStyle:cell withHeight:[self tableView:_tableView heightForRowAtIndexPath:indexPath] forTableView:_tableView];
    
    [self setCellAccessory:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:
            [self performSegueWithIdentifier:@"profile" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"share" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"feedback" sender:self];
            break;
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200.0f;
    }else{
        return 60.0f;
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
