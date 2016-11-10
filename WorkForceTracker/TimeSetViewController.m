//
//  TimeSetViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 18/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TimeSetViewController.h"
#import "AppDelegate.h"
@interface TimeSetViewController ()

@end

@implementation TimeSetViewController

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
    titlesArry = [[NSMutableArray alloc] initWithObjects:@"30 minutes",@"1 hour", @"2 hours",@"3 hours",@"4 hours",@"5 hours", nil];
    
    arrDuration=[[NSArray alloc]initWithObjects:@"1800",@"3600",@"7200",@"10800",@"14400",@"18000", nil];
    //timerDuration=1800;

}
-(void)TimerActionInitiate

{
    NSLog(@"timerDuration %f",_timerDuration);
    //timerDuration=1800;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_timer invalidate];
   
    NSUserDefaults *uDefaults=[NSUserDefaults standardUserDefaults];
    
    if ([[uDefaults objectForKey:@"AutoLocation"] isEqualToString:@"ON"])
    {
    [appDelegate performSelector:@selector(UploadEmployeeLog) withObject:nil afterDelay:.1];
    _timer=[NSTimer scheduledTimerWithTimeInterval:_timerDuration
                                           target:appDelegate
                                         selector:@selector(UploadEmployeeLog)
                                         userInfo:nil
                                          repeats:YES];
    }


}
- (void)viewDidAppear:(BOOL)animated
{
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUInteger index = [titlesArry indexOfObject:appDelegate.timeSetString];
    NSLog(@"index=%lu",(unsigned long)index);
    if (0<index<titlesArry.count)
    {
        indexPathOld=[NSIndexPath indexPathForRow:index inSection:0];
        [SetTimeTable selectRowAtIndexPath:indexPathOld animated:YES  scrollPosition:UITableViewScrollPositionBottom];
        UITableViewCell *cell = [SetTimeTable cellForRowAtIndexPath:indexPathOld];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
     }
}
-(IBAction)BackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)CancelAction
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
    return titlesArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[titlesArry objectAtIndex:indexPath.row];
//    if (indexPath.row==4 && statusOther) {
//        cell.detailTextLabel.text=statusOther;
//    }
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //    cell.detailTextLabel.text=[[arrSend objectAtIndex:indexPath.row] objectForKey:@"email"];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//        cell.backgroundColor = [UIColor orangeColor];
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPathOld) {
        UITableViewCell *cellold=[tableView cellForRowAtIndexPath:indexPathOld];
        cellold.accessoryType=UITableViewCellAccessoryNone;
    }
    indexPathOld=indexPath;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    if ([indexPath row] == 4) {
//        //        cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
//        [self presentViewController:otherVC animated:YES completion:nil];
//    }
//    statusSelected=cell.textLabel.text;
    _timerDuration=[[[arrDuration objectAtIndex:indexPath.row] description] floatValue];
    appDelegate.timeSetString=[titlesArry objectAtIndex:indexPath.row];
    [_timer invalidate];
    //[appDelegate performSelector:@selector(UploadEmployeeLog) withObject:nil afterDelay:.1];
    _timer=[NSTimer scheduledTimerWithTimeInterval:_timerDuration
                                     target:self
                                   selector:@selector(TimerActionInitiate)
                                   userInfo:nil
                                    repeats:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
