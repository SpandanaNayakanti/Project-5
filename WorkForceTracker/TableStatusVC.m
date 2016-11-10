//
//  TableStatusVC.m
//  WorkForceTracker
//
//  Created by Pratibha on 10/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TableStatusVC.h"
#import "AppDelegate.h"
@interface TableStatusVC ()

@end

@implementation TableStatusVC

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
//    TblStatus.delegate=self;
//    TblStatus.dataSource=self;
    [self performSelector:@selector(StatusAction) withObject:nil afterDelay:.1];

    
    
    
    if (WINDOW_HEIGHT >= 568)
    {
        //[scrollViewFields_ setContentSize:CGSizeMake(320, WINDOW_HEIGHT+100)];
        TblStatus.frame = CGRectMake(0, 65, 320, WINDOW_HEIGHT);
        
    }
    else
    {
        //[scrollViewFields_ setContentSize:CGSizeMake(320, WINDOW_HEIGHT+200)];
        
        TblStatus.frame = CGRectMake(0, 65, 320, WINDOW_HEIGHT);

    }
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    //[self performSelector:@selector(StatusAction) withObject:nil afterDelay:1.0];

}
-(void)StatusAction
{
    AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeestatuslist?empid=%@&iphone=1",appDelegate.Emp_ID];
    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    
    id empStatusDict=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"empstatus"];
    arrStatus=[[NSMutableArray alloc]init];
    if([empStatusDict isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *dict in empStatusDict) {
            NSMutableDictionary *dictTemp=[[NSMutableDictionary alloc]initWithDictionary:dict];
            //[dictTemp setObject:@"0" forKey:@"empReachd"];
            [arrStatus addObject:dictTemp];
        }
        
    }
    else if([empStatusDict isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *dictTemp=[empStatusDict mutableCopy];
        //[dictTemp setObject:@"0" forKey:@"empReachd"];
        arrStatus=[[NSMutableArray alloc]initWithObjects:dictTemp, nil];
    }
    NSLog(@"empStatusDict=%@",empStatusDict);

//    arrStatus=[userInfoDict objectForKey:@"empstatus"];
//    NSArray* arrStatusN = [[arrStatus reverseObjectEnumerator] allObjects];
//    arrStatus=[arrStatusN mutableCopy];
    NSLog(@"arrStatus: %@", arrStatus);
    if (userInfoDict) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status Updated" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        [TblStatus reloadData];
    }
}
-(IBAction)BackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrStatus.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempDict=[arrStatus objectAtIndex:indexPath.row];
    cell.textLabel.text=[tempDict valueForKey:@"status_message"];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@\n%@",[tempDict valueForKey:@"location"],[tempDict valueForKey:@"created"]];
    cell.detailTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines=4;
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//        cell.backgroundColor = [UIColor orangeColor];
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
