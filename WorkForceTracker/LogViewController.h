//
//  LogViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"
#import "UpdatedViewController.h"
#import "Reachability.h"
@class AppDelegate;
@interface LogViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate,CoreLocationControllerDelegate>
{
    IBOutlet UITextField*textuser,*textpass;
    
    IBOutlet UIButton *rememberbtn;
    IBOutlet UIButton *cancel;
    IBOutlet UIButton *sign;
    NSString    *remember;
    id delegate;
    AppDelegate *  appDelegate;
    IBOutlet UIActivityIndicatorView *activityIndi;

    NSString *currenttime;
    NSString *currentday1;

    BOOL ifInsideBannedLocation;
    BOOL ifEmpReached;
    NSString *city,*state,*country,*postal_code;
    NSTimer *timerGeoPointSend,*timerBannedPoint,*timerGeopoint;
    NSMutableArray *arrBanndUpdated;
     Reachability *internetReachableFoo;
}
-(IBAction)CancelAction;
-(IBAction)SignAction;
-(IBAction)RememberAction:(id)sender;

@property (nonatomic, retain) CoreLocationController *locationController;
@property (nonatomic, retain) UILabel *lblLatitude,*lblLongitude;
@property (nonatomic, retain) NSString *currentday1;
@property (nonatomic, retain) NSString *currenttime;
@property (strong, nonatomic) UpdatedViewController *updateVC;
@property (nonatomic,assign)BOOL ifInsideBannedLocation;
@property (nonatomic,assign)BOOL ifEmpReached;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, retain) id delegate;
@property (strong, nonatomic) IBOutlet UITextField *textOrgid;

@property (nonatomic, retain) UITextField *textuser,*textpass;
@property (nonatomic, retain) IBOutlet UIButton  *rememberbtn;
@property (nonatomic, retain) NSString             *remember;

//- (void)readPlist;
@end
