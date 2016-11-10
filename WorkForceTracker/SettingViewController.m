//
//  SettingViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 10/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    LBLTimeSet.text=appDelegate.timeSetString;
}

- (void)viewDidLoad
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    [super viewDidLoad];
    
    NSUserDefaults *uDefaults=[NSUserDefaults standardUserDefaults];
    if ([[uDefaults objectForKey:@"AutoLocation"] isEqualToString:@"ON"])
    {
        [BtnSend setOn:YES animated:NO];
    }
    else
    {
        [BtnSend setOn:NO animated:NO];
    }
    
    LBLTimeSet.text=appDelegate.timeSetString;
    // Do any additional setup after loading the view from its nib.
}
//-(IBAction)TimeSetAction
//{
//    timeSetVC =[[TimeSetViewController alloc] initWithNibName:@"TimeSetViewController" bundle:[NSBundle mainBundle]];
//    [self presentViewController:timeSetVC animated:YES completion:nil];
//    
//}
-(IBAction)TimeArrowAction
{
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    appDelegate.timeSetVC =[[TimeSetViewController alloc] initWithNibName:@"TimeSetViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:appDelegate.timeSetVC animated:YES completion:nil];
}

- (IBAction)RegisterActn:(id)sender
{
    if ([sender isOn])
    {
        NSUserDefaults *udefaults=[NSUserDefaults standardUserDefaults];
        [udefaults setValue:@"ON" forKey:@"AutoLocation"];
        
        if (LBLTimeSet.text.length==0 || [LBLTimeSet.text isEqualToString:@"0"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please select time interval" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            
            [alert show];
            
        }
       else if (appDelegate.timeSetVC.timerDuration>0)
        {
        
        appDelegate.timeSetVC.timer=[NSTimer scheduledTimerWithTimeInterval:appDelegate.timeSetVC.timerDuration
                                                                     target:appDelegate
                                                                   selector:@selector(UploadEmployeeLog)
                                                                   userInfo:nil
                                                                    repeats:YES];
        }

        
    }
    else
    {
        NSUserDefaults *udefaults=[NSUserDefaults standardUserDefaults];
        [udefaults setValue:@"OFF" forKey:@"AutoLocation"];
        [appDelegate.timeSetVC.timer invalidate];
    }
}

-(IBAction)BackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
