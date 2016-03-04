//
//  PickMemberViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/24.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "PickMemberViewController.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "Equip.h"

@interface PickMemberViewController ()
{
    NSMutableArray *_members;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PickMemberViewController

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
    _members = [NSMutableArray array];
    
    [CloudBL GetFriendsList_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSArray *friendsArray) {
        
        for (NSDictionary *dic in friendsArray) {
            GetFriendsListModel *friend = [GetFriendsListModel modelObjectWithDictionary:dic];
            [_members addObject:friend];
            
            UIImage *img = [UIImage imageNamed:@"default"];
            
            UIImage *avatarImage = [Utils_UserDefaultInfo GetAvatarWithUrl:friend.avatar image:img];
            
            if (avatarImage == img && ![@"" isEqualToString:friend.avatar]) {
                img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:friend.avatar]]];
                [Utils_UserDefaultInfo SetAvatarWithUrl:friend.avatar image:img];
            }
            
            friend.image = img;
        }
        
        [_tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetFriendsListModel *friend =_members[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    for (GetFriendsListModel *f in _selectedMembers) {
        if ([f.fID isEqualToString:friend.fID]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    cell.imageView.image = friend.image;
    
    CGSize imageSize = CGSizeMake(50.0,50.0);
    
    UIGraphicsBeginImageContext(imageSize);
    [cell.imageView.image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image = newImage;
    cell.imageView.layer.cornerRadius = 25.0f;
    cell.imageView.layer.masksToBounds = YES;
    
    if (friend.name == nil || [@"" isEqualToString:friend.name]) {
        friend.name = friend.phone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = friend.name;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GetFriendsListModel *friend =_members[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL hasPicked = NO;
    GetFriendsListModel *friendForDel = nil;
    for (GetFriendsListModel *f in _selectedMembers) {
        if ([f.fID isEqualToString:friend.fID]) {
            hasPicked = YES;
            friendForDel = f;
        }
    }
    
    if (hasPicked) {
        [_selectedMembers removeObject:friendForDel];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        [_selectedMembers addObject:friend];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _members.count;
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
