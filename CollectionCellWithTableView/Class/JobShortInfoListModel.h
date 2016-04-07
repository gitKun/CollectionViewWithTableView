//
//  JobShortInfoListModel.h
//  CollectionCellWithTableView
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JobShortInfoModel : NSObject

@property (nonatomic, strong) NSString *educational;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *salary;

@end

@interface PubliserInfoModel : NSObject

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companySize;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *publiserIcon;

@end

@interface JobShortInfoListModel : NSObject

@property (nonatomic, strong) NSString *jobName;
@property (nonatomic, strong) JobShortInfoModel *jobShortInfoModel;
@property (nonatomic, strong) PubliserInfoModel *publiserInfoModel;
@property (nonatomic, strong) NSString *lastRespond;

@end
