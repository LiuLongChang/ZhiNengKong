//
//  EquipDetailViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipDetailViewController.h"
#import "MainTabViewController.h"

@interface EquipDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.opaque = NO;
    _tableView.backgroundView = nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImage *image = [UIImage imageNamed:@"mysheb_icon_2"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleToFill;
        CGFloat imageWidth = 100.0f;
        CGFloat imageHeight = 100.0f;
        CGFloat cellHeight = 100.0f;
        CGFloat cellWidth = self.view.frame.size.width;
        imageView.frame = CGRectMake((cellWidth - imageWidth)/2.0 , (cellHeight - imageHeight)/2.0, imageWidth, imageHeight);
        [cell.contentView addSubview:imageView];
        cell.backgroundColor = [UIColor clearColor];
        tableView.separatorColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        NSArray *imgArr = @[@[],@[@"sheb_icon_2",@"sheb_icon_3",@"sheb_icon_4",@"sheb_icon_1"]];
        NSArray *titleArr = @[@[],@[@"设备名称",@"设备参数",@"反馈",@"版本"]];
        cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sheb_icon_new"]];
            imageView.backgroundColor = [UIColor clearColor];
            cell.accessoryView = imageView;
            cell.detailTextLabel.text = @"1.2.1";
        }else{
            [self setCellAccessory:cell];
        }
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"热水器";
        }
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.opaque = NO;
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 4;
        default:
            return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100.0f;
    }else{
        return 50.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"edit" sender:self];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"feedback" sender:self];
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
