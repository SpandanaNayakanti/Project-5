//
//  TrackingViewController.m
//  WorkForceTracker
//
//  Created by Anshu  on 27/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TrackingViewController.h"
#import "TableStatusVC.h"
#import "MapViewController.h"
#import "StatusViewController.h"

@interface TrackingViewController ()

@end
StatusViewController  *statusVC;
MapViewController     *mapVC;
TableStatusVC         *tableVC;


@implementation TrackingViewController

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

- (IBAction)backActn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)locatoinUpdate:(id)sender
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


- (IBAction)status:(id)sender
{
    activityIndi.hidden=NO;
    [activityIndi startAnimating];
    [self performSelector:@selector(Statusaction) withObject:nil afterDelay:0.1f];
}
-(void)Statusaction
{
    tableVC=[[TableStatusVC alloc]initWithNibName:@"TableStatusVC" bundle:[NSBundle mainBundle]];
    [self presentViewController:tableVC animated:YES completion:nil];
    [activityIndi stopAnimating];
}

- (IBAction)currentLocation:(id)sender
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
@end
