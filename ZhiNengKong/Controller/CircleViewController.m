//
//  CircleViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "CircleViewController.h"
#import "MyCirclesModel.h"
#import "CloudBL.h"
#import "Utils_UserDefaultInfo.h"
#import "CircleCollectionViewCell.h"
#import "CircleMessageViewController.h"

@interface CircleViewController ()
{
    NSArray *_myCircles;
    MyCirclesModel *_selectedCircle;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"mysheb_icon_6"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    [rightButton setImage:image forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addCircle) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"CircleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    CGRect screen = mainWindow.frame;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((screen.size.width - 30.0f)/2.0f, 120.0f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self loadData];
}

-(void)addCircle{
    [self performSegueWithIdentifier:@"add" sender:self];
}

-(void)loadData{
    [CloudBL MyCircles_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSArray *myCircles) {
        _myCircles = myCircles;
        [_collectionView reloadData];
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selectedCircle = [MyCirclesModel modelObjectWithDictionary:_myCircles[indexPath.row]];
    [self performSegueWithIdentifier:@"message" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"message" isEqualToString:segue.identifier]) {
        CircleMessageViewController *messsageVC = segue.destinationViewController;
        messsageVC.circle = _selectedCircle;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _myCircles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _myCircles[indexPath.row];
    
    MyCirclesModel *circle = [MyCirclesModel modelObjectWithDictionary:dic];
    
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 5.0f;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.textLabel.text = circle.name;
    return cell;
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
