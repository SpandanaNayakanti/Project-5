//
//  JobsViewController.m
//  WorkForceTracker
//
//  Created by Karthik  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "JobsViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface JobsViewController ()

@end

@implementation JobsViewController
@synthesize acceptedJobsLbl;
@synthesize pendingJobsLbl;
@synthesize completedJobsLbl;
@synthesize runningJobsLbl;
@synthesize status;
@synthesize acceptedJobs;

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
    

    
   
    [self willMakeLblCornerFor: @[pendingJobsLbl , acceptedJobsLbl , runningJobsLbl, completedJobsLbl]];
    



    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
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
    [_actvtyIndi startAnimating];
    
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    //[self willMakeLblCornerFor: @[pendingJobsLbl , acceptedJobsLbl , runningJobsLbl, completedJobsLbl]];
    
    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/countalljobs?empid=%@&iphone=1",appDelegate.Emp_ID];

    
    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"ka%@",string);
    //NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    id jobsDict=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"jobs"];
    pendingJobsLbl.text=[jobsDict valueForKey:@"pending"];
    acceptedJobsLbl.text=[jobsDict valueForKey:@"accepted"];
    runningJobsLbl.text=[jobsDict valueForKey:@"running"];
    completedJobsLbl.text=[jobsDict valueForKey:@"completed"];
    [_actvtyIndi stopAnimating];
    }

}



- (void)willMakeLblCornerFor:(NSArray *)arrayLbl
{
    for (UILabel *lbl in arrayLbl) {
        
        lbl.layer.cornerRadius = 15.0f;
        lbl.layer.backgroundColor = [UIColor blackColor].CGColor;
        lbl.layer.borderWidth = 0.1f;
       
    
        
    }
}


- (IBAction)pendingJobsAction:(id)sender
{
    
    status=[sender currentTitle];
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    if ([pendingJobsLbl.text integerValue]>0)
    {
        [self performSelector:@selector(jobsStatusAction:) withObject:@"pending" afterDelay:0.1f];
    }
    else
    {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:nil message:@"No Pending Jobs Found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [message show];
        [activityIndi stopAnimating];
    }

}

- (IBAction)backAction:(id)sender
{
      [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)acceptedJobsAction:(id)sender
{
    status=[sender currentTitle];
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    
    
    if ([acceptedJobsLbl.text integerValue]>0)
    {
        [self performSelector:@selector(jobsStatusAction:) withObject:@"accepted" afterDelay:0.1f];
    }
    else
    {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:nil message:@"No Accepted Jobs Found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [message show];
        [activityIndi stopAnimating];
    }
    
    
}
-(void)jobsStatusAction:(NSString*)title
{
    jobStatusVC =[[JobStatusViewController alloc]initWithNibName:@"JobStatusViewController" bundle:[NSBundle mainBundle]];
    jobStatusVC.jobStatus=status;
    
    if ([title isEqualToString:@"pending"])
    {
        jobStatusVC.typeBtn = btnTypePending;
    }
    else if ([title isEqualToString:@"accepted"])
    {
        jobStatusVC.typeBtn = btnTypeAccepted;
    }
   else if ([title isEqualToString:@"completed"])
    {
        jobStatusVC.typeBtn=btnTypeCompleted;
    }
   else if ([title isEqualToString:@"running"])
    {
        jobStatusVC.typeBtn=btnTypeRunning;
    }
  
    
    
    
    [self presentViewController:jobStatusVC animated:YES completion:nil];
    [activityIndi stopAnimating];
}
- (IBAction)runningJobsAction:(id)sender
{
    status=[sender currentTitle];
    NSLog(@"%@",status);
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    if ([runningJobsLbl.text integerValue]>0)
    {
        [self performSelector:@selector(jobsStatusAction:) withObject:@"running" afterDelay:0.1f];
    }
    else
    {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:nil message:@"No Running Jobs Found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [message show];
        [activityIndi stopAnimating];
    }

}

- (IBAction)completedJobsAction:(id)sender
{
    status=[sender currentTitle];
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    if ([completedJobsLbl.text integerValue]>0)
    {
        [self performSelector:@selector(jobsStatusAction:) withObject:@"completed" afterDelay:0.1f];
    }
    else
    {
        UIAlertView *message=[[UIAlertView alloc]initWithTitle:nil message:@"No Completed Jobs Found" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [message show];
        [activityIndi stopAnimating];
    }

}
@end
