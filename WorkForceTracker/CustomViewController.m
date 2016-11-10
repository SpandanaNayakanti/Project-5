//
//  CustomViewController.m
//  WorkForceTracker
//
//  Created by karthik  on 10/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()
{
    NSString *str;
}

@end

@implementation CustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)customClass
{
      int y=70;
    for (int i=0; i<[_uiElementsArry count]; i++)
    {
        if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Text"])
        {
            WTFTextField *field=[[WTFTextField alloc]initWithFrame:CGRectMake(30, y, 250, 30) withTag:i+1 withType:[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_type"] isMandatory:[[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_require"] boolValue] withTagName:[[_uiElementsArry objectAtIndex:i] valueForKey:@"tag_name"]];
            field.delegate=self;
            
            field.placeholder=[[_uiElementsArry objectAtIndex:i] valueForKey:@"tag_name"];
            [self.view addSubview:field];
            
              y=field.frame.origin.y+field.frame.size.height;
            if (field.typeTextfield==TIME)
            {
                [self.view endEditing:YES];
            }
        }
         
     
        
}
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"ui elements :%@",_uiElementsArry);
    [self customClass];
    //int y=70;
}
//    for (int i=0; i<[_uiElementsArry count]; i++)
//    {
//        if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Text"])
//        {
//            
//            _txtField=[[UITextField alloc]initWithFrame:CGRectMake(30, y, 200,30)];
//            _txtField.delegate=self;
//           
//
//            
//            if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_type"] isEqualToString:@"VARCHAR"])
//            {
//                _txtField.keyboardType=UIKeyboardTypeAlphabet;
//            }
//            
//          else  if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_type"] isEqualToString:@"DECIMAL"])
//            {
//                _txtField.keyboardType=UIKeyboardTypeDecimalPad;
//            }
//          else  if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_type"] isEqualToString:@"TIME"])
//          {
//             
//              _txtField.userInteractionEnabled=NO;
//              _btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//              _btn.frame=CGRectMake(30, y, 200, 30);
//              [self.view addSubview:_btn];
//              [_btn addTarget:self action:@selector(showActnSht) forControlEvents:UIControlEventTouchUpInside];
//              _txtField.text=str;
//          }
//            _txtField.placeholder=[[_uiElementsArry objectAtIndex:i] valueForKey:@"tag_name"];
//            y=_txtField.frame.origin.y+_txtField.frame.size.height;
//            NSLog(@"%d",y);
//             [self.view addSubview:_txtField];
//                   }
//        
//        else if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Dropdown"])
//        {
//            
//        }
//    }
//    UIButton *br=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    br.frame=CGRectMake(20, y, 40,40);
//    [br setTitle:@"brh" forState:UIControlStateNormal];
//    [br addTarget:self action:@selector(databyTxtFld) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:br];
//	// Do any additional setup after loading the view.
//}
//-(void)databyTxtFld
//{
//    if ([_txtField.text isEqualToString:@""])
//    {
//        NSLog(@"entervalue");
//    }
//    NSLog(@"%@",str);
//}
//-(void)showActnSht
//{
//    
//    
//    [self addDatePickerWithDoneAndCancelButton];
//}
//
//
//-(UIActionSheet *)addDatePickerWithDoneAndCancelButton
//{
//    _actionSheet= [[UIActionSheet alloc] initWithTitle:@"Start Date"
//                                             delegate:nil
//                                    cancelButtonTitle:nil
//                               destructiveButtonTitle:nil
//                                    otherButtonTitles:nil];
//    
//    [_actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
//    
//    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
//    
//    
//    
//    _datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
//    
//    _datePicker.datePickerMode = UIDatePickerModeTime;
//    
//    
//    
//    [_actionSheet addSubview:_datePicker];
//    
//    
//    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
//    cancelButton.momentary = YES;
//    cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
//    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
//    cancelButton.tintColor = [UIColor grayColor];
//    [cancelButton addTarget:self action:@selector(clickOnCancelButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
//    //////////////////////////////////////////////
//    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
//    doneButton.momentary = YES;
//    
//    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
//    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
//    doneButton.tintColor = [UIColor grayColor];
//    [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
//    
//    [_actionSheet addSubview:cancelButton];
//    [_actionSheet addSubview:doneButton];
//    
//    
//    [_actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
//    
//    [_actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
//    return _actionSheet;
//}
//
//
//-(IBAction)clickOnCancelButtonOnActionSheet:(id)sender
//{
//    // actionSheet.hidden=YES;
//    //dataPickerView.hidden=YES;
//    [_actionSheet dismissWithClickedButtonIndex:0 animated:YES];
//    
//}
//-(IBAction)clickOnDoneButtonOnActionSheet:(id)sender
//{
//    
//   // NSString *formattedDate;
//    NSDate *date = _datePicker.date;
//    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"hh:mm:ss"];
//    [dateFormatter stringFromDate:date];
//    
//   str = [dateFormatter stringFromDate:date];
//    [_actionSheet dismissWithClickedButtonIndex:1 animated:YES];
//    
//    
//    
//    
//    [_actionSheet dismissWithClickedButtonIndex:1 animated:YES];
//    
//    
//}
//
//    - (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    str=textField.text;
    if ([textField.text isEqualToString:@""])
    {
        NSLog(@"%@ should not be empty",textField.placeholder);
        
        
        
        
    }
    
    
}

@end
