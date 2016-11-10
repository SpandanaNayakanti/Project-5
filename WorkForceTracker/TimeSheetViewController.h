//
//  TimeSheetViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 06/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSheetViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *dateTF;
    IBOutlet UITextField *timeTF;
    IBOutlet UITextField *endTF;
    IBOutlet UITextField *commentTF;
    IBOutlet UIButton *btnBrowse;
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *btnCancel;
}
-(IBAction)AddAction;
-(IBAction)CancelAction;
-(IBAction)BrowseAction;
@end
