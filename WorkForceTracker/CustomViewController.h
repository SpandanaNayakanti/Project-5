//
//  CustomViewController.h
//  WorkForceTracker
//
//  Created by karthik  on 10/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTFTextField.h"

@interface CustomViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic , strong) NSMutableArray *uiElementsArry;
@property (nonatomic , strong) UITextField *txtField;
@property (nonatomic , strong) UIActionSheet *actionSheet;
@property (nonatomic , strong) UIDatePicker *datePicker;
@property (nonatomic , strong) UIButton *btn;
@property (nonatomic , strong) UILabel *lbl;
@property (nonatomic , strong) NSDateFormatter *df;
@property (nonatomic , strong) NSDate *dt;
@property (nonatomic , assign) txtFieldType *typeTxtFld;

@end
