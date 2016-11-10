//
//  OtherViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 06/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController
@synthesize statusTView;
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
    statusTView.delegate=self;
    
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)OkAction
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(IBAction)CancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [statusTView resignFirstResponder];
    }
    return YES;
}


@end
