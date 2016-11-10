//
//  ViewActivitiesCell.m
//  WorkForceTracker
//
//  Created by Anshu  on 18/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "ViewActivitiesCell.h"

@implementation ViewActivitiesCell
{
    TaskListModel *taskModel_;
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
-(void)setDataForUserWith:(TaskListModel*)model with:(NSInteger)tag
{
    taskModel_=model;
    _activityNum.text=[NSString stringWithFormat:@"%d",tag+1];
    _descrptnLbl.text=model.uTaskDescription;
    _dateLbl.text=model.uStartDate;
    _strtTmeLbl.text=model.uStartTime;
    _endTmeLbl.text=model.uEndTime;
    
}

@end
