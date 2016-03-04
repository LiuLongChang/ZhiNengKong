//
//  EquipFeedbackViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/7/7.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "EquipFeedbackViewController.h"
#import "FeedbackPreviewViewController.h"

@interface EquipFeedbackViewController ()
{
    NSMutableArray *_images;
    UIImage *_currentImage;
    CGFloat _cellWidth;
    NSString *_feedbackID;
    UIImagePickerController *_imagePicker;
    BOOL _hasFeedbackError;
}
@end

@implementation EquipFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.pagingEnabled = YES;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.contentInset = UIEdgeInsetsMake(10,10,10,10);
    _textView.delegate = self;
    [_textView setReturnKeyType:UIReturnKeyDone];
    [_textView setText:@"输入反馈内容"];
    [_textView setFont:[UIFont systemFontOfSize:15.0f]];
    _textView.showsHorizontalScrollIndicator = NO;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _images = [NSMutableArray array];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _cellWidth = (self.view.frame.size.width - 40.0f) / 3.0;
    _feedbackID = [[NSUUID UUID] UUIDString];
    _imagePicker = [[UIImagePickerController alloc] init];//初始化;
    _imagePicker.delegate = self;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendFeedback)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_collectionView reloadData];
}


-(void)sendFeedback{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count >= 6 ? 6 : _images.count + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.contentView.subviews
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect imageFrame = CGRectMake(0, 0, _cellWidth, _cellWidth);
    if (_images.count <=6 && indexPath.row == _images.count) {
        
        UIImage *image = [UIImage imageNamed:@"shebfan_add"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = imageFrame;
        [cell.contentView addSubview:imageView];
        
    }else{
        UIImage *image = _images[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.frame = imageFrame;
        imageView.layer.borderWidth = 0.5;
        imageView.layer.borderColor = [UIColor grayColor].CGColor;
        [cell.contentView addSubview:imageView];
    }
    
    return cell;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([@"输入反馈内容" isEqualToString:_textView.text]) {
        _textView.text = @"";
        _textView.textColor = [UIColor whiteColor];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(_textView.text.length == 0){
            _textView.textColor = [UIColor lightGrayColor];
            _textView.text = @"输入反馈内容";
            [_textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_cellWidth, _cellWidth);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_images.count <=6 && indexPath.row == _images.count) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拍照", @"从手机相册选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }else{
        _currentImage = _images[indexPath.row];
        [self performSegueWithIdentifier:@"preview" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"preview"]) {
        FeedbackPreviewViewController *vc = segue.destinationViewController;
        vc.images = _images;
        vc.currentImage = _currentImage;
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
    
    _imagePicker.allowsEditing = NO;//设置可编辑
    _imagePicker.sourceType = sourceType;
    _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:_imagePicker animated:YES completion:nil];//进入照相界面
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    [self uploadImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)selectPic{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.allowsEditing = NO;//设置可编辑
    _imagePicker.sourceType = sourceType;
    [self presentViewController:_imagePicker animated:YES completion:nil];//进入选择界面
}

-(void)uploadImage:(UIImage *)image{
    UIImage *img = [self imageWithScale:image size:CGSizeMake(image.size.width * 0.5, image.size.height * 0.5)];
    [_images addObject:img];
    
    [_collectionView reloadData];
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
