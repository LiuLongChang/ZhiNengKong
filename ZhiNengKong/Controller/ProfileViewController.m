//
//  ProfileViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/23.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "Utils_UserDefaultInfo.h"
#import "CloudBL.h"

@interface ProfileViewController ()
{
    NSIndexPath *_selectedIndexPath;
    NSString *_selectedValue;
    UIImage *_logoImage;
    NSString *_userName;
    NSString *_phone;
    UIImagePickerController *_imagePicker;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self setRadiusForButton:_logoutButton];
    _logoImage = [Utils_UserDefaultInfo GetUserLogo:[UIImage imageNamed:@"default"]];
    _userName = [Utils_UserDefaultInfo GetUserName:@"未设置"];
    _phone = [Utils_UserDefaultInfo GetUserPhone:@"未设置"];
    
    [self loadData];
}

-(void)loadData{
    [CloudBL GetUserInfo_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] success:^(NSString *HGUID, NSString *Phone, NSString *Logo, NSString *UserName) {
        if (Logo!=nil && ![Logo isEqualToString:@""]) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:Logo]];
            _logoImage = [UIImage imageWithData:imageData];
            [Utils_UserDefaultInfo SetUserLogo:_logoImage];
        }
        
        _phone = Phone;
        _userName = UserName;
        [Utils_UserDefaultInfo SetUserName:_userName];
        [Utils_UserDefaultInfo SetUserPhone:_phone];
        _logoImage = [Utils_UserDefaultInfo GetUserLogo:[UIImage imageNamed:@"default"]];
        _userName = [Utils_UserDefaultInfo GetUserName:@""];
        _phone = [Utils_UserDefaultInfo GetUserPhone:@""];
        [_tableView reloadData];
        
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    if (indexPath) {
        [_tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}


#pragma mark - 退出账号
- (IBAction)logoutButtonClick:(id)sender {
    
    [self confirmWithTitle:@"确认要退出账号吗？" content:nil ok:^(id sender) {
        [Utils_UserDefaultInfo SetUserIdentifer:nil];
        [Utils_UserDefaultInfo SetUserAccessKey:nil];
        [Utils_UserDefaultInfo SetUserRefreshToken:nil];
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vc =[storybord instantiateViewControllerWithIdentifier:@"login"];
        [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
    } cancel:nil];
}

-(void)saveTextWithTitle:(NSString *)title text:(NSString *)text{
    if ([title isEqualToString:@"昵称"]) {
        _userName = text;
        [_tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if ([segue.identifier isEqualToString:@"edit"]) {
        UINavigationController *nav = segue.destinationViewController;
        EditProfileViewController *editVC = nav.viewControllers[0];
        editVC.delegate = self;
        switch (_selectedIndexPath.row) {
            case 0:
                
                break;
            case 1:
                editVC.title = @"昵称";
                editVC.fieldName = @"UserName";
                editVC.editText = _userName;
                break;
            case 2:
                editVC.title = @"手机号";
                editVC.editText = _phone;
                break;
            case 3:
                
                break;
            default:
                break;
        }
    }
}

#pragma mark - TableView代理

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileHeadImage"];
            cell.textLabel.text = @"头像";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:_logoImage];
            imageView.frame = CGRectMake(0, 0, 50.0f, 50.0f);
            imageView.layer.cornerRadius = 25.0f;
            imageView.layer.masksToBounds = YES;
            cell.accessoryView = imageView;
        }
            break;
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProfileItem"];
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = _userName;
            cell.detailTextLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
            [self setCellAccessory:cell];;
            break;
        case 2:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProfileItem"];
            cell.textLabel.text = @"手机号";
            cell.detailTextLabel.text = _phone;
            cell.detailTextLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:123.0/255.0 blue:140.0/255.0 alpha:1.0];
            [self setCellAccessory:cell];
            break;
        case 3:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfileItem"];
            cell.textLabel.text = @"修改密码";
            [self setCellAccessory:cell];;
            break;
        default:
            break;
    }
    
    [self setCellStyle:cell withHeight:[self tableView:_tableView heightForRowAtIndexPath:indexPath] forTableView:_tableView];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath = indexPath;
    switch (indexPath.row) {
        case 0:
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"拍照", @"从手机相册选择",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
            break;
        case 1:
            [self performSegueWithIdentifier:@"edit" sender:self];
            break;
        case 2:
            
            break;
        case 3:
            [self performSegueWithIdentifier:@"pwd" sender:self];
            break;
        default:
            break;
    }
}

#pragma mark - ActionSheet委托

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self selectPic];
            break;
        default:
            break;
    }
}

-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker = [[UIImagePickerController alloc] init];//初始化
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;//设置可编辑
    _imagePicker.sourceType = sourceType;
    _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:_imagePicker animated:YES completion:nil];//进入照相界面
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image= [info objectForKey:UIImagePickerControllerEditedImage];
    [self saveLogo:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectPic{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker = [[UIImagePickerController alloc] init];//初始化
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;//设置可编辑
    _imagePicker.sourceType = sourceType;
    [self presentViewController:_imagePicker animated:YES completion:nil];//进入选择界面
}

-(void)saveLogo:(UIImage *)image{
    _logoImage = [self imageWithScale:image size:CGSizeMake(200, 200)];
    [Utils_UserDefaultInfo SetUserLogo:_logoImage];
    NSData *imageData = UIImagePNGRepresentation(_logoImage);
    
    [CloudBL UploadAvatars_UN:[Utils_UserDefaultInfo GetUserIdentifer:nil] AccessToken:[Utils_UserDefaultInfo GetUserAccessKey:nil] Ext:@"png" ImageData:[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] success:^{
        
    } failure:^(NSString *errorMessage) {
        [self alertWithTitle:@"发生错误" content:errorMessage ok:nil];
    }];
    
    [_tableView reloadData];
}

-(UIImage *)imageWithScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    
    if (nil == image)
    {
        newimage = nil;
    }
    else
    {
        CGSize oldsize = image.size;
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height)
        {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else
        {
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newimage;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
