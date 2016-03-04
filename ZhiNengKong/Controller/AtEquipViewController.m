//
//  AtEquipViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/28.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AtEquipViewController.h"
#import "EqInfoModel.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "EqInfoModel.h"

@interface AtEquipViewController ()
{
    NSMutableArray *_equips;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AtEquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIColor *buttonColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] init];
    [leftButton setTitle:@"取消"];
    [leftButton setTintColor:buttonColor];
    leftButton.target = self;
    leftButton.action = @selector(cancel);
    
    self.navigationItem.leftBarButtonItem = leftButton;
    self.title = @"选择设备";
    [self loadData];
}

-(void)loadData{
    _equips = [NSMutableArray array];
    [CloudBL GetCircleDetail_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] CircleID:_circleId success:^(NSArray *EqInfo, NSArray *UserInfo) {
        for (NSDictionary *dic in EqInfo) {
            EqInfoModel *equip = [EqInfoModel modelObjectWithDictionary:dic];
            
            UIImage *img = [UIImage imageNamed:@"mysheb_icon_1"];
            
            if (![@"" isEqualToString:equip.eqAvatar] && equip.eqAvatar!=nil) {
                
                img = [Utils_UserDefaultInfo GetAvatarWithUrl:equip.eqAvatar image:nil];
                
                if (img == nil) {
                    img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:equip.eqAvatar]]];
                    [Utils_UserDefaultInfo SetAvatarWithUrl:equip.eqAvatar image:img];
                }
            }
            
            equip.image = img;
            
            [_equips addObject:equip];
        }
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EqInfoModel *equip = _equips[indexPath.row];
    if (self.atEqiupDelegate) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.atEqiupDelegate AtEquip:equip.uniCode withName:equip.eqName];
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EqInfoModel *equip = _equips[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.imageView.image = equip.image;
    
    CGSize imageSize = CGSizeMake(50.0,50.0);
    
    UIGraphicsBeginImageContext(imageSize);
    [cell.imageView.image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image = newImage;
    cell.imageView.layer.cornerRadius = 25.0f;
    cell.imageView.layer.masksToBounds = YES;
    
    cell.textLabel.text = equip.eqName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _equips.count;
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
