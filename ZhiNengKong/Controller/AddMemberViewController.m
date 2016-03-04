//
//  AddMemberViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/6.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddMemberViewController.h"
#import "ZBarSDK.h"

@interface AddMemberViewController ()
{
    ZBarReaderController *_reader;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:242.0/255.0 alpha:1.0f];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row ) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"addmember_icon_2"];
            cell.textLabel.text = @"扫一扫";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"addmember_icon_1"];
            cell.textLabel.text = @"搜索";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"zbar" sender:self];
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
