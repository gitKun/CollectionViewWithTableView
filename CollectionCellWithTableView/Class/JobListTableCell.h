//
//  JobListTableCell.h
//  CollectionCellWithTableView
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobShortInfoListModel;

@interface JobListTableCell : UITableViewCell

- (void)updateWithJobShortInfoListModel:(JobShortInfoListModel *)model;

@end
