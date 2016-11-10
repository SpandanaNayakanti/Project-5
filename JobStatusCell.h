//
//  JobStatusCell.h
//  WorkForceTracker
//
//  Created by karthik  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFTUserModel.h"


typedef enum {
    btnTypeAccepted = 0,
    btnTypePending,
    btnTypeCompleted,
    btnTypeRunning
    
}btnType;


typedef enum {
    cellTypeNormal = 0,
    cellTypeTwoBtns,
    cellTypeThreeBtns
    
}cellType;

@protocol JobStatusCellDelegate ;

@interface JobStatusCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobOrdeNum;
@property (strong, nonatomic) IBOutlet UILabel *jobAddress;
@property (strong, nonatomic) IBOutlet UILabel *startDate;

@property (strong, nonatomic) IBOutlet UILabel *startTime;


@property (strong, nonatomic) IBOutlet UIButton *details;

@property (nonatomic , assign) cellType type;
@property (nonatomic , assign) btnType typeBtn;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;



- (void)setCellView;

@property (nonatomic , weak) id<JobStatusCellDelegate> delegate;

- (void)setDataForUserWith:(WFTUserModel *)model;

- (void)btnAction;

@end

@protocol JobStatusCellDelegate <NSObject>

@optional

- (void)sendDetailDataForCell:(JobStatusCell *)cell;
-(void)updateJobForCell:(JobStatusCell*)cell;

@end

