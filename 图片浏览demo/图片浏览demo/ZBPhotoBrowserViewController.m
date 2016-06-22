//
//  ZBPhotoBrowserViewController.m
//  MakeComponents
//
//  Created by idiot.lin on 16/6/14.
//  Copyright © 2016年 apple.lin. All rights reserved.
//

#import "ZBPhotoBrowserViewController.h"
#import <YYWebImage/UIImageView+YYWebImage.h>
#import <Masonry.h>
static NSString * const reuseIdentifier = @"ZBPhotoBrowserCell";
static const CGFloat kCollectionViewItemLineSpacing = 10;


@interface ZBPhotoBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
/**
 * 数据类型
 */
@property (nonatomic, assign) ZBPhotoBrowserSourceType sourceType;
/**
 * 数据源数组
 */
@property (nonatomic, strong) NSArray *sourceArr;
/**
 * 集合视图
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  指示下标
 */
@property (nonatomic, strong) UIPageControl *pageControl;
/**
 *  图片下标
 */
@property (nonatomic, assign) NSInteger imageIndex;
@end

@implementation ZBPhotoBrowserViewController


#pragma mark - life cycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
-(instancetype)init{
    @throw [NSException exceptionWithName:@"ZBPhotoBrowserViewController init error!" reason:@"Please use initWithDataSourceArr:sourceType: instead" userInfo:nil];
    return [self initWithDataSourceArr:nil sourceType:ZBPhotoBrowserDefault imageIndex:0];
}
-(instancetype)initWithDataSourceArr:(NSArray *)sourceArr sourceType:(ZBPhotoBrowserSourceType)type imageIndex:(NSInteger)imageIndex
{
    self = [super init];
    if (!self) return nil;
    if (!sourceArr) return nil;
    _sourceArr = sourceArr.copy;
    _sourceType = type;
    _imageIndex = imageIndex;
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Delegate

#pragma mark CollectionViewDateSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZBPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    _pageControl.currentPage = indexPath.row;
    if (_sourceType == ZBPhotoBrowserDefault) {
        NSString *url = self.sourceArr[indexPath.item];
        [cell.imageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@"loadingImage"] options:YYWebImageOptionProgressive completion:nil];
    }else
    {
        id image = self.sourceArr[indexPath.item];
        if ([image isKindOfClass:[UIImage class]]) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            cell.imageView.image = [YYImage imageWithData:data];
        }
    }
    return cell;
}

#pragma mark - event response
#pragma mark - private method
-(void)initialization {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
}
#pragma mark - getters and setters
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2-50), [UIScreen mainScreen].bounds.size.height - 40, 100, 10)];
        _pageControl.numberOfPages = self.sourceArr.count;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = _imageIndex;
    }
    return _pageControl;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout =[UICollectionViewFlowLayout new];
        flowLayout.itemSize =CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing=kCollectionViewItemLineSpacing;
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, kCollectionViewItemLineSpacing);
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+kCollectionViewItemLineSpacing, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled=YES;
        [_collectionView registerClass:[ZBPhotoBrowserCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        //设置偏移量
        [self.collectionView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * _imageIndex, 0) animated:YES];
    }
    return _collectionView;
}

@end


#pragma mark - --------------------ZBPhotoBrowserCell-----------------------

@interface ZBPhotoBrowserCell()<UIScrollViewDelegate>
@property(strong,nonatomic) UITapGestureRecognizer *doubleTapGesture;

@end

@implementation ZBPhotoBrowserCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initialization];
    }
    return self;
}
- (void)p_initialization{
    
    _containScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _containScrollView.delegate=self;
    _containScrollView.maximumZoomScale=3;
    _containScrollView.minimumZoomScale=1;
    [self.contentView addSubview:_containScrollView];
    _imageView=[[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_containScrollView addSubview:_imageView];
    [self addGestureRecognizer:self.doubleTapGesture];
}
#pragma mark event response
- (void)p_doubleTap:(UITapGestureRecognizer *)gesture{
    if (self.containScrollView.zoomScale<=1) {
        [self.containScrollView setZoomScale:3 animated:YES];
    }else{
        [self.containScrollView setZoomScale:1 animated:YES];
    }
    
    
}

#pragma privete method

#pragma mark Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    UIView *subView = _imageView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}
#pragma mark - Getters And Setters
- (UITapGestureRecognizer *)doubleTapGesture{
    if (!_doubleTapGesture) {
        _doubleTapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_doubleTap:)];
        _doubleTapGesture.numberOfTapsRequired=2;
    }
    return _doubleTapGesture;
}
@end