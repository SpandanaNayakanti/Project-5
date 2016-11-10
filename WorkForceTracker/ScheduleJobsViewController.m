//
//  ScheduleJobsViewController.m
//  WorkForceTracker
//
//  Created by karthik  on 05/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "ScheduleJobsViewController.h"

@interface ScheduleJobsViewController ()<ScheduleJobCellDelegate>

@end

@implementation ScheduleJobsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_scheduleArry count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"ScheduleJobCell";
    ScheduleJobCell *Cell =(ScheduleJobCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (Cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"ScheduleJobCell" owner:self options:nil];
        Cell = [cellArray objectAtIndex:0];
        
        //  Cell = [[JobStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [Cell setCellView];
    
    
    Cell.delegate = self;
    Cell.tag = indexPath.row;
    
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 129, 320, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor]; // as per your requirement set color.
    [Cell.contentView addSubview:separatorLineView];
    
    [Cell setDataForUserWith:[_scheduleArry objectAtIndex:indexPath.row]];
    
    return Cell;
}

#pragma mark - CustomTblViewCell Delegates

- (void)sendDetailDataForCell:(ScheduleJobCell *)cell
{
    
    _detailViewCont=[[JobStatusDetailViewController alloc]initWithNibName:@"JobStatusDetailViewController" bundle:nil];
    _detailViewCont.detailModel=[_scheduleArry objectAtIndex:cell.tag];
    [self presentViewController:_detailViewCont animated:YES completion:nil];
}


- (IBAction)backActn:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
