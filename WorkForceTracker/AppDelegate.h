//
//  AppDelegate.h
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogViewController.h"
#import "UpdatedViewController.h"
#import "XMLDictionary.h"
#import "OpenUDID.h"
#import "TimeSetViewController.h"



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    NSMutableDictionary *userInfoDict,*userAddressDict;
    LogViewController *loginVC;
    UpdatedViewController *updateVC;
    CLLocationManager *locationManager;
    NSString *city,*state,*country,*postal_code;
    
    NSMutableDictionary *userGeoPointListDict;
    NSMutableDictionary *userBannedLocationListDict;
    TimeSetViewController *timeSetVC;
    NSString* deviceTokenN ;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString  *Emp_ID,*timeSetString;
@property (strong, nonatomic) NSMutableDictionary *userInfoDict,*userAddressDict,*userGeoPointListDict;
@property (strong , nonatomic) NSMutableArray *formsArry;

@property(strong,nonatomic)NSMutableDictionary *userBannedLocationListDict;

@property(strong,nonatomic)TimeSetViewController *timeSetVC;

@property (strong, nonatomic) LogViewController *loginVC;
@property (strong, nonatomic) UpdatedViewController *updateVC;
@property (assign) double latitutApp,longtApp;
@property (strong, nonatomic)  CLGeocoder *geoCoder;

+ (NSString*)decrypt:(NSString*)input;
-(void)UploadEmployeeLog;
-(void)UpdateDeviceId;


@end
