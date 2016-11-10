//
//  TrackingViewController.h
//  WorkForceTracker
//
//  Created by karthik  on 27/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrackingViewController : UIViewController
{

    IBOutlet UIActivityIndicatorView *activityIndi;


}

- (IBAction)backActn:(id)sender;

- (IBAction)locatoinUpdate:(id)sender;

- (IBAction)status:(id)sender;

- (IBAction)currentLocation:(id)sender;
@end
