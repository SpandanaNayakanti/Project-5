//
//  ViewActivitiesViewController.m
//  WorkForceTracker
//
//  Created by karthik  on 27/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "ViewActivitiesViewController.h"

@interface ViewActivitiesViewController ()

@end

@implementation ViewActivitiesViewController

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
    
  
    NSLog(@"%d",_taskListArry.count);
    
    _tblActvts.delegate=self;
    NSLog(@"%@",[[_taskListArry objectAtIndex:0]valueForKey:@"uId"]);
    
    // Do any ,additional setup after loading the view from its nib.
}
- (IBAction)backActn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _taskListArry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"ViewActivitiesCell";
   ViewActivitiesCell  *Cell =(ViewActivitiesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (Cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"ViewActivitiesCell" owner:self options:nil];
        Cell = [cellArray objectAtIndex:0];
        
        //  Cell = [[JobStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, 320, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor]; // as per your requirement set color.
    [Cell.contentView addSubview:separatorLineView];
    
    [Cell setDataForUserWith:[_taskListArry objectAtIndex:indexPath.row] with:indexPath.row];
    return Cell;
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
