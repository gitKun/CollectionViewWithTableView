//
//  ViewController.m
//  CollectionCellWithTableView
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "ViewController.h"
#import "TestCollectionViewCell.h"
#import "BossPopTransition.h"
#import "BossClosePopTransition.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TestCollectionViewCellDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isDismissAnimation;

@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.navigationController) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //self.view.clipsToBounds = YES;
    //self.view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    self.view.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor redColor];
    [self creatCustomNavigationItems];
    [self memoryInit];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}
- (void)memoryInit {
    self.title = @"iOS";
    [self.collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"TestCollectionCellID"];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
}
- (void)creatCustomNavigationItems {
    //左按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[item];
}
- (void)leftbarButtonClick:(UIButton *)button {
    self.isDismissAnimation = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ==== TestCollectionViewCellDelegate
- (void)testCollectionViewCell:(TestCollectionViewCell *)cell currentOffsetY:(CGFloat)offsetY {
    if (_isDismissAnimation) {
        return;
    }
    self.collectionView.frame = CGRectMake(0, offsetY, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-64);
}
- (void)testCollectionViewCellBeginPopAnimation:(TestCollectionViewCell *)cell {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)testCollectionViewCell:(TestCollectionViewCell *)cell finisedDownloadData:(BOOL)isFinished {
    
}

#pragma mark ==== UICollectionViewDelegate && UICollectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCollectionCellID" forIndexPath:indexPath];
    if (!cell.mDelegate) {
        cell.mDelegate = self;
        if (indexPath.row == 0) {
            [cell begainDownloadData];
        }
    }
    return cell;
}
//等到数据后再打开注释 进行cell 的填充
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TestCollectionViewCell *tCell = (TestCollectionViewCell *)cell;
    self.currentRow = indexPath.row;
    [tCell reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(self.collectionView.frame));
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger row = offsetX/CGRectGetWidth(scrollView.bounds);
    if (row == self.currentRow) {
        TestCollectionViewCell *cell = (TestCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0]];
        [cell begainDownloadData];
    }
}



#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!_isDismissAnimation) {
        BossPopTransition *inverseTransition = [[BossPopTransition alloc]init];
        return inverseTransition;
    }else {
        BossClosePopTransition *dismissTransition = [[BossClosePopTransition alloc] init];
        return dismissTransition;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
