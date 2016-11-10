//
//  StatusViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 05/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OtherViewController.h"
#import "XMLDictionary.h"

@interface StatusViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tblStatus;
    IBOutlet UIButton *okBtn;
    IBOutlet UIButton *cancelBtn;
    NSMutableArray *titlesArry;
    NSIndexPath *indexPathOld;
    NSString *statusOther,*statusSelected;
    OtherViewController *otherVC;
    AppDelegate *appDelegate;

}
@property (strong, nonatomic)NSString *statusOther;
-(IBAction)CancelAction;
-(IBAction)OkAction;

- (IBAction)backActn:(UIButton *)sender;
@end
