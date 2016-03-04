//
//  AddFriendViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "AddFriendViewController.h"
#import "CloudBL.h"
#import "SeachFriendInfoModel.h"
#import "Utils_UserDefaultInfo.h"

@interface AddFriendViewController ()
{
    SeachFriendInfoModel *_friend;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    _searchBar.delegate = self;
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    [self.view addGestureRecognizer:singleTap];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    
    if (searchBar.text.length != 11) {
        [self alertWithTitle:@"您的输入有误" content:@"手机号码格式不正确" ok:nil];
    }else{
        [self loadData:searchBar.text];
    }
}

-(void)loadData:(NSString *)searchText{
    [CloudBL SeachFriendInfo_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] Identifiy:searchText success:^(SeachFriendInfoModel *friend) {
        _friend = friend;
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        _friend = nil;
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImage *image = [UIImage imageNamed:@"default"];
    NSString *imageUrl = _friend.avatar;
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
    
    cell.textLabel.text = [_friend.name isKindOfClass:[NSNull class]]? @"" : _friend.name;
    
    [self setCellStyle:cell withHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath] forTableView:tableView];
    
    if (![_friend.fID isEqualToString:[Utils_UserDefaultInfo GetUserIdentifer:nil]]) {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        addButton.backgroundColor = [UIColor colorWithRed:111.0/255.0 green:165.0/255.0 blue:230.0/255.0 alpha:1.0];
        [self setRadiusForButton:addButton];
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        
        [addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = addButton;
    }
    
    
    
    return cell;
}

-(void)addFriend{
    [CloudBL AddFriendInfo_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] FID:_friend.fID success:^{
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMessage) {
       [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friend?1:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
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
