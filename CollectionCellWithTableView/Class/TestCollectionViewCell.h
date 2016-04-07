//
//  TestCollectionViewCell.h
//  CollectionCellWithTableView
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 kun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestCollectionViewCell;

@protocol TestCollectionViewCellDelegate <NSObject>

@optional

/**
 *  @brief   通知VC开始自下而上的pop动画
 *
 *  @param cell cell
 */
- (void)testCollectionViewCellBeginPopAnimation:(TestCollectionViewCell *)cell;

/** @brief    通知VC要向上偏移的量*/
- (void)testCollectionViewCell:(TestCollectionViewCell *)cell currentOffsetY:(CGFloat)offsetY;

/** @brief    通知VC自己已经完成下载或者下载失败(用以来显示或者取消遮罩层) */
- (void)testCollectionViewCell:(TestCollectionViewCell *)cell finisedDownloadData:(BOOL)isFinished;

//- (void)testCollectionViewCell:(TestCollectionViewCell *)cell

@end


@interface TestCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<TestCollectionViewCellDelegate>mDelegate;

- (void)reloadData;
- (void)begainDownloadData;

@end
