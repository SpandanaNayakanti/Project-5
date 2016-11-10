//
//  UpdatedViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedRectView.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomMapViewController.h"
#import "HelpViewController.h"
#import "MapViewController.h"
#import "JobsViewController.h"
#import "TrackingViewController.h"


#define SYSTEM_VERSION_LESS_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@class StatusViewController,AppDelegate;
@interface UpdatedViewController : UIViewController<UIPopoverControllerDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIButton *sheetbtn,*updatebtn,*BtnBack;
    IBOutlet UITableView *updatetable;
    StatusViewController *statusVC;
    UIPopoverController *popOverController;
    IBOutlet UIButton *settingbtn,*Btnhelp;
    IBOutlet UIButton *exitbtn,*Btnalert;
    AppDelegate *    appDelegate;
    RoundedRectView *rView;
    double bglat;
	double	bglong;
    UIButton *signoutBtn;
    HelpViewController *helpVC;
    MapViewController *mapVC;
    JobsViewController *jobsVC;
    TrackingViewController *trackingViewCont;
    
    
    IBOutlet UIActivityIndicatorView *activityIndi;
}
@property UIView *view2;
@property (nonatomic , retain) CLLocationManager *bgTrackLocation;
@property (nonatomic , retain) UIPopoverController *popOverController;
@property (nonatomic , retain) NSString *emergencyemail;
@property (nonatomic , retain) UIImageView *progressImage;
@property (nonatomic , retain) RoundedRectView *rView;;
@property (nonatomic , retain) NSTimer *alertTimer;
@property (nonatomic , retain) NSString *finaladdress;
@property (nonatomic , retain) UIView *finalEmergencyView;
@property (nonatomic , retain) UIImageView    *selfimage;
@property (strong , nonatomic)  CLGeocoder *geoCoder;
@property (assign) double bglat,bglong;
@property (nonatomic , strong) UIView *formsView;
@property (nonatomic , strong) UIButton *mileageBtn;
@property (nonatomic , strong) UIButton *expenseBtn;
@property (nonatomic , strong) UIView *scheduleView;
@property (nonatomic , strong) UIButton *todaysJobBtn;
@property (nonatomic , strong) UIButton *thisweekJobsBtn;
@property (nonatomic , strong) UIButton *chooseDateBtn;
//@property (nonatomic , strong) UIView *chooseDateView;
@property (nonatomic , strong) UIButton *dynamicBtn;
@property (nonatomic , strong) NSMutableArray *fielddataActnArry;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView2;

@property (strong, nonatomic) IBOutlet UIView *chooseDateView;
@property (strong, nonatomic) IBOutlet UITextField *startDateTxtFld;

@property (strong, nonatomic) IBOutlet UITextField *endDateTxtFld;



- (IBAction)startDateActn:(id)sender;
- (IBAction)endDateActn:(id)sender;
-(IBAction)UpdateAction;
-(IBAction)TimeSheetAction;
-(IBAction)StatusAction;
-(IBAction)SettingAction;
-(IBAction)HelpAction;
-(IBAction)LocationAction;
-(IBAction)ExitAction;
-(IBAction)AlertAction;
- (IBAction)JobsAction:(id)sender;
- (IBAction)FormsAction:(id)sender;
- (IBAction)TrackingAction:(id)sender;
- (IBAction)scheduleActn:(id)sender;
- (IBAction)sendDateActn:(id)sender;



//-(void)Updateaction;
//-(void)Statusaction;
-(void)Settingaction;
-(void)Helpaction;
//-(void)Locationaction;
-(void)Exitaction;

@end
