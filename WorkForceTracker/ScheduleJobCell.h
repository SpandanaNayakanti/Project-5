//
//  ScheduleJobCell.h
//  WorkForceTracker
//
//  Created by karthik  on 05/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFTUserModel.h"



@protocol ScheduleJobCellDelegate ;

@interface ScheduleJobCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *jobOrdeNum;
@property (strong, nonatomic) IBOutlet UILabel *jobAddress;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UIButton *details;
@property (strong, nonatomic) IBOutlet UILabel *jobStatus;

- (void)setCellView;



@property (nonatomic , weak) id <ScheduleJobCellDelegate> delegate;

- (void)setDataForUserWith:(WFTUserModel *)model;

- (void)btnAction;

@end
@protocol ScheduleJobCellDelegate <NSObject>

@optional

- (void)sendDetailDataForCell:(ScheduleJobCell *)cell;




@end
