//
//  FeedbackPreviewViewController.m
//  ZhiNengKong
//
//  Created by 高大为 on 15/6/27.
//  Copyright (c) 2015年 Andon Health Co,.Ltd. All rights reserved.
//

#import "FeedbackPreviewViewController.h"

@interface FeedbackPreviewViewController ()
{
    //上一张
    UIImageView *prevImageView;
    //当前图片
    UIImageView *currentImageView;
    //下一张
    UIImageView *nextImageView;
    
    UIScrollView *_scrollView;
    
    BOOL _isShowStatusBar;
}
@end

@implementation FeedbackPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideTabBar];
    [self loadScrollView];
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
    rightButton.tintColor = [UIColor colorWithRed:112.0/255.0 green:166.0/255.0 blue:231.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - ActionSheet委托

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            int index = [_images indexOfObject:_currentImage];
            
            if (index + 1 < _images.count) {
                _currentImage = _images[index + 1];
                [_images removeObjectAtIndex:index];
            }else if (index - 1 >= 0) {
                _currentImage = _images[index - 1];
                [_images removeObjectAtIndex:index];
            }else{
                [_images removeObjectAtIndex:index];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            [self loadScrollView];
        }
            break;
        default:
            break;
    }
}

-(void)delete{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"删除",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    [self toggleNavigationBarAndStatusBarVisibility];
    [self loadScrollView];
}

#pragma mark - Public

- (void)toggleNavigationBarAndStatusBarVisibility
{
    _isShowStatusBar = !_isShowStatusBar;
    BOOL willShow = self.navigationController.navigationBarHidden;
    
    if (willShow) {
        [self toggleStatusBarHiddenWithAppearanceUpdate:NO];
        [self toggleNavigationBarHiddenAnimated:YES];
    } else {
        [self toggleNavigationBarHiddenAnimated:YES];
        [self toggleStatusBarHiddenWithAppearanceUpdate:YES];
    }
}

-(BOOL)prefersStatusBarHidden{
    return _isShowStatusBar;
}

#pragma mark - Private

- (void)toggleStatusBarHiddenWithAppearanceUpdate:(BOOL)updateAppearance
{
    if (updateAppearance) {
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
}

- (void)toggleNavigationBarHiddenAnimated:(BOOL)animated
{
    [self.navigationController
     setNavigationBarHidden:!self.navigationController.navigationBarHidden
     animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ScrollView

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int x = scrollView.contentOffset.x;
    NSUInteger index = [_images indexOfObject:_currentImage];
    //往下翻一张
    if(x >= (_scrollView.frame.size.width * 2)) {
        if (index < _images.count - 1) {
            _currentImage = _images[index + 1];
        }
        [self loadScrollView];
    }
    //往上翻
    if(x <= 0) {
        if (index > 0) {
            _currentImage = _images[index - 1];
        }
        [self loadScrollView];
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    NSUInteger index = [_images indexOfObject:_currentImage];
    int x = scrollView.contentOffset.x;
    
    //往下翻一张
    if(x > _scrollView.frame.size.width && index >= _images.count - 1) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    }
    //往上翻
    if(x < _scrollView.frame.size.width && index <= 0) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    }
}

-(void)loadScrollView{
    
    CGRect screen = [UIApplication sharedApplication].keyWindow.frame;

    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:screen];
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        [self.view addSubview:_scrollView];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.directionalLockEnabled = YES;
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, 0);
    UIImage *prevImage = nil;
    UIImage *nextImage = nil;
    NSUInteger index = [_images indexOfObject:_currentImage];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%u/%lu",index + 1,(unsigned long)_images.count];
    
    if (index < _images.count - 1) {
        nextImage = _images[index + 1];
    }
    
    if (index > 0) {
        prevImage = _images[index - 1];
    }
    
    if (prevImageView == nil) {
        prevImageView = [self createImageView:prevImage frame:_scrollView.frame];
        prevImageView.frame = CGRectOffset(_scrollView.frame, 0, 0);
        [_scrollView addSubview:prevImageView];
    }else{
        prevImageView.frame = CGRectOffset(_scrollView.frame, 0, 0);
        prevImageView.image = prevImage;
    }
    
    if (currentImageView == nil) {
        currentImageView = [self createImageView:_currentImage frame:_scrollView.frame];
        currentImageView.frame = CGRectOffset(_scrollView.frame, _scrollView.frame.size.width, 0);
        [_scrollView addSubview:currentImageView];
    }else{
        currentImageView.frame = CGRectOffset(_scrollView.frame, _scrollView.frame.size.width, 0);
        currentImageView.image =_currentImage;
    }
    
    if (nextImageView == nil) {
        //下一张
        nextImageView = [self createImageView:nextImage frame:_scrollView.frame];
        nextImageView.frame = CGRectOffset(_scrollView.frame, _scrollView.frame.size.width * 2, 0);
        [_scrollView addSubview:nextImageView];
    }else{
        nextImageView.frame = CGRectOffset(_scrollView.frame, _scrollView.frame.size.width * 2, 0);
        nextImageView.image = nextImage;
    }
    
    [_scrollView setContentOffset:CGPointMake(currentImageView.frame.size.width, 0) animated:NO];
}

//创建图片展示ImageView
-(UIImageView *)createImageView:(UIImage *)image frame:(CGRect)frame{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor whiteColor];
    return imgView;
}

@end
