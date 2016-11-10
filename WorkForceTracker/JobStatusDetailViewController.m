//
//  JobStatusDetailViewController.m
//  WorkForceTracker
//
//  Created by karthik on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.


#import "JobStatusDetailViewController.h"
#import "RunningActivitiesModel.h"
#import "TaskListModel.h"

@interface JobStatusDetailViewController ()
{
    
    AppDelegate *appDelegate;
    RunningActivitiesModel *runningActvtyodel_;
    TaskListModel *taskLstModel_;
    
    NSMutableArray *runningActvtyarrayModels_;
    NSMutableArray *taskLstArry_;
    

}

@end

@implementation JobStatusDetailViewController


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
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentInset = UIEdgeInsetsMake(-55, 0, 0, 0);
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if(IS_IPHONE_5)
        {
            
            self.scrollView.frame = CGRectMake(0, 67, 320, 460);
            self.scrollView.contentSize=CGSizeMake(320, 650);
             _timeSheet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _timeSheet.frame=CGRectMake(10, 520, 100, 40);
             _viewTimeSheet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _viewTimeSheet=[[UIButton alloc]initWithFrame:CGRectMake(190, 520, 100, 40)];
            
        }
        else
        {
            
            self.scrollView.frame = CGRectMake(0, 67, 320, 360);
            self.scrollView.contentSize=CGSizeMake(320, 650);
             _timeSheet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            _timeSheet.frame=CGRectMake(10, 420, 100, 40);
            _viewTimeSheet=[UIButton buttonWithType:UIButtonTypeRoundedRect];
             _viewTimeSheet=[[UIButton alloc]initWithFrame:CGRectMake(190, 420, 100, 40)];
        }
    }
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
   
   [_timeSheet setBackgroundImage:[UIImage imageNamed:@"timesheet.png"] forState:UIControlStateNormal];
    
  
    [_viewTimeSheet setBackgroundImage:[UIImage imageNamed:@"view-timesheet.png"] forState:UIControlStateNormal];
   
    
    NSLog(@"details Is %@",_detailModel.uMobile);

   [self jobDetails];
    
    NSLog(@"%u",_typeBtn);
    if (_typeBtn==btnTypeRunning)
    {
        if (_activityArry.count > 0)
        {
            [self.view addSubview:_timeSheet];
            [self.view addSubview:_viewTimeSheet];
        }
        
        
    }
   
  
   [_timeSheet addTarget:self action:@selector(timeSheetActn) forControlEvents:UIControlEventTouchUpInside];
 [_viewTimeSheet addTarget:self action:@selector(viewtimeSheetActn) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.address setUserInteractionEnabled:YES];
    [tap setNumberOfTapsRequired:1];
    [self.address addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)jobDetails
{
    _jobId.text           = _detailModel.uId;
    _jobTitle.text        = _detailModel.uTitle;
    _jobType.text         = _detailModel.uTaskType;
    _jobDescrptn.text     = _detailModel.uDescription;
    _startDate.text       = _detailModel.uRequstedDate;
    _endDate.text         = _detailModel.uRequstedEndDate;
    _custName.text        = _detailModel.uName;
    _custMail.text        = _detailModel.uEmail;
    _custMbleNumber.text  = _detailModel.uMobile;
    _address.text         = _detailModel.uAddress;
}
-(void)timeSheetActn
{
    

    _TVC=[[TaskViewController alloc]initWithNibName:@"TaskViewController" bundle:nil];
    
    _TVC.activityArray=[NSMutableArray arrayWithArray:_activityArry];
    _TVC.detailModel=_detailModel;
    
//    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/taskstatusupdate?orgid=%@&empid=%@&workorderid=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId];
//    
//    
//    
//    
//    NSLog(@"%@%@%@",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId );
//    
//    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
//    NSLog(@"string%@",string);
//    NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
//    NSLog(@"userInfoDict%@",userInfoDict);
//    id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
//    NSLog(@"task%@",task);
//    runningActvtyarrayModels_=[[NSMutableArray alloc]init];
//    
//    if (task)
//    {
//        if ([task isKindOfClass:[NSDictionary class]])
//        {
//            NSLog(@"array");
//            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:task];
//            runningActvtyodel_=[[RunningActivitiesModel alloc]initWithDictionary:dict];
//            [runningActvtyarrayModels_ addObject:runningActvtyodel_];
//            _TVC.runningActvtsArray=[NSMutableArray arrayWithArray:runningActvtyarrayModels_];
//            
//        }
//        
//        if ([task isKindOfClass:[NSMutableArray class]])
//        {
//            NSLog(@"dict");
//            for (NSDictionary *currentDict in task)
//            {
//               
//                runningActvtyodel_ = [[RunningActivitiesModel alloc] initWithDictionary:currentDict];
//                
//                [runningActvtyarrayModels_ addObject:runningActvtyodel_];
//                NSLog(@"%d",runningActvtyarrayModels_.count);
//                
//                
//                
//            }
//             _TVC.runningActvtsArray=[NSMutableArray arrayWithArray:runningActvtyarrayModels_];
//        }
//    }
//    

    
    
    [self presentViewController:_TVC  animated:YES completion:nil];
}
-(void)viewtimeSheetActn
{
    _activityViewCont=[[ViewActivitiesViewController alloc]initWithNibName:@"ViewActivitiesViewController" bundle:nil];
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/tasklist?orgid=%@&empid=%@&workorderid=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId];
    
    
    
    
    NSLog(@"%@%@%@",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId );
    
    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"string%@",string);
    NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"userInfoDict%@",userInfoDict);
    id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
    NSLog(@"%@",task);
    
    taskLstArry_=[[NSMutableArray alloc]init];
    
    if (task)
    {
        if ([task isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:task];
            
            taskLstModel_=[[TaskListModel alloc]initWithDictionary:dict];
            
            [taskLstArry_ addObject:taskLstModel_];
            
            _activityViewCont.taskListArry=taskLstArry_;
        }
        
        if ([task isKindOfClass:[NSMutableArray class]])
        {
            for (NSDictionary *currentDict in task)
            {
                taskLstModel_=[[TaskListModel alloc]initWithDictionary:currentDict];
                
                [taskLstArry_ addObject:taskLstModel_];
            }
            
            _activityViewCont.taskListArry=taskLstArry_;
        }
    }
    if (taskLstArry_.count>0)
    {
        [self presentViewController:_activityViewCont animated:YES completion:nil]; 
    }
    else
     
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"There is no Activities" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        
        [alert show];
    }
    
   
}

#pragma mark - showing directions on map

-(void)tapAction
{
   
    NSLog(@"Destination Address:%@",self.address.text);
    
    //http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino

    
   // CLLocationCoordinate2D currentLocation = [self getCurrentLocation];
    // this uses an address for the destination.  can use lat/long, too with %f,%f format
    NSString* address = self.address.text;
    NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%@",
                    
                     [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    
    
//    UIWebView *webview = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//
//    NSURL *URL = [NSURL URLWithString:url];
//    [webview loadRequest:[NSURLRequest requestWithURL:URL]];
//    [self.view addSubview:webview];
//    
}
-(BOOL)shouldAutorotate
{
    return NO;
}


@end







