//
//  JobStatusDetailViewController.h
//  WorkForceTracker
//
//  Created by karthik on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFTUserModel.h"
#import "JobStatusCell.h"
#import "TaskViewController.h"
#import "ViewActivitiesViewController.h"
#import "ActivitiesModel.h"
#import "AppDelegate.h"





@interface JobStatusDetailViewController : UIViewController

@property (nonatomic , strong)  WFTUserModel *detailModel;
@property (nonatomic , strong) ActivitiesModel *activityModel;
@property (nonatomic , strong) TaskViewController *TVC;
@property (nonatomic , strong) ViewActivitiesViewController *activityViewCont;


@property (strong, nonatomic) IBOutlet UILabel *jobId;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *jobType;
@property (strong, nonatomic) IBOutlet UILabel *jobDescrptn;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *custName;
@property (strong, nonatomic) IBOutlet UILabel *custMail;
@property (strong, nonatomic) IBOutlet UILabel *custMbleNumber;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic , strong) UIButton *timeSheet;
@property (nonatomic , strong) UIButton *viewTimeSheet;
@property (nonatomic , assign) btnType typeBtn;
@property (nonatomic , strong) NSMutableArray *activityArry;


- (IBAction)backAction:(id)sender;




@end

