//
//  JobListTableCell.m
//  CollectionCellWithTableView
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "JobListTableCell.h"
#import "DRSplitLineView.h"
#import "UIView+Corner.h"
#import "JobShortInfoListModel.h"
#import "UIImageView+WebCache.h"

@interface JobListTableCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationalLabel;
@property (weak, nonatomic) IBOutlet DRSplitLineView *firstSplitLine;
@property (weak, nonatomic) IBOutlet UIImageView *publiserIcon;
@property (weak, nonatomic) IBOutlet UILabel *publiserName;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *companySize;
@property (weak, nonatomic) IBOutlet DRSplitLineView *secondSplitLine;
@property (weak, nonatomic) IBOutlet UILabel *lestRespond;

@property (nonatomic, assign) BOOL shoulDRCorner;

@end

@implementation JobListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstSplitLine.lineColor = self.secondSplitLine.lineColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
    self.firstSplitLine.splitWidth = self.secondSplitLine.splitWidth = 2.5;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_shoulDRCorner) {
        self.shoulDRCorner = YES;
        //NSLog(@"cell.frame = %@",NSStringFromCGRect(self.frame));
        //NSLog(@"cell.bgView.frame = %@",NSStringFromCGRect(self.bgView.frame));
        /*
         重新计算 bgView 的 frame 主要是 size 的大小 最后对`高`进行向后取整数，是因为约束出来的高为浮点数这时操作底层会有性能的损耗并且在模拟器上看着不爽<这是重点>我就这样改了🙈
         */
        self.bgView.frame = CGRectMake(10, 10, CGRectGetWidth(self.frame)-20, ceil(CGRectGetHeight(self.bgView.frame)));
        //NSLog(@"cell.bgView.frame = %@",NSStringFromCGRect(self.bgView.frame));
        [self.bgView dr_cornerWithRadius:10 backgroundColor:self.backgroundColor];
        [self.publiserIcon dr_cornerWithRadius:25 backgroundColor:self.bgView.backgroundColor];
    }
}

- (void)updateWithJobShortInfoListModel:(JobShortInfoListModel *)model {
    self.jobNameLabel.text = model.jobName;
    self.salaryLabel.text = model.jobShortInfoModel.salary;
    self.location.text = model.jobShortInfoModel.location;
    self.experienceLabel.text = [model.jobShortInfoModel.experience stringByAppendingString:@"年"];
    self.educationalLabel.text = model.jobShortInfoModel.educational;
    [self.publiserIcon sd_setImageWithURL:[NSURL URLWithString:model.publiserInfoModel.publiserIcon]];
    self.publiserName.text = model.publiserInfoModel.name;
    self.companyName.text = model.publiserInfoModel.companyName;
    self.companySize.text = model.publiserInfoModel.companySize;
    self.position.text = model.publiserInfoModel.position;
    self.lestRespond.text = [@"最后回复：" stringByAppendingString:model.lastRespond];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
