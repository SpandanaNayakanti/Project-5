//
//  AppDelegate.m
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "AppDelegate.h"
#import "LEGOEncryptorAES.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation AppDelegate
{
    
}
@synthesize userInfoDict,userAddressDict,loginVC,updateVC,latitutApp,longtApp,userGeoPointListDict;
@synthesize userBannedLocationListDict,Emp_ID,timeSetString,timeSetVC;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    updateVC=[[UpdatedViewController alloc] initWithNibName:@"UpdatedViewController" bundle:[NSBundle mainBundle]];

    loginVC = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle:nil];
    timeSetVC=[[TimeSetViewController alloc]initWithNibName:@"TimeSetViewController" bundle:nil ];
//    UINavigationController *navigationController = [[UINavigationController alloc]  initWithRootViewController:loginVC];
    
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    [self RefreshLocation];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound ];
    //timeSetString=@"30 minutes";
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    
    NSString* newToken = [deviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceTokenN=newToken;
    //NSLog(@"My token is: %@", newToken);
    
}
-(void)UpdateDeviceId
{
    NSString *urlString1 = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/updatedeviceid?empid=%@&deviceid=%@&devicetoken=%@&iphone=1",Emp_ID,[OpenUDID value],deviceTokenN];
    //NSLog(@"urlstring1......%@",urlString1);
    NSURL *URL = [NSURL URLWithString:[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *tempdict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
     NSLog(@"tempdict %@",tempdict);

}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo %@",userInfo);
    
    application.applicationIconBadgeNumber = 0;
//	NSString *reminderText = [notification.userInfo
//							  objectForKey:kRemindMeNotificationDataKey];
//	[secondViewController showReminder:reminderText];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"did Fail To RegisterForRemoteNotificationsWithError: %@" ,error);
}
-(void)RefreshLocation
{
    locationManager  = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    [locationManager startUpdatingLocation];

}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
   
 [locationManager stopUpdatingLocation];
   
    //[self performSelectorInBackground:@selector(FindAddress:) withObject:newLocation];
     [self FindAddress:newLocation];
    
    
}
-(void)FindAddress:(CLLocation*)newLocation
{
    latitutApp = newLocation.coordinate.latitude;
    longtApp = newLocation.coordinate.longitude;
    
    NSString *urlString1 = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/xml?latlng=%f,%f&sensor=true",latitutApp,longtApp];
    NSLog(@"urlstring1......%@",urlString1);
    NSURL *URL = [NSURL URLWithString:[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    //NSLog(@"string1......%@",string);
    NSDictionary *tempdict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    userAddressDict=[[tempdict valueForKey:@"result"] objectAtIndex:0];
}

-(void)UploadEmployeeLog
{
      NSLog(@"userAddressDict: %@", userAddressDict);
        NSMutableArray *arrAddress=[userAddressDict valueForKey:@"address_component"];
    NSLog(@"%lu",(unsigned long)arrAddress.count);
        for (int i=0; i<arrAddress.count; i++)
        {
        NSLog(@"arrAddressat=%@",[arrAddress objectAtIndex:i]);
        NSDictionary *tempDict=[arrAddress objectAtIndex:i];
        NSString *type=[[tempDict valueForKey:@"type"] description];
        if ([type rangeOfString:@"postal_code"].location != NSNotFound) {
            postal_code=[tempDict valueForKey:@"long_name"];
        }
        if ([type rangeOfString:@"locality"].location != NSNotFound) {
            city=[tempDict valueForKey:@"long_name"];
        }
        if ([type rangeOfString:@"administrative_area_level_1"].location != NSNotFound) {
            state=[tempDict valueForKey:@"long_name"];
        }

        if ([type rangeOfString:@"country"].location != NSNotFound) {
            country=[tempDict valueForKey:@"long_name"];
        }

    }
   
    NSString *urlString1 = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeelog?latitude=%f&longitude=%f&empid=%@&orgid=%@&city=%@&state=%@&country=%@&zipcode=%@&location=%@&iphone=1",latitutApp,longtApp,[userInfoDict valueForKey:@"id"],loginVC.textOrgid.text,city,state,country,postal_code,[userAddressDict valueForKey:@"formatted_address"]];
    NSURL *URL = [NSURL URLWithString:[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSLog(@"urlstring1kk......%@",urlString1);
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *tempdict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"postal_code: %@", tempdict);

}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	//NSLog(@"Error occured %@",[error localizedDescription]);
}

+ (NSString*)decrypt:(NSString*)input
{
    if (input.length<1) {
        return @"";
    }
    
    NSString* str = [LEGOEncryptorAES decryptBase64String:input keyString:uniqueKey];
    if (str) {
        //NSLog(@"decrypted: %@", str);
    }
    else
    {
        str = @"(failed to decrypt)";
    }
    NSLog(@"encrypted: %@",str);
    return str;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
