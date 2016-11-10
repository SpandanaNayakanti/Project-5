
#import "StatusViewController.h"

@interface StatusViewController ()

@end

@implementation StatusViewController
@synthesize statusOther;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    statusOther=otherVC.statusTView.text;
    statusSelected=statusOther;
    NSLog(@"statusOther=%@",statusOther);
    NSLog(@"lat=%f",appDelegate.updateVC.bglat);
    NSLog(@"lat=%f",appDelegate.updateVC.bglong);
    NSLog(@"finaladdress=%@",appDelegate.updateVC.finaladdress);
    [tblStatus reloadData];
}
- (void)viewDidLoad
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    otherVC=[[OtherViewController alloc] initWithNibName:@"OtherViewController" bundle:[NSBundle mainBundle]];

    [super viewDidLoad];
       titlesArry = [[NSMutableArray alloc] initWithObjects:@"Driving",@"Worksite", @"At Lunch",@"Stuck in Traffic",@"Other", nil];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)CancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)OkAction
{
    if (!statusSelected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:@"select anyone" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/employeestatus?latitude=%f&iphone=1&longitude=%f&location=%@&status_msg=%@&empid=%@",appDelegate.updateVC.bglat,appDelegate.updateVC.bglong,[appDelegate.userAddressDict valueForKey:@"formatted_address"],statusSelected,appDelegate.Emp_ID];
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"%@",string);
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"OkAction: %@", userInfoDict);
        if (userInfoDict)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status Updated" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [self CancelAction];
            
        }

    }

}

- (IBAction)backActn:(UIButton *)sender
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
    if (indexPath.row==4 && statusOther)
    {
        cell.detailTextLabel.text=statusOther;
    }
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
    if (indexPathOld) {
        UITableViewCell *cellold=[tableView cellForRowAtIndexPath:indexPathOld];
        cellold.accessoryType=UITableViewCellAccessoryNone;
    }
    indexPathOld=indexPath;

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if ([indexPath row] == 4) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
        [self presentViewController:otherVC animated:YES completion:nil];
    }
    statusSelected=cell.textLabel.text;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
