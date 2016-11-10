//
//  TableStatusVC.h
//  WorkForceTracker
//
//  Created by Pratibha on 10/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLDictionary.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@interface TableStatusVC : UIViewController<UITableViewDataSource>
{
    IBOutlet UITableView *TblStatus;
    IBOutlet UIButton *Btnback;
    NSMutableArray *arrStatus;
}
-(IBAction)BackAction;
@end
