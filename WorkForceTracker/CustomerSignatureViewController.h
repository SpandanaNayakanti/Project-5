//
//  CustomerSignatureViewController.h
//  WorkForceTracker
//
//  Created by Anshu  on 18/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothLineView.h"

@protocol CustomerSignatureDelegate ;
@interface CustomerSignatureViewController : UIViewController



@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)UIButton* resetBtn;
@property NSMutableArray *lastPointsArr;
@property NSMutableArray *currentPointsArr;
@property int currentPosition;
@property int lFloorsCount;
//@property NSMutableArray * captureImages;
@property UIImage *lAnnotatedTaskImage;
@property int lCurretnTag;
@property NSMutableDictionary *lAnnotatedImagesDictionary;
//@property UIPopoverController * popOverViewController;

@property (nonatomic , strong) UIImage *image;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic,strong) UIBarButtonItem *saveButtonItem;
@property (nonatomic,strong)UIBarButtonItem *resetButtonItem;
- (IBAction)termsAndConditions:(id)sender;

- (IBAction)backActn:(id)sender;

@property (nonatomic , weak) id <CustomerSignatureDelegate>delegate;
@end


@protocol CustomerSignatureDelegate <NSObject>

-(void)sendimageData:(UIImage*)image withName:(NSString*)name;

@end





