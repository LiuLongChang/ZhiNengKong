//
//  SharedUserViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "SharedUserViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"

@interface SharedUserViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SharedUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView代理

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSString *uid = _users[indexPath.row];
    NSDictionary *userDic = _usersDic[uid];
    
    UIImage *image = [UIImage imageNamed:@"default"];
    NSString *imageUrl = userDic[@"Avatar"];
    if (imageUrl !=nil && ![@"" isEqualToString:imageUrl]) {
        
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        [Utils_UserDefaultInfo SetAvatarWithUrl:imageUrl image:image];
    }
    
    CGSize imageSize = CGSizeMake(50.0,50.0);
    
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = cell.imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = newImage;
    imageView.layer.cornerRadius = 25.0f;
    imageView.layer.masksToBounds = YES;

    cell.textLabel.text = [userDic[@"NickName"] isKindOfClass:[NSNull class]]? @"" : userDic[@"NickName"];
    cell.detailTextLabel.text = [userDic[@"UserName"] isKindOfClass:[NSNull class]]? @"" : userDic[@"UserName"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    [self setCellStyle:cell withHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath] forTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, height)];
    viewSection.backgroundColor = [UIColor clearColor];
    UILabel *textSection = [[UILabel alloc] initWithFrame:CGRectMake(15,10, viewSection.frame.size.width, 20)];
    textSection.text = [self tableView:tableView titleForHeaderInSection:section];
    textSection.textColor =[UIColor colorWithRed:73.0/255.0 green:88.0/255.0 blue:105.0/255.0 alpha:1.0f];
    textSection.backgroundColor = [UIColor clearColor];
    textSection.font = [UIFont systemFontOfSize:15.0f];
    [viewSection addSubview:textSection];
    return viewSection;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"已分享给：";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *uid = _users[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [CloudBL DelSharings_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] EqID:_eqID UserID:uid success:^{
            [_users removeObject:uid];
            [_tableView reloadData];
        } failure:^(NSString *errorMessage) {
            [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
        }];
    }
}

@end
