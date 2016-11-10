//
//  ViewActivitiesCell.h
//  WorkForceTracker
//
//  Created by Anshu  on 18/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"


@protocol ViewActivitiesCellDelegate ;

@interface ViewActivitiesCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *activityNum;
@property (strong, nonatomic) IBOutlet UILabel *descrptnLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *strtTmeLbl;
@property (strong, nonatomic) IBOutlet UILabel *endTmeLbl;

-(void)setDataForUserWith:(TaskListModel*)model with:(NSInteger)tag;



@end



