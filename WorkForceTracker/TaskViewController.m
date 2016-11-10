//
//  TaskViewController.m
//  WorkForceTracker
//
//  Created by karthik on 25/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TaskViewController.h"
#import "AppDelegate.h"
#import "RunningActivitiesModel.h"

@interface TaskViewController ()
{
    AppDelegate *appDelegate;
    int currentSelection;
    RunningActivitiesModel *runningActvtyodel_;
}

@end

@implementation TaskViewController

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
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    _timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 135, 300, 40)];
    _timeLbl.textColor=[UIColor whiteColor];
    _timeLbl.numberOfLines=5;
    _timeLbl.font=[UIFont fontWithName:@"Helvetica" size:14];
    [_timeLbl setLineBreakMode:NSLineBreakByWordWrapping];
    
    
    [self.view addSubview:_timeLbl];
    
    _projectId=[[UITextField alloc]initWithFrame:CGRectMake(30, 180, 150, 30)];
    _projectId.borderStyle=UITextBorderStyleLine;
    _projectId.returnKeyType=UIReturnKeyNext;
    _projectId.textColor=[UIColor whiteColor];
    [self.view addSubview:_projectId];
    
    _projectName=[[UITextField alloc]initWithFrame:CGRectMake(30, 215, 150, 30)];
    _projectName.borderStyle=UITextBorderStyleLine;
    _projectName.returnKeyType=UIReturnKeyNext;
    _projectName.textColor=[UIColor whiteColor];
    [self.view addSubview:_projectName];
    
    _notes=[[UITextField alloc]initWithFrame:CGRectMake(30, 250, 150, 30)];
    _notes.borderStyle=UITextBorderStyleLine;
    _notes.returnKeyType=UIReturnKeyDone;
    _notes.textColor=[UIColor whiteColor];
    [self.view addSubview:_notes];
    
    _timeLbl.hidden=YES;
    _projectId.hidden=YES;
    _projectName.hidden=YES;
    _notes.hidden=YES;
    _cancelActvty.hidden=YES;
    
    _projectId.delegate=self;
    _projectName.delegate=self;
    _notes.delegate=self;
    
    UIColor *color = [UIColor grayColor];
    _projectId.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Project Id" attributes:@{NSForegroundColorAttributeName: color}];
    _projectName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Projectname" attributes:@{NSForegroundColorAttributeName: color}];
    _notes.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Note" attributes:@{NSForegroundColorAttributeName: color}];
    
    _uId.text=[[_activityArray objectAtIndex:0] uEmployeeTasksId];
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if(IS_IPHONE_5)
        {
            _taskTV = [[UITableView alloc] initWithFrame:CGRectMake(28, 135, 240,80) style:UITableViewStylePlain];
            
            
        }
        else{
            _taskTV = [[UITableView alloc] initWithFrame:CGRectMake(28, 131, 240,60) style:UITableViewStylePlain];
            
        }
        
    }
    _taskTV.separatorStyle=UITableViewCellSeparatorStyleNone;
    _taskTV.layer.cornerRadius=8;
    
	_taskTV.delegate   = self;
	_taskTV.dataSource = self;
	[self.view addSubview:_taskTV];
	_taskTV.hidden = YES;
    
	NSLog(@"%d",_runningActvtsArray.count);
    
    [super viewDidLoad];
    [self runningActivities];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)runningActivities
{
    
    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/taskstatusupdate?orgid=%@&empid=%@&workorderid=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId];
    
    
    
    
    NSLog(@"%@%@%@",[appDelegate.userInfoDict valueForKey:@"orgid"], appDelegate.Emp_ID,_detailModel.uId );
    
    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"string%@",string);
    NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"userInfoDict%@",userInfoDict);
    id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
    NSLog(@"task%@",task);
    _runningActvtsArray=[[NSMutableArray alloc]init];
    
    if (task)
    {
        if ([task isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"array");
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:task];
            runningActvtyodel_=[[RunningActivitiesModel alloc]initWithDictionary:dict];
            [_runningActvtsArray addObject:runningActvtyodel_];
            
            
        }
        
        if ([task isKindOfClass:[NSMutableArray class]])
        {
            NSLog(@"dict");
            for (NSDictionary *currentDict in task)
            {
                
                runningActvtyodel_ = [[RunningActivitiesModel alloc] initWithDictionary:currentDict];
                
                [  _runningActvtsArray addObject:runningActvtyodel_];
                NSLog(@"%d",  _runningActvtsArray.count);
                
                
                
            }
        }
    }
}

// For DropDown List
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
	
 	UITouch *touch = [touches anyObject];
	int tagValue =[touch view].tag;
	NSLog(@"tagvalue----%d",tagValue);
	if (tagValue == 100)
    {
        
        if (_taskTV.hidden)
        {
           	
            [_taskTV setHidden:NO];
            
        }else{
            
            [_taskTV setHidden:YES];
            
        }
        
	}
	if (tagValue == 0)
    {
		[_taskTV setHidden:YES];
        
	}
    
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


#pragma mark Table view methods
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_activityArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
	// Configure the cell.
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor]; // as per your requirement set color.
    [cell.contentView addSubview:separatorLineView];
    
    
    cell.textLabel.text = [[_activityArray objectAtIndex:indexPath.row] valueForKey:@"uWorkItemname"];
    
    if (_runningActvtsArray.count)
    {
    
    
  for (int i=0; i<_runningActvtsArray.count; i++)
   {
   if ([cell.textLabel.text isEqualToString:[[_runningActvtsArray objectAtIndex:i]valueForKey:@"uDiscription"]])
        {
            cell.textLabel.textColor=[UIColor greenColor];
        }
    }
    }
    else
    {
        cell.textLabel.textColor=[UIColor blackColor];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 35;
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    _taskName.text = [[_activityArray objectAtIndex:indexPath.row] valueForKey:@"uWorkItemname"];
    NSLog(@"%d",indexPath.row);
    if ( _runningActvtsArray.count)
    {
        //        NSLog(@"%@",[[_runningActvtsArray objectAtIndex:indexPath.row] valueForKey:@"uDiscription"]);
        for (int i=0; i<_runningActvtsArray.count; i++)
        {
            
            
            if ([_taskName.text isEqualToString:[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uDiscription"]])
            {
                if ([[_runningActvtsArray objectAtIndex:i] valueForKey:@"uStartTime"])
                    
                {
                    
                    
                    NSLog(@"hai");
                    
                    _startActivityBtn.userInteractionEnabled=NO;
                    //[_startActivityBtn setBackgroundColor:[UIColor clearColor]];
                    [_startActivityBtn setAlpha:0.5f];
                    [_endActivityBtn setAlpha:1.0f];
                    _endActivityBtn.userInteractionEnabled=YES;
                    //[_endActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
                    _timeLbl.hidden=NO;
                    _projectId.hidden=NO;
                    _projectName.hidden=NO;
                    _notes.hidden=NO;
                    _cancelActvty.hidden=NO;
                    
                    
                    _timeLbl.text=[NSString stringWithFormat:@"Started Date and Time is: %@ ",[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uStartTime"]];
                    
                    _taskTV.hidden=YES;
                    return;
                }
                
            }
            
            
            else
            {
                _startActivityBtn.userInteractionEnabled=YES;
                _endActivityBtn.userInteractionEnabled=NO;
                //[_endActivityBtn setBackgroundColor:[UIColor clearColor]];
                [_endActivityBtn setAlpha:0.5f];
                [_startActivityBtn setAlpha:1.0f];
                
                //[_startActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
                _timeLbl.hidden=YES;
                _projectId.hidden=NO;
                _projectName.hidden=NO;
                _notes.hidden=NO;
                _cancelActvty.hidden=YES;
                
            }
        }
        
    }
    else
    {
        _startActivityBtn.userInteractionEnabled=YES;
        _endActivityBtn.userInteractionEnabled=NO;
        //[_endActivityBtn setBackgroundColor:[UIColor clearColor]];
        [_endActivityBtn setAlpha:0.5f];
        [_startActivityBtn setAlpha:1.0f];
        
       // [_startActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
        _timeLbl.hidden=YES;
        _projectId.hidden=NO;
        _projectName.hidden=NO;
        _notes.hidden=NO;
        _cancelActvty.hidden=YES;
        
    }
    currentSelection=indexPath.row;
    
    
    
    
    
    
	[tableView setHidden:YES];
    
}


- (IBAction)strtActivityActn:(id)sender
{
    if ([_taskName.text isEqualToString:@"select Activity"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Select any activity from list" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok" ,nil];
        [alert show];
    }
    
    else
    {
        NSDateFormatter *todatFormatter=[[NSDateFormatter alloc]init];
        [todatFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        NSDate *startdate=[NSDate date];
        
        NSLog(@"%@",[todatFormatter stringFromDate:startdate]);
        
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/taskstatusupdate?orgid=%@&empid=%@&workorderid=%@&changeto=start&discription=%@&workitems_id=%@&project_id=%@&project_name=%@&notes=%@&startdate=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"],appDelegate.Emp_ID,[[_activityArray objectAtIndex:0] valueForKey:@"uEmployeeTasksId"],_taskName.text,[[_activityArray objectAtIndex:currentSelection] valueForKey:@"uId"],_projectId.text,_projectName.text,_notes.text,[todatFormatter stringFromDate:startdate]] ;
        
        
        
        NSLog(@"%@%@%@%@%@%@%@%@%@",[appDelegate.userInfoDict valueForKey:@"orgid"],appDelegate.Emp_ID,[[_activityArray objectAtIndex:0] valueForKey:@"uEmployeeTasksId"],_taskName.text,[[_activityArray objectAtIndex:currentSelection] valueForKey:@"uId"],_projectId.text,_projectName.text,_notes.text ,[todatFormatter stringFromDate:startdate]);
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"string%@",string);
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"userInfoDict%@",userInfoDict);
        id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
        
        if (task)
        {
            NSLog(@"sucess");
            _timeLbl.hidden=NO;
            _timeLbl.text=[NSString stringWithFormat:@"Task Started  Date and Time is :%@ ",[todatFormatter stringFromDate:startdate]];
            [self runningActivities];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_taskTV reloadData];
                
            });
            _endActivityBtn.hidden=NO;
            _cancelActvty.hidden=NO;
            _endActivityBtn.userInteractionEnabled=YES;
            _startActivityBtn.userInteractionEnabled=NO;
            //[_endActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
            [_endActivityBtn setAlpha:1.0f];
            [_startActivityBtn setAlpha:0.5f];
            
            //[_startActivityBtn setBackgroundColor:[UIColor clearColor]];
        }
        
    }
    
}

- (IBAction)endActvtyBtn:(id)sender
{
    if ([_taskName.text isEqualToString:@"select Activity"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Select any activity from list" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok" ,nil];
        [alert show];
    }
    else
    {
        NSDateFormatter *todatFormatter=[[NSDateFormatter alloc]init];
        [todatFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        NSDate *enddate=[NSDate date];
        NSString *string=[NSString stringWithFormat:@"Activity end time is :%@" ,[todatFormatter stringFromDate:enddate]];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Do you want to end the activity" message:string delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        alert.tag=100;
        [alert show];
        
        
    }
    
    
}

- (IBAction)cancelActvty:(id)sender
{
    for (int i=0; i<_runningActvtsArray.count; i++)
    {
        if ([_taskName.text isEqualToString:[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uDiscription"]])
        {
            NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/taskstatusupdate?orgid=%@&empid=%@&workorderid=%@&changeto=cancel&discription=%@&id=%@&project_id=%@&project_name=%@&notes=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"],appDelegate.Emp_ID,[[_activityArray objectAtIndex:0] valueForKey:@"uEmployeeTasksId"],_taskName.text,[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uId" ],_projectId.text,_projectName.text,_notes.text] ;
            NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
            NSLog(@"string%@",string);
            NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
            NSLog(@"userInfoDict%@",userInfoDict);
            id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
            if (task)
            {
                NSLog(@"kkkkkk");
                _timeLbl.text=@"";
               
                _projectId.text=@"";
                _projectName.text=@"";
                _notes.text=@"";
                [self runningActivities];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_taskTV reloadData];
                    
                });
                _startActivityBtn.userInteractionEnabled=YES;
                _endActivityBtn.userInteractionEnabled=NO;
                _cancelActvty.hidden=YES;
                [_startActivityBtn setAlpha:1.0f];
                [_endActivityBtn setAlpha:0.5f];
                
                //[_startActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
                //[_endActivityBtn setBackgroundColor:[UIColor clearColor]];
            }
            return;
        }
    }
  
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100)
    {
        if (buttonIndex==0)
        {
            NSLog(@"hai");
        }
        if (buttonIndex==1)
        {
            for (int i=0; i<_runningActvtsArray.count; i++)
            {
                if ([_taskName.text isEqualToString:[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uDiscription"]])
                {
            NSDateFormatter *todatFormatter=[[NSDateFormatter alloc]init];
            [todatFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
            NSDate *enddate=[NSDate date];
            NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/taskstatusupdate?orgid=%@&empid=%@&workorderid=%@&changeto=end&discription=%@&id=%@&project_id=%@&project_name=%@&notes=%@&enddate=%@&iphone=1",[appDelegate.userInfoDict valueForKey:@"orgid"],appDelegate.Emp_ID,[[_activityArray objectAtIndex:0] valueForKey:@"uEmployeeTasksId"],_taskName.text,[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uId" ],_projectId.text,_projectName.text,_notes.text,[todatFormatter stringFromDate:enddate]] ;
            
            
            
            NSLog(@"%@%@%@%@%@%@%@%@%@",[appDelegate.userInfoDict valueForKey:@"orgid"],appDelegate.Emp_ID,[[_activityArray objectAtIndex:0] valueForKey:@"uEmployeeTasksId"],_taskName.text,[[_runningActvtsArray objectAtIndex:i] valueForKey:@"uId" ],_projectId.text,_projectName.text,_notes.text,[todatFormatter stringFromDate:enddate]);
            NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
            NSLog(@"string%@",string);
            NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
            NSLog(@"userInfoDict%@",userInfoDict);
            id task=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"task"];
            NSLog(@"%@",task);
            if (task)
            {
                NSLog(@"kkkkkk");
                _timeLbl.text=@"";
                _projectId.text=@"";
                _projectName.text=@"";
                _notes.text=@"";
                [self runningActivities];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_taskTV reloadData];
                    
                });
                _startActivityBtn.userInteractionEnabled=YES;
                _endActivityBtn.userInteractionEnabled=NO;
                _cancelActvty.hidden=YES;
                [_startActivityBtn setAlpha:1.0f];
                [_endActivityBtn setAlpha:0.5f];
                
                
//                [_startActivityBtn setBackgroundColor:[UIColor lightGrayColor]];
//                [_endActivityBtn setBackgroundColor:[UIColor clearColor]];
            }
                    
           return;
                    
        }
                
               
     }
    }
    
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_projectId resignFirstResponder];
    [_projectName resignFirstResponder];
    [_notes resignFirstResponder];
    return YES;
}



@end
