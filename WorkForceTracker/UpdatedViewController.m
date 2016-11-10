//
//  UpdatedViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 03/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "UpdatedViewController.h"
#import "StatusViewController.h"
#import "CustomPopoverBackgroundView.h"
#import "TimeSheetViewController.h"
#import "SettingViewController.h"
#import "ScheduleJobsViewController.h"
#import "TableStatusVC.h"
#import "XMLDictionary.h"
#import "WFTUserModel.h"
#import "AppDelegate.h"
#import "CustomViewController.h"
#import "FiledDataActionViewController.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface UpdatedViewController ()
{
    NSMutableArray *arrayModels_;
    WFTUserModel *model_;
    ScheduleJobsViewController *scheduleViewCont_;
    CustomViewController *CVC;
    FiledDataActionViewController *FDAVC;
    UIActionSheet *actionSheet_;
    UIDatePicker *datePicker_;
    int height;
}

@end

@implementation UpdatedViewController
bool isShown = false;

@synthesize popOverController,rView,bglat,bglong,finaladdress;
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
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    
     self.scrollView2.contentInset = UIEdgeInsetsMake(-67, 0, 0, 0);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if(IS_IPHONE_5)
        {
            
            self.scrollView2.frame = CGRectMake(0, 67, 320, 510);
            self.scrollView2.contentSize=CGSizeMake(320, 720);
            
        }
        else
        {
            
            self.scrollView2.frame = CGRectMake(0, 67, 320, 410);
            self.scrollView2.contentSize=CGSizeMake(320, 720);
        }
    }
    
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.bgTrackLocation  = [[CLLocationManager alloc] init];
    self.bgTrackLocation.delegate = self;
    [self.bgTrackLocation startUpdatingLocation];
    self.emergencyemail=appDelegate.loginVC.textuser.text;
    self.view.userInteractionEnabled = YES;
//    NSString *urlString1 = [NSString stringWithFormat:@"http://www.rapidprotect.net/images/member/robert"];
//	NSData *data = nil;
//	//NSLog(@"Url string %@ and picname is %@",urlString1,[self.loginResponseDic1 objectForKey:@"PICTURE"]);
//	while (!data){
//		//NSLog(@"imagedonload%@",data);
//		data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString1]];
//	}
//    
//	self.selfimage.image = [UIImage imageWithData:data];

//*.......................................................//
//dynamically creating view and buttons for field data action
    
    height=40*appDelegate.formsArry.count;
    
    _formsView=[[UIView alloc]initWithFrame:CGRectMake(60, 200, 200, height)];
    [self.scrollView2 addSubview:_formsView];
    [_formsView setBackgroundColor:[UIColor whiteColor]];
    _formsView.hidden=YES;
    _formsView.layer.cornerRadius=8.0;
    
    for (int i=0; i<[appDelegate.formsArry count]; i++)
    {
        _dynamicBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _dynamicBtn.tag=i;
        NSString *title=[[appDelegate.formsArry objectAtIndex:i] valueForKey:@"form_name"];
        [_dynamicBtn setTitle:[title capitalizedString]  forState:UIControlStateNormal];
        _dynamicBtn.frame=CGRectMake(0, i*40, 200, 40);
           [_dynamicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_formsView addSubview:_dynamicBtn];
        _dynamicBtn.layer.borderWidth=1.0f;
        _dynamicBtn.layer.borderColor=[UIColor grayColor].CGColor;
        [_dynamicBtn addTarget:self action:@selector(creatingForm:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCustomViews)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    //tapGesture.cancelsTouchesInView = NO;
    
    [_scrollView2 addGestureRecognizer:tapGesture];
 //..........................................//
   
    _scheduleView=[[UIView alloc]initWithFrame:CGRectMake(60, 250, 200, 120)];
    [self.scrollView2 addSubview:_scheduleView];
    [_scheduleView setBackgroundColor:[UIColor whiteColor]];
    _scheduleView.hidden=YES;
    _scheduleView.layer.cornerRadius=8.0;
    
    
    _todaysJobBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_todaysJobBtn setTitle:@"Today's Job" forState:UIControlStateNormal];
    [_todaysJobBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_todaysJobBtn setBackgroundColor:[UIColor grayColor]];
    _todaysJobBtn.frame=CGRectMake(0, 0, 200, 40);
    _todaysJobBtn.layer.borderWidth=1.0f;
    _todaysJobBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [_scheduleView addSubview:_todaysJobBtn];
    
    _thisweekJobsBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_thisweekJobsBtn setTitle:@"This Week Jobs" forState:UIControlStateNormal];
    [_thisweekJobsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_thisweekJobsBtn setBackgroundColor:[UIColor grayColor]];
    _thisweekJobsBtn.frame=CGRectMake(0, 40, 200, 40);
    _thisweekJobsBtn.layer.borderWidth=1.0f;
    _thisweekJobsBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [_scheduleView addSubview:_thisweekJobsBtn];
    
    
    _chooseDateBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_chooseDateBtn setTitle:@"Choose Date" forState:UIControlStateNormal];
    [_chooseDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_chooseDateBtn setBackgroundColor:[UIColor grayColor]];
    _chooseDateBtn.frame=CGRectMake(0, 80, 200, 40);
    _chooseDateBtn.layer.borderWidth=1.0f;
    _chooseDateBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [_scheduleView addSubview:_chooseDateBtn];
    
    
  
    _chooseDateView.hidden=YES;
    
    
    
    [_todaysJobBtn addTarget:self action:@selector(fetchingJobs:) forControlEvents:UIControlEventTouchUpInside];
    [_thisweekJobsBtn addTarget:self action:@selector(fetchingJobs:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseDateBtn addTarget:self action:@selector(fetchingJobs:) forControlEvents:UIControlEventTouchUpInside];
    
    [super viewDidLoad];
      self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.hidden = NO;
   

    // Do any additional setup after loading the view from its nib.
}

#pragma mark - dynamicForms

-(void)creatingForm:(id)sender
{
    
    NSLog(@"%@",[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"id"]);
    NSLog(@"%@",[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"form_name"]);
    NSLog(@"%@",[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"table_name"]);
    

    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/form_format?orgid=%@&form_id=%@",[appDelegate.userInfoDict valueForKey:@"orgid"],[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"id"]];
    NSURL *URL=[NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding
                                                         error:NULL];
    id forminfo=[[NSMutableDictionary dictionaryWithXMLString:string] valueForKey:@"forminfo"];
    
    _fielddataActnArry=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in forminfo)
    {
        [_fielddataActnArry addObject:dict];
        NSLog(@"%lu",(unsigned long)_fielddataActnArry.count);
    }
    
    FDAVC=[[FiledDataActionViewController alloc]initWithNibName:@"FiledDataActionViewController" bundle:nil];
    FDAVC.formId=[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"id"];
    FDAVC.form_Name=[[appDelegate.formsArry objectAtIndex:[sender tag]] valueForKey:@"form_name"];
    FDAVC.uiElementsArry=[NSMutableArray arrayWithArray:_fielddataActnArry];
    [self presentViewController:FDAVC animated:YES completion:nil];
    _formsView.hidden=YES;
    
    
}
-(void)hideCustomViews
{
    [_scheduleView setHidden:YES];
    [_formsView setHidden:YES];
    [_chooseDateView setHidden:YES];
    _startDateTxtFld.text=@"";
    _endDateTxtFld.text=@"";

}
-(void)viewDidAppear:(BOOL)animated
{
    activityIndi.hidden=YES;
    [activityIndi stopAnimating];
}
-(void)viewWillAppear:(BOOL)animated
{
      self.navigationItem.hidesBackButton = YES;
      self.navigationController.navigationBar.hidden = NO;
      activityIndi.hidden=YES;
    [activityIndi stopAnimating];

}
-(IBAction)BackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)startDateActn:(id)sender
{
    [self addDatePickerWithDoneAndCancelButton:@"StartDate"];
}

- (IBAction)endDateActn:(id)sender
{
    [self addDatePickerWithDoneAndCancelButton:@"EndDate"];
}

-(IBAction)UpdateAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Updateaction) withObject:nil afterDelay:0.1f];
}
-(void)Updateaction
{
    statusVC =[[StatusViewController alloc]initWithNibName:@"StatusViewController" bundle:[NSBundle mainBundle]];
    
    [self presentViewController:statusVC animated:YES completion:nil];

     [activityIndi stopAnimating];
}
-(IBAction)TimeSheetAction
{
//    UIAlertView* alertDeletePhoto1 = [[UIAlertView alloc] initWithTitle:@"" message:@"Coming Soon" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
//    [alertDeletePhoto1 show];
    TimeSheetViewController *timeSheetVc=[[TimeSheetViewController alloc] initWithNibName:@"TimeSheetViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:timeSheetVc animated:YES completion:nil];
}
-(IBAction)StatusAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Statusaction) withObject:nil afterDelay:0.1f];
}
-(void)Statusaction
{
    TableStatusVC *tableVC=[[TableStatusVC alloc]initWithNibName:@"TableStatusVC" bundle:[NSBundle mainBundle]];
    [self presentViewController:tableVC animated:YES completion:nil];
     [activityIndi stopAnimating];
}
-(IBAction)SettingAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Settingaction) withObject:nil afterDelay:0.1f];
}
-(void)Settingaction
{
    SettingViewController *settingVC=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:settingVC animated:YES completion:nil];
     [activityIndi stopAnimating];
}
-(IBAction)HelpAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Helpaction) withObject:nil afterDelay:0.1f];
}
-(void)Helpaction
{
    
    helpVC=[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:helpVC animated:YES completion:nil];
     [activityIndi stopAnimating];
}
-(IBAction)LocationAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Locationaction) withObject:nil afterDelay:0.1f];
}
-(void)Locationaction
{
    mapVC =[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:mapVC animated:YES completion:nil];
     [activityIndi stopAnimating];
}
-(IBAction)ExitAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Exitaction) withObject:nil afterDelay:0.1f];
}
-(void)Exitaction{
    
    UIAlertView* alertDeletePhoto1 = [[UIAlertView alloc] initWithTitle:@"Exit" message:@"Do you want to exit?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:nil];
    [alertDeletePhoto1 addButtonWithTitle:@"Yes"];
    [alertDeletePhoto1 show];
    alertDeletePhoto1.tag=1111;
   }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1111)
    {
        if(buttonIndex==0)
    {
        //gameState = kGameStateRunning;
        [self loadView];
        [self viewDidLoad];
        [activityIndi stopAnimating];

       // count=0;
    }
    else
    {
        exit(0);
    }
    }
   
}

-(IBAction)AlertAction
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(emergencyAlertClick) withObject:nil afterDelay:0.1f];
}

- (IBAction)JobsAction:(id)sender
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(JobsAction) withObject:nil afterDelay:0.1f];
}
-(void)JobsAction
{
    jobsVC =[[JobsViewController alloc]initWithNibName:@"JobsViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:jobsVC animated:YES completion:nil];
    [activityIndi stopAnimating];
}

- (IBAction)FormsAction:(id)sender
{
//    UIAlertView *alertForms=[[UIAlertView alloc]initWithTitle:nil  message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
//    [alertForms addButtonWithTitle:@"Expense"];
//    [alertForms addButtonWithTitle:@"Mileage"];
//    [alertForms show];
    int tagValue =[sender tag];
	NSLog(@"tagvalue----%d",tagValue);
	if (tagValue == 100)
    {
        
        if (_formsView.hidden)
        {
           	
            [_formsView setHidden:NO];
            
        }else{
            
            [_formsView setHidden:YES];
            
        }
        
	}
	if (tagValue == 0)
    {
		[_formsView setHidden:YES];
        
	}
    NSLog(@"%@",appDelegate.formsArry);
    
    
}

- (IBAction)TrackingAction:(id)sender
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(TrackingController) withObject:nil afterDelay:0.1f];

    
}

- (IBAction)scheduleActn:(id)sender
{
    int tagValue =[sender tag];
	NSLog(@"tagvalue----%d",tagValue);
	if (tagValue == 110)
    {
        
        if (_scheduleView.hidden)
        {
           	
            [_scheduleView setHidden:NO];
            
            
        }else{
            
            [_scheduleView setHidden:YES];
            
        }
        
	}
	if (tagValue == 0)
    {
		[_scheduleView setHidden:YES];
        
	}
    
    
}
#pragma mark send dates
- (IBAction)sendDateActn:(id)sender
{
    if([_startDateTxtFld.text isEqual:@""] || [_endDateTxtFld.text isEqual:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker" message:@"date should not be empty" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
    else
    {
        //days between two different dates
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *startDate1= [formatter dateFromString:_startDateTxtFld.text];
        NSDate *endDate1= [formatter dateFromString:_endDateTxtFld.text];
        
        // This performs the difference calculation
        unsigned flags = NSDayCalendarUnit;
        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate1 toDate:endDate1 options:0];
        if ([difference day]>62)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker" message:@"Difference between Start date and End date should not be greater than 2 months" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
        }
        else
        {
            NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/jobschedules?orgid=%@&empid=%@&startdate=%@&enddate=%@&iphone=1",appDelegate.loginVC.textOrgid.text,appDelegate.Emp_ID,_startDateTxtFld.text,_endDateTxtFld.text];
            
            
            NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding
                                                                 error:NULL];
            NSLog(@"string%@",string);
            
            NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
            NSLog(@"dictionary: %@", userInfoDict);
            id emptask=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"emptask"];
            
            arrayModels_ = [[NSMutableArray alloc] init];
            
            if (emptask)
            {
                NSLog(@"hai1");
                
                
                
                
                if ([emptask isKindOfClass:[NSDictionary class]])
                {
                    NSLog(@"dictionary");
                    NSDictionary *curDict=[[NSDictionary alloc]initWithDictionary:emptask];
                    WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:curDict];
                    [arrayModels_ addObject:model];
                    scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                    [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                    
                    //  return;
                }
                else if ([emptask isKindOfClass:[NSArray class]])
                {
                    NSLog(@"Array");
                    
                    for (NSDictionary *currentDict in emptask)
                    {
                        
                        WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:currentDict];
                        
                        [arrayModels_ addObject:model];
                        NSLog(@"%d",arrayModels_.count);
                        
                        
                        
                    }
                    scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                    [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                    
                    [_scheduleView setHidden:YES];
                }
                
            }
 
        }
        [_chooseDateView setHidden:YES];
        _startDateTxtFld.text=@"";
        _endDateTxtFld.text=@"";
    }
    
}
-(void)TrackingController
{
    trackingViewCont =[[TrackingViewController alloc]initWithNibName:@"TrackingViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:trackingViewCont animated:YES completion:nil];
    //[activityIndi stopAnimating];
    
}
-(void)emergencyAlertClick
{
    [activityIndi stopAnimating];

    
	if ([self.emergencyemail length]) {
		      
        UIImageView *imageView;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            {
                rView= [[RoundedRectView alloc] initWithFrame:CGRectMake(5,25,310,490)];
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,25,310,490)];
                cancelButton.frame =  CGRectMake(5,390,300,40);
                
            }
        }
        
        
        self.rView.tag = 111;
        imageView.image = [UIImage imageNamed:@"Sending-alert-back.png"];
        
        imageView.userInteractionEnabled = YES;
        
        NSArray  *imagesList = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"5.png"],
                                [UIImage imageNamed:@"4.png"],
                                [UIImage imageNamed:@"3.png"],
                                [UIImage imageNamed:@"2.png"],
                                [UIImage imageNamed:@"1.png"], nil];
        
        [cancelButton addTarget:self action:@selector(emergencyClose:) forControlEvents:UIControlEventTouchUpInside];
        //cancelButton.titleLabel.text = @"Cancel";
        [cancelButton  setImage:[UIImage imageNamed:@"cancelbig_new.png"] forState:(UIControlState)UIControlStateNormal];
        [imageView addSubview:cancelButton];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame =  CGRectMake(260,5,38,33);
        [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton  setImage:[UIImage imageNamed:@"close-bt.png"] forState:(UIControlState)UIControlStateNormal];
        [imageView addSubview:closeButton];
        
        self.progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(105,150,100,120)];
        self.progressImage.animationImages = imagesList;
        self.progressImage.animationDuration = 6.0;
        // seconds
        //self.progressImage.animationRepeatCount =
        // 0 = loops forever
        [self.progressImage startAnimating];
        [imageView addSubview:self.progressImage];
        
        //[self.progressImage.layer addAnimation:fullRotation forKey:@"360"];
        self.alertTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(callingMethodToSendSMSMail) userInfo:nil repeats:NO];
        [self.rView addSubview:imageView];
        [self.view addSubview:self.rView];
        
        
    }
	else {
		UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Emergency Alert!"
															 message:@"Please set your emergency email id"
															delegate:nil
												   cancelButtonTitle:@"OK"
												   otherButtonTitles:nil];
		[errorAlert show];
	}
	
    
}
-(void)callingMethodToSendSMSMail {
    
	[self.alertTimer invalidate];
	[self.progressImage stopAnimating];
	if ([self.view viewWithTag:111]) {
		if(self.progressImage){
			[self.progressImage.layer removeAllAnimations];
		}
		[rView removeFromSuperview];
		
        //////////////////////////////////
		//@@@@@@@@@@@@@@@@@ sending email @@@@@@@@@@@@@@@@@
        
        
        //NSString *address = [[appDelegate.userAddressDict valueForKey:@"formatted_address"] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSLog(@"%f,%f",bglat,bglong);
		NSString *urlString1 = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeealertlog?empid=%@&iphone=1&address=%@&latitude=%f&longitude=%f&alert_status=1&orgid=%@",appDelegate.Emp_ID,[appDelegate.userAddressDict valueForKey:@"formatted_address"],bglat,bglong,appDelegate.loginVC.textOrgid.text];
        //NSURL *URL = [NSURL fileURLWithPath:urlString1];
        NSURL *URL = [NSURL URLWithString:[urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];

        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"dictionary: %@", userInfoDict);
		
        RoundedRectView *bgView;
        UIImageView *imageView;
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
                bgView = [[RoundedRectView alloc] initWithFrame:CGRectMake(5,25,310,490)];
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,25,310,490)];
                cancelButton.frame =  CGRectMake(5,420,300,40);
                
            }
		imageView.image = [UIImage imageNamed:@"Alert-Sent_back.png"];
		
		imageView.userInteractionEnabled = YES;
		[bgView addSubview:imageView];
		self.finalEmergencyView = bgView;
		//////////////////////////////////
		
		CustomMapViewController *mapView = [[CustomMapViewController alloc] initWithCustomeMapFrame:CGRectMake(15,115,280,150) anotImage:self.selfimage];
		[mapView setAnnotationView:self.selfimage];
		[self.finalEmergencyView addSubview:mapView];
		[self.view addSubview:self.finalEmergencyView];
		
		UILabel *Lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 280, 70)];
		//Lbl.userInteractionEnabled = YES;
		Lbl.text = [NSString stringWithFormat:@"Your current location has been shared with your emergency contact Email ID."];
		[Lbl setBackgroundColor:[UIColor clearColor]];
		Lbl.numberOfLines = 3;
		[Lbl setTextColor:[UIColor whiteColor]];
		[self.finalEmergencyView addSubview:Lbl];
		
		UILabel *Lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, 280, 70)];
		//Lbl.userInteractionEnabled = YES;
		Lbl1.text = [NSString stringWithFormat:@"Current Location: %@",[appDelegate.userAddressDict valueForKey:@"formatted_address"]];
		[Lbl1 setBackgroundColor:[UIColor clearColor]];
		Lbl1.numberOfLines = 3;
		[Lbl1 setTextColor:[UIColor whiteColor]];
		[self.finalEmergencyView addSubview:Lbl1];
        
		UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		closeButton.frame =  CGRectMake(250,30,38,33);
		[closeButton addTarget:self action:@selector(closeFinalEmergencyView:) forControlEvents:UIControlEventTouchUpInside];
		[closeButton  setImage:[UIImage imageNamed:@"close-bt.png"] forState:(UIControlState)UIControlStateNormal];
		[self.finalEmergencyView addSubview:closeButton];
		
        [cancelButton addTarget:self action:@selector(emergencyClose1:) forControlEvents:UIControlEventTouchUpInside];
		//cancelButton.titleLabel.text = @"Cancel";
		[cancelButton  setImage:[UIImage imageNamed:@"cancelbig_new.png"] forState:(UIControlState)UIControlStateNormal];
		[self.finalEmergencyView addSubview:cancelButton];
	}else {
		//NSLog(@"Operation could not completed");
	}
	
}
-(void)emergencyClose:(id)sender
{   [self.alertTimer invalidate];
	signoutBtn.enabled = YES;
	//self.cTabbar.userInteractionEnabled =YES;
	if(self.progressImage){
		[self.progressImage.layer removeAllAnimations];
    }
	[rView removeFromSuperview];
}

-(void)emergencyClose1:(id)sender
{   [self.alertTimer invalidate];
	signoutBtn.enabled = YES;
	if(self.progressImage){
		[self.progressImage.layer removeAllAnimations];
    }
	[self.finalEmergencyView removeFromSuperview];
}
-(void)closeFinalEmergencyView:(id)sender
{	signoutBtn.enabled = YES;
    
    if (self.alertTimer) {
        [self.alertTimer invalidate];
        
    }
    if(self.progressImage){
		[self.progressImage.layer removeAllAnimations];
    }
    
	[self.finalEmergencyView removeFromSuperview];
}


-(void)close:(id)sender
{
    if (self.alertTimer) {
        [self.alertTimer invalidate];
        
        
    }
    
    if(self.progressImage){
        [self.progressImage.layer removeAllAnimations];
        
    }
	signoutBtn.enabled = YES;
	[rView removeFromSuperview];
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	//	NSString *locStr = [NSString stringWithFormat:@"%@ and Time %@",newLocation,[NSDate date]];
	// Current date
	
	// Add one minute to the current time
	
	//NSString *locStr = [NSString stringWithFormat:@"%@",newLocation];
	//NSLog(@"Local lat long ");
	bglat = newLocation.coordinate.latitude;
    bglong = newLocation.coordinate.longitude;
	
    
    if (!self.geoCoder) {
        self.geoCoder = [[CLGeocoder alloc] init];
        
    }
    
    
    if (bglat) {
        //NSLog(@"Local lat long======= %f",bglat);
        
        [self.bgTrackLocation stopUpdatingLocation];
        [self.bgTrackLocation setDelegate:nil];
        
        CLLocation *locloc = [[CLLocation alloc] initWithLatitude:bglat longitude:bglong];
        
        // this creates a MKReverseGeocoder to find a placemark using the found coordinates
        
        [self.geoCoder reverseGeocodeLocation:locloc completionHandler:
         ^(NSArray *placemarks, NSError *error)
        {
             NSLog(@"Placemark %@ and Error %@",placemarks,error);
             //Get nearby address
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             //String to hold address
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             
             //Print the location to console
             //NSLog(@"I am currently at %@",locatedAt);
             
             self.finaladdress = locatedAt;
             NSLog(@"After fetching address data from address dictionry %@",self.finaladdress);
             
             
         }];
        
        
    }
	
    
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	//NSLog(@"Error occured %@",[error localizedDescription]);
}
//schedule job 
-(void)fetchingJobs:(id)sender
{
    scheduleViewCont_=[[ScheduleJobsViewController alloc]initWithNibName:@"ScheduleJobsViewController" bundle:nil];
    
    if (sender==_todaysJobBtn)
    {
        
        NSDate *cudate = [[NSDate alloc]init];
        
        NSDateFormatter *cuformatter = [[NSDateFormatter alloc] init] ;
        [cuformatter setDateFormat:@"dd-MM-yyyy"];
        
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/jobschedules?orgid=%@&empid=%@&startdate=%@&enddate=%@&iphone=1",appDelegate.loginVC.textOrgid.text,appDelegate.Emp_ID,[cuformatter stringFromDate:cudate],[cuformatter stringFromDate:cudate]];
        
       
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding
                                                             error:NULL];
        NSLog(@"string%@",string);
        
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"dictionary: %@", userInfoDict);
        id emptask=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"emptask"];
        
        arrayModels_ = [[NSMutableArray alloc] init];
        
        if (emptask)
        {
            NSLog(@"hai1");
            
            
            
            
            if ([emptask isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"dictionary");
                NSDictionary *curDict=[[NSDictionary alloc]initWithDictionary:emptask];
                WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:curDict];
                [arrayModels_ addObject:model];
                scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                [_scheduleView setHidden:YES];
                
                //  return;
            }
            else if ([emptask isKindOfClass:[NSArray class]])
            {
                NSLog(@"Array");
                
                for (NSDictionary *currentDict in emptask)
                {
                    
                    WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:currentDict];
                    
                    [arrayModels_ addObject:model];
                    NSLog(@"%d",arrayModels_.count);
                    
                    
                    
                }
                scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                
                [_scheduleView setHidden:YES];
            }

        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"No Jobs Found" delegate:self
        cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
        }
		
    }
    if (sender==_thisweekJobsBtn)
    {
        NSDate *cudate = [[NSDate alloc]init];
        
        NSDateFormatter *cuformatter = [[NSDateFormatter alloc] init] ;
        [cuformatter setDateFormat:@"dd-MM-yyyy"];
        int daysToAdd = 7;
        NSDate *weekdate = [cudate dateByAddingTimeInterval:60*60*24*daysToAdd];
        [cuformatter setDateFormat:@"dd-MM-yyyy"];
        

        
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/jobschedules?orgid=%@&empid=%@&startdate=%@&enddate=%@&iphone=1",appDelegate.loginVC.textOrgid.text,appDelegate.Emp_ID,[cuformatter stringFromDate:cudate],[cuformatter stringFromDate:weekdate]];
        
        
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding
                                                             error:NULL];
        NSLog(@"string%@",string);
        
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"dictionary: %@", userInfoDict);
        id emptask=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"emptask"];
        
        arrayModels_ = [[NSMutableArray alloc] init];
        
        if (emptask)
        {
            NSLog(@"hai1");
            
            if ([emptask isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"dictionary");
                NSDictionary *curDict=[[NSDictionary alloc]initWithDictionary:emptask];
                WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:curDict];
                [arrayModels_ addObject:model];
                scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                [_scheduleView setHidden:YES];
                //  return;
            }
            else if ([emptask isKindOfClass:[NSArray class]])
            {
                NSLog(@"Array");
                
                for (NSDictionary *currentDict in emptask)
                {
                    
                    WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:currentDict];
                    
                    [arrayModels_ addObject:model];
                    NSLog(@"%d",arrayModels_.count);
                    
                    
                    
                }
                
                scheduleViewCont_.scheduleArry=[NSMutableArray arrayWithArray:arrayModels_];
                [self presentViewController:scheduleViewCont_ animated:YES completion:nil];
                
                 [_scheduleView setHidden:YES];
                
            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"No Jobs Found" delegate:self
                                               cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            [alert show];
        }
    }
    if (sender==_chooseDateBtn)
    {
        _chooseDateView.hidden=NO;
            _chooseDateView.frame =  CGRectMake(130, 20, 0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                _chooseDateView.frame =  CGRectMake(40, 250, 220, 135);
               
                
            }];
       
        [_scheduleView setHidden:YES];
    }
}

-(UIActionSheet *)addDatePickerWithDoneAndCancelButton:(NSString*)title
{
    if ([title isEqualToString:@"StartDate"])
    {
        actionSheet_= [[UIActionSheet alloc] initWithTitle:@"Start Date"
                                                  delegate:nil
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
    }
    else if([title isEqualToString:@"EndDate"])
    {
    actionSheet_= [[UIActionSheet alloc] initWithTitle:@"End Date"
                                             delegate:nil
                                    cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                                    otherButtonTitles:nil];
    }
    
    [actionSheet_ setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    
    
    datePicker_ = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    datePicker_.datePickerMode = UIDatePickerModeDate;
    
    // dataPickerView.showsSelectionIndicator = YES;
    //dataPickerView.dataSource = self;
    //  dataPickerView.delegate = self;
    //  NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    // NSDate *currentDate = [NSDate date];
    // NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    
    //  NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    //[datePicker setMinimumDate:minDate];
    
    [actionSheet_ addSubview:datePicker_];
    
    
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
    cancelButton.momentary = YES;
    cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
    cancelButton.tintColor = [UIColor grayColor];
    [cancelButton addTarget:self action:@selector(clickOnCancelButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
    //////////////////////////////////////////////
    if ([title isEqualToString:@"StartDate"])
    {
        UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
        doneButton.momentary = YES;
        doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
        doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
        doneButton.tintColor = [UIColor grayColor];
        [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
        [actionSheet_ addSubview:doneButton];
    }
    else if([title isEqualToString:@"EndDate"])
    {
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor grayColor];
    [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet1:) forControlEvents:UIControlEventValueChanged];
        [actionSheet_ addSubview:doneButton];
    }
    [actionSheet_ addSubview:cancelButton];
    
    
    [actionSheet_ showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet_ setBounds:CGRectMake(0, 0, 320, 485)];
    return actionSheet_;
}
-(IBAction)clickOnCancelButtonOnActionSheet:(id)sender
{
    // actionSheet.hidden=YES;
    //dataPickerView.hidden=YES;
    [actionSheet_ dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(IBAction)clickOnDoneButtonOnActionSheet:(id)sender
{
    
   
    NSDate *date = datePicker_.date;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter stringFromDate:date];
    
    _startDateTxtFld.text= [dateFormatter stringFromDate:date];
    [actionSheet_ dismissWithClickedButtonIndex:1 animated:YES];
    
    
}
-(IBAction)clickOnDoneButtonOnActionSheet1:(id)sender
{
    
    
    NSDate *date = datePicker_.date;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter stringFromDate:date];
    
    _endDateTxtFld.text= [dateFormatter stringFromDate:date];
    [actionSheet_ dismissWithClickedButtonIndex:1 animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
