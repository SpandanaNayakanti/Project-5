//
//  TimeSheetViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 06/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "TimeSheetViewController.h"

@interface TimeSheetViewController ()

@end

@implementation TimeSheetViewController

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
    [self SetLeftView:dateTF];
    [self SetLeftView:timeTF];
    [self SetLeftView:endTF];
    [self SetLeftView:commentTF];

    // Do any additional setup after loading the view from its nib.
}
-(void)SetLeftView:(UITextField*)txtfieldN
{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtfieldN.frame.size.height)];
    leftView.backgroundColor = txtfieldN.backgroundColor;
    txtfieldN.leftView = leftView;
    txtfieldN.leftViewMode = UITextFieldViewModeAlways;
    txtfieldN.delegate=self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [dateTF resignFirstResponder];
    [timeTF resignFirstResponder];
    [endTF resignFirstResponder];
    [commentTF resignFirstResponder];
   return YES;
}
-(IBAction)AddAction
{
    
}
-(IBAction)CancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)BrowseAction
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
