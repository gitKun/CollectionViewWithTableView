//
//  TestCollectionViewCell.m
//  CollectionCellWithTableView
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "TestCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface TestCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSouce;
/** @brief  按钮的背景视图 */
@property (nonatomic, strong) UIView *buttonBGView;

@property (nonatomic, strong) UIImageView *loadingView;
@property (nonatomic, strong) UIView *progressView;

@end

@implementation TestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.dataSouce = [[NSMutableArray alloc] init];
    //添加 tableView
    self.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-60) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];
    //添加 buttonBGView
    [self creadButtonBGView];
    
    //添加 loadingView
    self.progressView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.progressView.backgroundColor = self.backgroundColor;
    self.loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 103, 93)];
    self.loadingView.center = self.progressView.center;
    [self.loadingView sd_setImageWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]]];
    [self.progressView addSubview:_loadingView];
    _loadingView.hidden = YES;
    [self.contentView addSubview:_progressView];
    
    
}
- (void)creadButtonBGView {
    self.buttonBGView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-60, CGRectGetWidth(self.bounds), 60)];
    self.buttonBGView.backgroundColor  = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    //添加两个 button -> 备注：boss 中的动画button 用的是 gif 图片，其实这个 CoreAnimation 动画也很好实现,如果时间允许会写出来
    UIImage *leftImage = [[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    UIImage *rightImage = [[UIImage imageNamed:@"btn_red"] resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    //关于图片拉伸处理 推荐参阅 [resizableImageWithCapInsets:方法的探析]( http://www.jianshu.com/p/a577023677c1 )
    //    UIImage *leftImage = [UIImage imageNamed:@"btn_green"] ;
    //    UIImage *rightImage = [UIImage imageNamed:@"btn_red"] ;
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(15, 8, CGRectGetWidth(_buttonBGView.bounds)/2-30, 42);
    [leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
    [leftButton setTitle:@"+ collect" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:@"Shojumaru-Regular" size:20];
    [self.buttonBGView addSubview:leftButton];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(CGRectGetWidth(_buttonBGView.bounds)/2+15, 8, CGRectGetWidth(_buttonBGView.bounds)/2-30, 42);
    [rightButton setBackgroundImage:rightImage forState:UIControlStateNormal];
    [rightButton setTitle:@"connect at now" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Shojumaru-Regular" size:20];
    [self.buttonBGView addSubview:rightButton];
    [self.contentView addSubview:_buttonBGView];
}

#pragma mark ==== 暴露的接口
- (void)reloadData {
    _progressView.hidden = NO;
    [self.dataSouce removeAllObjects];
    [self.tableView reloadData];
}
- (void)begainDownloadData {
    _loadingView.hidden = NO;
    [self downloadData];
}
- (void)downloadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((arc4random()%3+1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int count = arc4random()%3+14;
        for (int i = 0; i < count; i++) {
            [self.dataSouce addObject:@(i)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.hidden = YES;
            _loadingView.hidden = YES;
            [_tableView reloadData];
        });
    });
}


#pragma mark ==== UITableViewDelegate && UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSouce.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Test1CellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Test1CellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld行",(long)indexPath.row];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat begainY = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds);
//    MIN(0, begainY-scrollView.contentOffset.y) == -MAX(0, (scrollView.contentOffset.y - begainY))
    CGFloat offsetY = MIN(0, begainY-scrollView.contentOffset.y);
    self.buttonBGView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-64-60+offsetY,CGRectGetWidth(self.buttonBGView.bounds), 60);
    self.frame = CGRectMake(CGRectGetMinX(self.frame), -offsetY, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-64+offsetY);
    [self.mDelegate testCollectionViewCell:self currentOffsetY:offsetY];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat begainY = scrollView.contentSize.height-CGRectGetHeight(scrollView.bounds);
    CGFloat offsetY = MIN(0, begainY-scrollView.contentOffset.y);
    if (offsetY < -100) {
        [self.mDelegate testCollectionViewCellBeginPopAnimation:self];
    }
    
}

@end
