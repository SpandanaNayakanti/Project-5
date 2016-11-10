//
//  JobStatusCell.m
//  WorkForceTracker
//
//  Created by Anshu  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "JobStatusCell.h"

@implementation JobStatusCell
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

    
    if (_typeBtn == btnTypeAccepted)
    {
        _button1.hidden=YES;
       
        [_button2 setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    }
   else if (_typeBtn==btnTypeRunning)
    {
        _button1.hidden=YES;
        [_button2 setImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
    }
  else  if(_typeBtn==btnTypePending)
    {
        _button1.hidden=YES;

        [_button2 setImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
        
    }
    else if (_typeBtn==btnTypeCompleted)
    {
        _button1.hidden=YES;
        _button2.hidden=YES;
    }
    
    [_button2 addTarget:self action:@selector(updateJobStatus) forControlEvents:UIControlEventTouchUpInside];
     [_details addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setDataForUserWith:(WFTUserModel *)model
{
    model_ = model;
    _jobOrdeNum.text  = model.uId;
    _jobAddress.text  = model.uAddress;
    _startDate.text   = model.uRequstedDate;
    _startTime.text   = model.uTimeStart;
}

- (void)btnAction
{
    [_delegate sendDetailDataForCell:self];
}
-(void)updateJobStatus
{
    [_delegate updateJobForCell:self];
}

@end
