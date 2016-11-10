//
//  JobStatusViewController.h
//  WorkForceTracker
//
//  Created by karthik  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobStatusCell.h"
#import "CustomerSignatureViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "Reachability.h"





@interface JobStatusViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CustomerSignatureDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong)NSString *jobStatus;
@property (nonatomic,strong)NSString *orgId;
@property (nonatomic , strong) CustomerSignatureViewController *CSVC;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actvtyIndi;


@property (strong, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backAction:(id)sender;
 
@property (strong, nonatomic) IBOutlet UIView *sgnature_imageView;
@property (strong, nonatomic) IBOutlet UITextField *commentTxtFld;


@property (strong, nonatomic) IBOutlet UILabel *sgnatureLbl;

@property (nonatomic ,assign) cellType typeCell;
@property (nonatomic ,assign) btnType typeBtn;
@property (nonatomic ,strong) NSMutableArray *actvtyModelArry;
- (IBAction)cancelActn:(id)sender;
- (IBAction)signatureActon:(id)sender;
- (IBAction)browseImageActn:(UIButton *)sender;
- (IBAction)submitUserSignImageActn:(UIButton *)sender;

@end
