//
//  HQHomeVC.m
//  HQShopDemo
//
//  Created by Mr_Han on 2018/10/16.
//  Copyright © 2018年 Mr_Han. All rights reserved.
//

#import "HQHomeVC.h"

static NSString * const cellID = @"cell";

@interface HQHomeVC () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation HQHomeVC

#pragma mark -- 懒加载

- (UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 1;
    //上下间距
    flowlayout.minimumLineSpacing = 1;
    flowlayout.sectionInset =UIEdgeInsetsMake(0, 3, 0, 3);
    if (!_collectionView) {
        _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0 , 0 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowlayout];
    }
    if (@available(iOS 11.0,*)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.showsVerticalScrollIndicator = NO;
    //广告位轮播
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    
    return _collectionView;
}

#pragma mark -- 配置单元格
//配置单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.section % 2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor purpleColor];
    }
    
    return cell;
}

#pragma mark -- UICollectionView  Delegate/DataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
//设置cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
}
////设置区头高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//
//    return CGSizeMake(JkScreenWidth,JKHEIGHT(0.00001));
//}
////设置区尾高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//
//    return CGSizeMake(JkScreenWidth,JKHEIGHT(0.00001));
//}
////配置区头
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
////    __weak typeof(self) weakSelf =self;
//    if (kind == UICollectionElementKindSectionHeader) {
//
//        return nil;
//    }
//    //区尾
//    if (kind == UICollectionElementKindSectionFooter) {
//
//        return nil;
//    }
//    return nil;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    //添加collectionView
    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置透明导航栏
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat minAlphaOffset = - 88;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha;
    if (offset <= 0) {
        alpha = 0.0;
    } else {
        alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    }
    UIView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = alpha;
}



@end
