//
//  SettingViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 10/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
{
    IBOutlet UIButton *Btnback,*BtnTimeset,*TimeArrow;
    IBOutlet UISwitch *BtnSend;
    IBOutlet UILabel *LBLTimeSet;
}
-(IBAction)BackAction;
-(IBAction)TimeArrowAction;
- (IBAction)RegisterActn:(id)sender;

@end
