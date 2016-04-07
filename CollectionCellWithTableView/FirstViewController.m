//
//  FirstViewController.m
//  CollectionCellWithTableView
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "FirstViewController.h"
#import "JobListTableCell.h"
#import "MJExtension.h"
#import "JobShortInfoListModel.h"
#import "BossPushTransition.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FirstViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCustomLeftBarButton];
    [self momeryInit];
    
}
- (void)creatCustomLeftBarButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"bar_notice"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[item];
}

- (void)momeryInit {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar_bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.dataArr = [[NSMutableArray alloc] init];
    NSString *soucePath = [[NSBundle mainBundle] pathForResource:@"jobListJson" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:soucePath];
    NSArray *souceArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dict in souceArr) {
        [JobShortInfoListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"jobShortInfoModel":@"jobShortInfo",@"publiserInfoModel":@"publiserInfo"};
        }];
        JobShortInfoListModel *model = [JobShortInfoListModel mj_objectWithKeyValues:dict];
        
        [self.dataArr addObject:model];
    }
}

#pragma mark ==== UITableViewDelegate  &&  UITableViewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 174;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobListTableCellID"];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobListTableCell" owner:self options:nil] lastObject];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    JobListTableCell *jCell = (JobListTableCell *)cell;
    [jCell updateWithJobShortInfoListModel:_dataArr[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //superview conver subview.frame to toView
    CGRect popRect = [tableView convertRect:cell.frame toView:self.view];
    //NSLog(@"popRect = %@",NSStringFromCGRect(popRect));
    self.popRect = popRect;
    [self performSegueWithIdentifier:@"ToDetailVC" sender:self];
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"self.view.frame = %@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"screen.bounds = %@",NSStringFromCGRect([UIScreen mainScreen].bounds));
//}


#pragma mark ==== UINavigationDelegate 
#pragma mark ==== UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [BossPushTransition new];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToDetailVC"]) {
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
