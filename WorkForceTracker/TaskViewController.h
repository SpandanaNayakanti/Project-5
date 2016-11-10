//
//  TaskViewController.h
//  WorkForceTracker
//
//  Created by Anshu  on 25/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFTUserModel.h"
#import "ActivitiesModel.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface TaskViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    BOOL flag;
}


- (IBAction)backAction:(id)sender;
@property (strong , nonatomic)  WFTUserModel *detailModel;
@property (strong , nonatomic)  ActivitiesModel *activityModel;
@property (strong , nonatomic) NSMutableArray *activityArray;
@property (strong , nonatomic) NSMutableArray *runningActvtsArray;

@property (strong, nonatomic) IBOutlet UIImageView *dropDownImgView;

@property (strong , nonatomic) UITextField *projectId;
@property (strong , nonatomic) UITextField *projectName;
@property (strong , nonatomic) UITextField *notes;
@property (strong , nonatomic) UILabel *timeLbl;
@property (strong , nonatomic) IBOutlet UILabel *uId;
@property (strong , nonatomic) IBOutlet UILabel *taskName;
@property (strong , nonatomic) UITableView *taskTV;
@property (strong , nonatomic) NSArray *arrayData;
@property (strong , nonatomic) IBOutlet UIButton *startActivityBtn;
@property (strong , nonatomic) IBOutlet UIButton *endActivityBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelActvty;

- (IBAction)strtActivityActn:(id)sender;

- (IBAction)endActvtyBtn:(id)sender;

- (IBAction)cancelActvty:(id)sender;

@end
