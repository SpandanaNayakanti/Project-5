//
//  JobsViewController.h
//  WorkForceTracker
//
//  Created by Anshu  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMLDictionary.h"
#import "JobStatusViewController.h"


@interface JobsViewController : UIViewController
{
    
    
    IBOutlet UIActivityIndicatorView *activityIndi;
    JobStatusViewController *jobStatusVC;
}

- (IBAction)pendingJobsAction:(id)sender;

- (IBAction)backAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *acceptedJobsLbl;
@property (weak, nonatomic) IBOutlet UILabel *pendingJobsLbl;
@property (weak, nonatomic) IBOutlet UILabel *completedJobsLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actvtyIndi;

@property (weak, nonatomic) IBOutlet UILabel *runningJobsLbl;
- (IBAction)acceptedJobsAction:(id)sender;
@property (nonatomic,strong)NSString *status;
- (IBAction)runningJobsAction:(id)sender;
- (IBAction)completedJobsAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *completedJobs;
@property (strong, nonatomic) IBOutlet UIButton *acceptedJobs;


@end
