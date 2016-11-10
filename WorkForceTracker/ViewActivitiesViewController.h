//
//  ViewActivitiesViewController.h
//  WorkForceTracker
//
//  Created by Anshu  on 27/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewActivitiesCell.h"

@interface ViewActivitiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSMutableArray *taskListArry;

@property (strong, nonatomic) IBOutlet UITableView *tblActvts;

- (IBAction)backActn:(id)sender;



@end
