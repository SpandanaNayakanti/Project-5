//
//  TimeSetViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 18/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSetViewController : UIViewController
{
    IBOutlet UITableView *SetTimeTable;
    IBOutlet UIButton *BtnBack,*BtnCancel;
    NSMutableArray *titlesArry;
    NSIndexPath *indexPathOld;
    //NSTimer *timer;
    NSArray *arrDuration;
    //float timerDuration;

}
-(IBAction)BackAction;
-(IBAction)CancelAction;
-(void)TimerActionInitiate;
@property NSTimer *timer;
@property float timerDuration;

@end
