//
//  PickEquipViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PickEquipViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "Equip.h"

@interface PickEquipViewController ()
{
    NSMutableArray *_equips;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PickEquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self loadData];
}

-(void)loadData{
    _equips = [NSMutableArray array];
    [CloudBL MyEquips_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] TS:nil success:^(NSNumber *TS, NSArray *Equips) {
        for (NSDictionary *dic in Equips) {
            Equip *equip = [Equip modelObjectWithDictionary:dic];
            
            
            UIImage *img = [UIImage imageNamed:@"mysheb_icon_1"];
            UIImage *avatarImage = [Utils_UserDefaultInfo GetAvatarWithUrl:equip.equipAvatar image:img];
            
            if (avatarImage == img && ![@"" isEqualToString:equip.equipAvatar]) {
                img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:equip.equipAvatar]]];
                [Utils_UserDefaultInfo SetAvatarWithUrl:equip.equipAvatar image:img];
            }
            
            equip.image = img;
            if ([equip.isOwner intValue] == 1) {
                [_equips addObject:equip];
            }
        }
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Equip *equip =_equips[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (Equip *e in _selectedEquips) {
        if ([e.eqID isEqualToString:equip.eqID]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
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
    
    cell.textLabel.text = equip.equipName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Equip *equip =_equips[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL hasPicked = NO;
    Equip *equipForDel = nil;
    for (Equip *e in _selectedEquips) {
        if ([e.eqID isEqualToString:equip.eqID]) {
            hasPicked = YES;
            equipForDel = e;
        }
    }
    
    if (hasPicked) {
        [_selectedEquips removeObject:equipForDel];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        [_selectedEquips addObject:equip];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
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
