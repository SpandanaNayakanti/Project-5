//
//  LogViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "LogViewController.h"
#import "UpdatedViewController.h"
#import "XMLDictionary.h"
#import "AppDelegate.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface LogViewController ()
{
    IBOutlet UIView *backGroundView_;
    NSMutableDictionary *dictmail;
    
}

@end

//184.168.101.168/workforcetracker/services/updatedeviceid?empid=%@&deviceid=%@&registrationID=%@&iphone=1
@implementation LogViewController
@synthesize textOrgid;
@synthesize textpass,textuser;
@synthesize delegate;
@synthesize rememberbtn;
@synthesize remember;
@synthesize ifInsideBannedLocation,ifEmpReached;
@synthesize currentday1,currenttime;

NSMutableArray *geoPointDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    dictmail=[[NSMutableDictionary alloc]init];
    
    backGroundView_.backgroundColor=[UIColor clearColor];
    
    ifInsideBannedLocation=NO;
    ifEmpReached=NO;
    self.navigationController.navigationBar.hidden = YES;
    [super viewDidLoad];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if(IS_IPHONE_5)
        {
            
            //self.imgView.frame=CGRectMake(27, 540, 265, 35);
            
        }
        else
        {
            self.imgView.frame=CGRectMake(27, 445, 265, 35);
           
        }
    }
    UIColor *color = [UIColor whiteColor];
    textOrgid.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Organisation ID" attributes:@{NSForegroundColorAttributeName: color}];
    textuser.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    textpass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self SetLeftView:textuser];
    [self SetLeftView:textpass];
    [self SetLeftView:textOrgid];
    if ([self.remember isEqualToString:@"TRUE"]) {
		self->rememberbtn.selected = YES;
//		[self SignAction:nil];
        
	}
	else {
		self->rememberbtn.selected = NO;
		
	}
	
	self->textOrgid.delegate = self;
	self->textOrgid.returnKeyType = UIReturnKeyNext;
	self->textOrgid.autocorrectionType = UITextAutocorrectionTypeNo;
	
	self->textpass.delegate = self;
	self->textpass.returnKeyType = UIReturnKeyDone;
	self->textpass.autocorrectionType = UITextAutocorrectionTypeNo;
	
	[self->rememberbtn setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
   // NSLog(@"rememberbtn: %@", rememberbtn);
	[self->rememberbtn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    

    [self ReadCredentials];
 
    // Do any additional setup after loading the view from its nib.
}
- (void) drawPlaceholderInRect:(CGRect)rect {
    [[UIColor grayColor] setFill];
   // [[textOrgid.placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16]];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
-(void)SaveCredentials
{
    //[self->pr startAnimating];

    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	//	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Userinfo.plist"];
	success = [fileManager fileExistsAtPath:writableDBPath];
    if ([self IsValidatedTextFields]) {
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]init];
        [tempDict setObject:textOrgid.text forKey:@"orgid"];
        [tempDict setObject:textuser.text forKey:@"user"];
        [tempDict setObject:textpass.text forKey:@"passwd"];
        [tempDict writeToFile:writableDBPath atomically:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Text Field empty" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
}

- (void)ReadCredentials
{
    //[self->pr startAnimating];

    NSFileManager *fileManager = [NSFileManager defaultManager];
	//	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Userinfo.plist"];
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
	if (success)
	{
        NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]initWithContentsOfFile:writableDBPath];
        textOrgid.text=[tempDict objectForKey:@"orgid"];
        textuser.text=[tempDict objectForKey:@"user"];
        textpass.text=[tempDict objectForKey:@"passwd"];
        rememberbtn.selected=TRUE;
	}
}
-(void)RemoveAllCredentials
{
    //[self->pr startAnimating];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Userinfo.plist"];
    BOOL success = [fileManager fileExistsAtPath:writableDBPath];
	if (success)
	{
        [fileManager removeItemAtPath:writableDBPath error:&error];
    }
}
-(void)SetLeftView:(UITextField*)txtfieldN
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtfieldN.frame.size.height)];
    leftView.backgroundColor = txtfieldN.backgroundColor;
    txtfieldN.leftView = leftView;
    txtfieldN.leftViewMode = UITextFieldViewModeAlways;
    txtfieldN.delegate=self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textOrgid resignFirstResponder];
    [textpass resignFirstResponder];
    [textuser resignFirstResponder];
    return YES;
}
-(IBAction)CancelAction
{
    textOrgid.text=@"";
    textpass.text=@"";
    textuser.text=@"";
    exit(0);
}
-(BOOL)IsValidatedTextFields
{
    if ([textuser.text length]<1) {
        return FALSE;
    }
    if ([textpass.text length]<1) {
        return FALSE;
    }
    if ([textOrgid.text length]<1) {
        return FALSE;
    }
    return TRUE;
}
-(IBAction)SignAction
{
    //[activityIndi startAnimating];
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(ShowNextController) withObject:nil afterDelay:0.1f];


}
-(void)ShowNextController
{
    if ([self IsValidatedTextFields]) {
        if (rememberbtn.selected) {
            [self SaveCredentials];
            
        }
        else if (!rememberbtn.selected)
        {
            [self RemoveAllCredentials];
        }
        
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/login?username=%@&iphone=1&password=%@&orgid=%@",textuser.text,textpass.text,textOrgid.text];
        
        NSURL *URL = [[NSURL alloc] initWithString:subURL];
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
        
        appDelegate.userInfoDict = [[[NSDictionary dictionaryWithXMLString:string] mutableCopy] valueForKey:@"employeeinfo"];
        
        id forminfo=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"forminfo"];
        
        appDelegate.formsArry=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in forminfo)
        {
            if ([[dict valueForKey:@"status"] integerValue]==1)
            {
                [appDelegate.formsArry addObject:dict];
            }
            
        }
        NSLog(@"%lu",(unsigned long)appDelegate.formsArry.count);
        //NSLog(@"%@",forminfo);
         NSLog(@"Login: %@", appDelegate.userInfoDict);
        appDelegate.Emp_ID=[appDelegate.userInfoDict valueForKey:@"id"];
//        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
//        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
//        if (networkStatus == NotReachable)
//        {
//            NSLog(@"There IS NO internet connection");
//        }
        
        
        if ([appDelegate.userInfoDict allKeys].count>0) {
            //[self.navigationController pushViewController:updateVC animated:YES];
            
//            NSLog(@"111");
            //[self.navigationController pushViewController:appDelegate.updateVC animated:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                 [self presentViewController:appDelegate.updateVC animated:YES completion:nil];
                
            });
            
           
//            [activityIndi stopAnimating];
            [appDelegate performSelector:@selector(UpdateDeviceId) withObject:nil afterDelay:.1];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
//            NSLog(@"222");
            
            [activityIndi stopAnimating];
        }
    }
    else
    {
        if (textOrgid.text.length==0 && textuser.text.length!=0 && textpass.text.length!=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter orgid" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [activityIndi stopAnimating];
        }
        else if  (textOrgid.text.length!=0 && textuser.text.length==0 && textpass.text.length!=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter user name" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [activityIndi stopAnimating];
        }
        else if (textOrgid.text.length!=0 && textuser.text.length!=0 && textpass.text.length==0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter password" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [activityIndi stopAnimating];
        }
        else
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter all the credentials" message:@" Please Enter orgid/username and password " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
//        NSLog(@"333");
        
        [activityIndi stopAnimating];
    }
    }
    //Hit location update service 25 Feb
    //  NSString *fullAddress=@"";
    if (![appDelegate.userInfoDict count]==0) {
        
        NSMutableArray *arrAddress=[appDelegate.userAddressDict valueForKey:@"address_component"];
        for (int i=0; i<arrAddress.count; i++) {
            //NSLog(@"arrAddressat=%@",[arrAddress objectAtIndex:i]);
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
        
        /// code for settings start
        NSString *urlString1 = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeelog?latitude=%@&longitude=%@&empid=%@&orgid=%@&city=%@&state=%@&country=%@&zipcode=%@&location=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"latitude"],[appDelegate.userInfoDict valueForKey:@"longitude"],appDelegate.Emp_ID,textOrgid.text,city,state,country,postal_code,[appDelegate.userAddressDict valueForKey:@"formatted_address"]];
        NSLog(@"urlString1s %@",urlString1);
        NSURL *URL = [NSURL URLWithString:[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    [[NSDictionary dictionaryWithXMLString:string] mutableCopy];

        //[appDelegate.timeSetVC TimerActionInitiate];
       // [appDelegate performSelector:@selector(UploadEmployeeLog) withObject:nil afterDelay:30.0];
        /// code for settings end
        
        NSString *subURLForlocation=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/locationupdate?latitude=%@&longitude=%@&empid=%@&location=%@&iphone1",[appDelegate.userInfoDict valueForKey:@"latitude"],[appDelegate.userInfoDict valueForKey:@"longitude"],appDelegate.Emp_ID,[appDelegate.userAddressDict valueForKey:@"formatted_address"]];
        NSLog(@"%@",subURLForlocation);
        NSLog(@"appDelegate.Emp_ID %@",appDelegate.Emp_ID);
        
        NSURL *URL_location = [NSURL URLWithString:[subURLForlocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        NSString *string_location = [[NSString alloc] initWithContentsOfURL:URL_location encoding:NSUTF8StringEncoding error:NULL];
        NSDictionary *locationUpdateDict = [[NSDictionary dictionaryWithXMLString:string_location] mutableCopy];
        NSLog(@"locationUpdateDict11=%@",locationUpdateDict);
        //Ends here
        
        
        //ASP
        //NSString *testEmpID=@"7";
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeegeopointlist?empid=%@&iphone=1",appDelegate.Emp_ID];
        
        NSURL *URL1 = [[NSURL alloc] initWithString:subURL];
        NSString *string1 = [[NSString alloc] initWithContentsOfURL:URL1 encoding:NSUTF8StringEncoding error:NULL];
        geoPointDict=[[NSDictionary dictionaryWithXMLString:string1] valueForKey:@"empgeopoint"];
        
//        NSLog(@"geoPointDict=%@",geoPointDict);
        
//        [self performSelector:@selector(CheckGeoPoint:) withObject:geoPointDict afterDelay:0.1f];
//        timerGeoPointSend=[NSTimer scheduledTimerWithTimeInterval:0.7
//                                         target:self
//                                       selector:@selector(CheckGeoPoint:)
//                                       userInfo:geoPointDict
//                                        repeats:NO];
        
        timerGeopoint=[NSTimer scheduledTimerWithTimeInterval:240.0 target:self selector:@selector(employeegeopointlist:) userInfo:geoPointDict repeats:YES];

        //Gep points listion ends here
        
        //ASP 24 Feb
        //Get info dict for banned locations
        
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HH:mm:ss"];
//        NSString *CurrentTimeHr=[dateFormatter stringFromDate:[NSDate date]];
        
        NSString *subURL12=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeebannedpointlist?orgid=%@&iphone=1",textOrgid.text];
        
        
        NSURL *URLB = [[NSURL alloc] initWithString:subURL12];
        NSString *stringBanned = [[NSString alloc] initWithContentsOfURL:URLB encoding:NSUTF8StringEncoding error:NULL];
          id empBannedPTDict=[[NSDictionary dictionaryWithXMLString:stringBanned] valueForKey:@"empbannedpoint"];
        arrBanndUpdated=[[NSMutableArray alloc]init];
        if([empBannedPTDict isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *dict in empBannedPTDict) {
                NSMutableDictionary *dictTemp=[[NSMutableDictionary alloc]initWithDictionary:dict];
                [dictTemp setObject:@"0" forKey:@"empReachd"];
                [arrBanndUpdated addObject:dictTemp];
            }

        }
        else if([empBannedPTDict isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dictTemp=[empBannedPTDict mutableCopy];
            [dictTemp setObject:@"0" forKey:@"empReachd"];
            arrBanndUpdated=[[NSMutableArray alloc]initWithObjects:dictTemp, nil];
        }
//        NSLog(@"arrBanndUpdated=%@",arrBanndUpdated);
//          [self performSelectorInBackground:@selector(CheckGeoPointForBanned:) withObject:nil];
//        [self performSelector:@selector(CheckGeoPointForBanned:) withObject:arrBanndUpdated afterDelay:0.1f];
        timerBannedPoint=[NSTimer scheduledTimerWithTimeInterval:0.5
                                                           target:self
                                                         selector:@selector(CheckGeoPointForBanned:)
                                                         userInfo:arrBanndUpdated
                                                          repeats:YES];

    }

}

// refresh employeeBannedPointlist automatically

-(void)employeeBannedPointlist:(NSTimer*)theTimer
{
//    NSLog(@"employeeBannedPointlist");
    NSString *subURL12=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeebannedpointlist?orgid=%@&iphone=1",textOrgid.text];
    
    
    NSURL *URLB = [[NSURL alloc] initWithString:subURL12];
    NSString *stringBanned = [[NSString alloc] initWithContentsOfURL:URLB encoding:NSUTF8StringEncoding error:NULL];
    id empBannedPTDict=[[NSDictionary dictionaryWithXMLString:stringBanned] valueForKey:@"empbannedpoint"];
    arrBanndUpdated=[[NSMutableArray alloc]init];
    if([empBannedPTDict isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dict in empBannedPTDict) {
            
            NSMutableDictionary *dictTemp=[[NSMutableDictionary alloc]initWithDictionary:dict];
            if ([[[dictTemp valueForKey:@"fence_status"] description] isEqualToString:@"0"]) {
                [dictTemp setObject:@"0" forKey:@"empReachd"];
            }else if ([[[dictTemp valueForKey:@"fence_status"] description] isEqualToString:@"1"]){
                [dictTemp setObject:@"1" forKey:@"empReachd"];
            }else if ([[[dictTemp valueForKey:@"fence_status"] description] isEqualToString:@"2"]){
                [dictTemp setObject:@"2" forKey:@"empReachd"];
            }
            //[dictTemp setObject:@"0" forKey:@"empReachd"];
            [arrBanndUpdated addObject:dictTemp];
        }
        
    }
    else if([empBannedPTDict isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *dictTemp=[empBannedPTDict mutableCopy];
        //[dictTemp setObject:@"0" forKey:@"empReachd"];
        arrBanndUpdated=[[NSMutableArray alloc]initWithObjects:dictTemp, nil];
    }
//    NSLog(@"arrBanndUpdated=%@",arrBanndUpdated);
//      [self performSelectorInBackground:@selector(CheckGeoPointForBanned:) withObject:nil];
//    [self performSelector:@selector(CheckGeoPointForBanned:) withObject:arrBanndUpdated afterDelay:0.1f];
    timerBannedPoint=[NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(CheckGeoPointForBanned:)
                                                    userInfo:arrBanndUpdated
                                                     repeats:YES];
}

// refresh employeegeopointlist automatically

-(void)employeegeopointlist: (NSTimer*)theTimer
{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
                NSLog(@"There IS NO internet connection");
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"There is no internet connection" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        [alert show];
        
    }
    else
    {
//    NSLog(@"employeegeopointlist");
    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeegeopointlist?empid=%@&iphone=1",appDelegate.Emp_ID];
    
    NSURL *URL1 = [[NSURL alloc] initWithString:subURL];
    NSString *string1 = [[NSString alloc] initWithContentsOfURL:URL1 encoding:NSUTF8StringEncoding error:NULL];
    NSArray *geoPointDict=[[NSDictionary dictionaryWithXMLString:string1] valueForKey:@"empgeopoint"];
//    NSLog(@"geoPointDict=%@",geoPointDict);
//    [self performSelectorInBackground:@selector(CheckGeoPoint:) withObject:nil];
//    [self performSelector:@selector(CheckGeoPoint:) withObject:geoPointDict afterDelay:0.1f];
    timerGeoPointSend=[NSTimer scheduledTimerWithTimeInterval:0.7
                                                       target:self
                                                     selector:@selector(CheckGeoPoint:)
                                                     userInfo:geoPointDict
                                                      repeats:NO];

}
}
- (NSDateFormatter*)stringDateFormatter
{
    static NSDateFormatter* formatter = nil;
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
    }
    return formatter;
}

- (NSDate*)stringDateFromString:(NSString*)string
{
    return [[self stringDateFormatter] dateFromString:string];
}

- (NSString*)stringDateFromDate:(NSDate*)date
{
    return [[self stringDateFormatter] stringFromDate:date];
}

-(void)CheckGeoPoint:(NSTimer*)theTimer
{
    id geoPoints = [theTimer userInfo];

    if([geoPoints isKindOfClass:[NSArray class]])
    {
    }
    else if([geoPoints isKindOfClass:[NSDictionary class]])
    {
        geoPoints=[[NSArray alloc]initWithObjects:geoPoints, nil];
    }
    for (NSDictionary *gpDict in geoPoints)
    {
        double latitudeFromServer =[[[gpDict valueForKey:@"latitude"] description] doubleValue];
        double longitudeFromServer =[[[gpDict valueForKey:@"longitude"] description] doubleValue];
        CLLocation *officeLoc = [[CLLocation alloc] initWithLatitude:latitudeFromServer longitude:longitudeFromServer];//
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:[self getLocation].latitude longitude:[self getLocation].longitude];//
        CLLocationDistance distanceInMeter = [officeLoc distanceFromLocation:currentLoc];
//        NSLog(@"CheckGeoPoint distanceInMeter=%f",distanceInMeter);
        
            NSString *time_from=[[gpDict valueForKey:@"time_from"] description];
            NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
            [df1 setDateFormat:@"hh:mm a"];
            NSDate *dttime_from = [df1 dateFromString:time_from];
            
            NSString *time_to=[[gpDict valueForKey:@"time_to"] description];
            [df1 setDateFormat:@"hh:mm a"];
            NSDate *dttime_to = [df1 dateFromString:time_to];

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH:mm"];
             NSString *finalToHr=[dateFormatter stringFromDate:dttime_to];
 
        
        dateFormatter.dateFormat = @"HH";
        int hoursfrom = [[dateFormatter stringFromDate:dttime_from] intValue];
        dateFormatter.dateFormat = @"mm";
        int minutes1from = [[dateFormatter stringFromDate:dttime_from] intValue];
        dateFormatter.dateFormat = @"ss";
        int secondsfrom = [[dateFormatter stringFromDate:dttime_from] intValue];
        
        float timeInMinutesFrom = hoursfrom * 60 + minutes1from + secondsfrom / 60.0;
        
        
        NSLog(@"%f",timeInMinutesFrom);
        
        
        dateFormatter.dateFormat = @"HH";
        int hoursto = [[dateFormatter stringFromDate:dttime_to] intValue];
        dateFormatter.dateFormat = @"mm";
        int minutes1to = [[dateFormatter stringFromDate:dttime_to] intValue];
        dateFormatter.dateFormat = @"ss";
        int secondsto = [[dateFormatter stringFromDate:dttime_to] intValue];
        
        float timeInMinutesto = hoursto * 60 + minutes1to + secondsto / 60.0;
        
        
        NSLog(@"%f %f",timeInMinutesFrom,timeInMinutesto);
        
        dateFormatter.dateFormat = @"HH";
        int hourscuurent = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        dateFormatter.dateFormat = @"mm";
        int minutescuurent = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        dateFormatter.dateFormat = @"ss";
        int secondscurrent = [[dateFormatter stringFromDate:[NSDate date]] intValue];
        
        float timeInMinutescurrent = hourscuurent * 60 + minutescuurent + secondscurrent / 60.0;
        
        
           NSLog(@"%f %f %f",timeInMinutesFrom,timeInMinutesto,timeInMinutescurrent);
        
//            NSLog(@"finalFromHr =%@",finalFromHr);
            NSLog(@"finalToHr =%@",finalToHr);
//            NSLog(@"CurrentTimeHr =%@",CurrentTimeHr);
//        


        
        
            if ((distanceInMeter<=[[[gpDict valueForKey:@"distance"]description] integerValue]) &&(timeInMinutescurrent>=timeInMinutesFrom ) && (timeInMinutescurrent<=timeInMinutesto) && !ifEmpReached)
            {
                
                NSString* geoID=[gpDict valueForKey:@"id"];
                NSString* alertStatus= @"1";
                NSString* status=@"Reached";
                NSDictionary *wrapper = [NSDictionary dictionaryWithObjectsAndKeys:geoID, @"geoid", status, @"status",alertStatus, @"alert_status", nil];
//                NSLog(@"wrapper=%@",wrapper);
                [self performSelector:@selector(GeoPointSendAction:) withObject:wrapper afterDelay:.1];

            }
            else if (distanceInMeter>=[[[gpDict valueForKey:@"distance"]description] integerValue] && timeInMinutesto>=timeInMinutescurrent  && ifEmpReached)
            {
                
                NSString* geoID=[gpDict valueForKey:@"id"];
                NSString* alertStatus= @"3";
                NSString* status=@"Left";
                NSDictionary *wrapper = [NSDictionary dictionaryWithObjectsAndKeys:geoID, @"geoid", status, @"status",alertStatus, @"alert_status", nil];
//                NSLog(@"wrapper=%@",wrapper);
                [self performSelector:@selector(GeoPointSendAction:) withObject:wrapper afterDelay:.1];
                
            }
        else if ((distanceInMeter>[[[gpDict valueForKey:@"distance"]description] integerValue]) && (timeInMinutescurrent>=timeInMinutesFrom ) && (timeInMinutescurrent<=timeInMinutesto) )
            
                 {
                     NSString* geoID=[gpDict valueForKey:@"id"];
                     NSString* alertStatus= @"2";
                     NSString* status=@"UnReached";
                     NSDictionary *wrapper = [NSDictionary dictionaryWithObjectsAndKeys:geoID, @"geoid", status, @"status",alertStatus, @"alert_status", nil];
                     //                NSLog(@"wrapper=%@",wrapper);
                     [self performSelector:@selector(GeoPointSendAction:) withObject:wrapper afterDelay:.1];
                     
                 }

    }
//    [self performSelectorInBackground:@selector(employeeBannedPointlist:) withObject:nil];
//    [self performSelector:@selector(employeeBannedPointlist:) withObject:arrBanndUpdated afterDelay:0.1f];
//    timerBannedPoint=[NSTimer scheduledTimerWithTimeInterval:0.9
//                                                      target:self
//                                                    selector:@selector(employeeBannedPointlist:)
//                                                    userInfo:arrBanndUpdated
//                                                     repeats:YES];

}
-(void)CheckGeoPointForBanned:(NSTimer*)theTimer
{
   
    for (int i=0; i<[arrBanndUpdated count]; i++) {
        NSMutableDictionary *gpDict=[[NSMutableDictionary alloc]initWithDictionary:[arrBanndUpdated objectAtIndex:i]];
//        NSLog(@"EMPREACHED=%@",[gpDict valueForKey:@"empReachd"]);
        
        double latitudeFromServer =[[[gpDict valueForKey:@"latitude"] description] doubleValue];
        double longitudeFromServer =[[[gpDict valueForKey:@"longitude"] description] doubleValue];
        CLLocation *officeLoc = [[CLLocation alloc] initWithLatitude:latitudeFromServer longitude:longitudeFromServer];//
        CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:[self getLocation].latitude longitude:[self getLocation].longitude];//
        CLLocationDistance distanceInMeter = [officeLoc distanceFromLocation:currentLoc];
        NSString *distanceFromServ=[[gpDict valueForKey:@"distance"] description];
//        NSLog(@"CheckGeoPointForBanned distanceInMeter=%f",distanceInMeter);
        

        
            NSString *time_from=[[gpDict valueForKey:@"time_from"] description];
            NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
            [df1 setDateFormat:@"hh:mm a"];
            NSDate *dttime_from = [df1 dateFromString:time_from];
        
        
            NSString *time_to=[[gpDict valueForKey:@"time_to"] description];
            [df1 setDateFormat:@"hh:mm a"];
            NSDate *dttime_to = [df1 dateFromString:time_to];
        
        
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"HH"];

            NSString *finalFromHr=[dateFormatter stringFromDate:dttime_from];
            NSString *finalToHr=[dateFormatter stringFromDate:dttime_to];
            NSString *CurrentTimeHr=[dateFormatter stringFromDate:[NSDate date]];
            
//            NSLog(@"finalFromHr =%@",finalFromHr);
//            NSLog(@"finalToHr =%@",finalToHr);
//            NSLog(@"CurrentTimeHr =%@",CurrentTimeHr);
        
        
        if ([[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"2"] && (distanceInMeter>=distanceFromServ.intValue))
        {
            return;
        }
        if ([[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"1"] && (distanceInMeter<=distanceFromServ.intValue))
        {
            return;
        }
            
            if ([time_from isEqualToString:@" "] || (time_from == NULL)  || [time_from isEqualToString:@"NULL"])
            {
                if ((distanceInMeter<=distanceFromServ.intValue) &&  [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"0"])
                {
                    NSString* bannedID=[gpDict valueForKey:@"id"];
                    NSString* alertStatus= @"1";
                    NSString* status=@"Reached";
                    NSString* empReachd=@"1";

                    if ([[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"3"] || [[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"0"]) {
                        NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status", @"empReachd" , empReachd , nil];

                        [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:0.1];
                        [gpDict setObject:empReachd forKey:@"empReachd"];
                        [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];
                        //[self CreateAlert:@"Reached"];
                        
                    }
                }
                else if ((distanceInMeter>=distanceFromServ.intValue) &&  [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"1"])
                {
                    NSString* bannedID=[gpDict valueForKey:@"id"];
                    NSString* alertStatus= @"3";
                    NSString* status=@"Left";
                    NSString* empReachd=@"2";
                    
                    if ([[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"3"] || [[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"1"]) {
                        NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status",  @"empReachd" , empReachd ,nil];
                        
                        [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:.1];
                        [gpDict setObject:empReachd forKey:@"empReachd"];
                        [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];

                       // [self CreateAlert:@"leaved"];

                    }
                }
                else if ((distanceInMeter>=distanceFromServ.intValue) &&  [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"2"])
                {
                    NSString* bannedID=[gpDict valueForKey:@"id"];
                    NSString* alertStatus= @"1";
                    NSString* status=@"Reached";
                    NSString* empReachd=@"1";
                    
                    if ([[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"3"] || [[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"0"]) {
                        NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status",  @"empReachd" , empReachd ,nil];
                        
                        [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:.1];
                        [gpDict setObject:empReachd forKey:@"empReachd"];
                        [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];
                        
                        // [self CreateAlert:@"leaved"];
                        
                    }
                }
                else if ((distanceInMeter>=distanceFromServ.intValue) &&  [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"0"])
                {
                    NSString* bannedID=[gpDict valueForKey:@"id"];
                    NSString* alertStatus= @"3";
                    NSString* status=@"Left";
                    NSString* empReachd=@"2";
                    
                    if ([[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"3"] || [[[gpDict valueForKey:@"alert_require"] description] isEqualToString:@"1"]) {
                        NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status",  @"empReachd" , empReachd ,nil];
                        
                        [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:.1];
                        [gpDict setObject:empReachd forKey:@"empReachd"];
                        [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];
                        
                        // [self CreateAlert:@"leaved"];
                        
                    }
                }


            }
            
            if ((distanceInMeter<=distanceFromServ.intValue) &&(finalFromHr.intValue==CurrentTimeHr.intValue ) && ([[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"0"] || [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"2"])) {
                
                NSString* bannedID=[gpDict valueForKey:@"id"];
                NSString* alertStatus= @"1";
                NSString* status=@"Reached";
                NSString* empReachd=@"1";
                
                NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status",  @"empReachd" , empReachd ,nil];
                
                [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:.1];
                [gpDict setObject:empReachd forKey:@"empReachd"];
                [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];
                //[self CreateAlert:@"Reached"];

            }
            else if ((distanceInMeter>100) && (finalToHr.intValue<=CurrentTimeHr.intValue ) && ([[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"0"] || [[[gpDict valueForKey:@"empReachd"] description] isEqualToString:@"1"])) {
                
                NSString* bannedID=[gpDict valueForKey:@"id"];
                NSString* alertStatus= @"3";
                NSString* status=@"Left";
                NSString* empReachd=@"2";
                
                NSDictionary *banndict = [NSDictionary dictionaryWithObjectsAndKeys:bannedID, @"Bannedid", status, @"status",alertStatus, @"alert_status",  @"empReachd" , empReachd ,nil];
                
                [self performSelector:@selector(BannedPointSendAlert:) withObject:banndict afterDelay:.1];
                [gpDict setObject:empReachd forKey:@"empReachd"];
                [arrBanndUpdated replaceObjectAtIndex:i withObject:gpDict];
               // [self CreateAlert:@"leaved"];

                
            }
            
    }
    
    

}

-(void)BannedPointSendAlert:(NSDictionary*)wrapper{
    
     NSLog(@"Received wrapper=%@",wrapper);
    NSString * empReach_status ;
    NSString * bannnedID = [wrapper objectForKey:@"Bannedid"];
    NSString * status = [wrapper objectForKey:@"status"];
    NSString * alert_status = [wrapper objectForKey:@"alert_status"];
    if ([status isEqualToString:@"Reached"]) {
        empReach_status = @"1";
    }else if ([status isEqualToString:@"Left"]){
        empReach_status = @"2";
    }
   
//    NSLog(@"empReach_status=%@",empReach_status);
    
    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeebannedpointlog?empid=%@&bannedid=%@&status=%@&alert_status=%@&orgid=%@&fence_status=%@&iphone=1",appDelegate.Emp_ID,bannnedID,status,alert_status,textOrgid.text,empReach_status];
   // NSLog(@"bannedPointSendAlert1=%@",subURL);

    NSURL *URL = [[NSURL alloc] initWithString:subURL];
    //NSURL * URL =  [NSURL URLWithString:subURL];
    //NSURL *URL = [NSURL fileURLWithPath:subURL];
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *bannedPointSendm = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"bannedPointSendAlert=%@",bannedPointSendm);
    
    
}
-(void)GeoPointSendAction:(NSDictionary*)wrapper
{
    if (ifEmpReached)
    {
        [timerGeoPointSend invalidate];
        ifEmpReached=!ifEmpReached;
    }
   if ([[dictmail objectForKey:[wrapper objectForKey:@"geoid"]] isEqualToString:@"Reached"] || [[dictmail objectForKey:[wrapper objectForKey:@"geoid"]] isEqualToString:@"Left"] )
        
    {
        NSLog(@"hai");
    }
    else
    {
    
    NSLog(@"wrapper=%@",wrapper);
    NSString * geoid = [wrapper objectForKey:@"geoid"];
    NSString * status = [wrapper objectForKey:@"status"];
    NSString * alert_status = [wrapper objectForKey:@"alert_status"];

    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeegeopointlog?empid=%@&geoid=%@&status=%@&alert_status=%@&orgid=%@&iphone=1",appDelegate.Emp_ID,geoid,status,alert_status,textOrgid.text];
    NSLog(@"subURL=%@",subURL);

    NSURL *URL = [[NSURL alloc] initWithString:subURL];
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *GeoPointSendAlert = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"GeoPointSendAlert=%@",GeoPointSendAlert);
    if ([[GeoPointSendAlert valueForKey:@"error"] isEqualToString:@"0"])
    {
        [dictmail setObject:[wrapper objectForKey:@"status"] forKey:[wrapper objectForKey:@"geoid"]];
    }
    
    }
    
    
    
    
 
    
}

-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init] ;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    //NSLog(@"*dLatitude : %@", latitude);
    //NSLog(@"*dLongitude : %@",longitude);
    
    
    return coordinate;
}


-(IBAction)RememberAction:(id)sender
{
    UIButton *tmpButton = (UIButton *)sender;
   // NSLog(@"tmpButton.selected=%d",tmpButton.selected);

	tmpButton.selected = (tmpButton.selected) ?NO :YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)shouldAutorotate
{
    return NO;
}

@end
