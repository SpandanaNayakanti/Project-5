//
//  OtherViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 06/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITextView *statusTView;
    IBOutlet UIButton *cancelbtn;
    IBOutlet UIButton *okbtn;
}
-(IBAction)OkAction;
-(IBAction)CancelAction;
@property (strong, nonatomic)UITextView *statusTView;;

@end
