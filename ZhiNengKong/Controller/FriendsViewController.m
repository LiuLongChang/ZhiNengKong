//
//  FriendsViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "FriendsViewController.h"
#import "GetFriendsListModel.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"

@interface FriendsViewController ()
{
    //好友列表
    NSMutableArray *_friendsArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsZero;
    
    UIImage *image = [UIImage imageNamed:@"mysheb_icon_6"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)addFriend{
    [self performSegueWithIdentifier:@"add" sender:self];
}

-(void)loadData{
    _friendsArray = [NSMutableArray array];
    [CloudBL GetFriendsList_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSArray *friendsArray) {
        for (NSDictionary *dic in friendsArray) {
            [_friendsArray addObject:[GetFriendsListModel modelObjectWithDictionary:dic]];
        }
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    GetFriendsListModel *friend = _friendsArray[indexPath.row];
    
    UIImage *image = [UIImage imageNamed:@"default"];
    NSString *imageUrl = friend.avatar;
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
    
    cell.textLabel.text = [friend.name isKindOfClass:[NSNull class]] || [@"" isEqualToString:@""]? friend.phone : friend.name;
    cell.detailTextLabel.text = [friend.phone isKindOfClass:[NSNull class]]? @"" : friend.phone;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
    
    [self setCellStyle:cell withHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath] forTableView:tableView];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
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
