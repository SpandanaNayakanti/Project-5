//
//  ScheduleJobCell.m
//  WorkForceTracker
//
//  Created by karthik  on 05/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "ScheduleJobCell.h"

@implementation ScheduleJobCell

{
    WFTUserModel *model_;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellView
{
    [_details addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDataForUserWith:(WFTUserModel *)model
{
    model_ = model;
    _jobOrdeNum.text  = model.uId;
    _jobAddress.text  = model.uAddress;
    _startDate.text   = model.uRequstedDate;
    _startTime.text   = model.uTimeStart;
    
    if ([model.uStatus isEqualToString:@"2"])
    {
        _jobStatus.text=@"Running";
        _jobStatus.textColor=[UIColor greenColor];
    }
    
    if ([model.uStatus isEqualToString:@"0"])
    {
        _jobStatus.text=@"Pending";
        _jobStatus.textColor=[UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.9];
        

    }
    if ([model.uStatus isEqualToString:@"4"])
    {
        _jobStatus.text=@"Completed";
        _jobStatus.textColor=[UIColor darkGrayColor];

    }
    if ([model.uStatus isEqualToString:@"1"])
    {
        _jobStatus.text=@"Accepted";
        _jobStatus.textColor=[UIColor blueColor];
        
    }
    
}

- (void)btnAction
{
    [_delegate sendDetailDataForCell:self];
}


@end
