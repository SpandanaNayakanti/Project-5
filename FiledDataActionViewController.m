//
//  FiledDataActionViewController.m
//  WorkForceTracker
//
//  Created by Admin on 21/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//



#import "FiledDataActionViewController.h"
#import "XMLDictionary.h"
#import "AppDelegate.h"
#import "SBJSON.h"



@interface FiledDataActionViewController ()<WFTKeyToolBarDelegate>
{
    NSString *str;
    UIDatePicker *datePicker_;
    UIPickerView *dropDownPicker_;
    NSArray *dropDownListArry_;
    IBOutlet UIScrollView *scrollViewFields_;
    UIBarButtonItem *prev_,*next_,*flexSpace_,*done_;
    NSMutableArray *barbuttonsArray_;
    NSString *firstValue;
    NSString *secValue;
    NSMutableDictionary *serverData_;
    UIImagePickerController *imagePicker_;
    NSData *imageDataForPNG_ ;
    
    AppDelegate *appDelegate_;
    ASIFormDataRequest *formDataRequest_;
    
    WFTKeyToolBar *keyBoardToolBar_;
    WFTKeyToolBar *pickerToolBar_;
    WTFTextField  *textField_;
    WFTButton     *btn_;
    
    NSMutableArray *arrayValues_;
    UIView* separatorLineView_;
    
    UITextField *txtCurrent_;
}

@end

@implementation FiledDataActionViewController

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
        if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Text"]||[[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Dropdown"])
        {
            if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"1"])
            {
            textField_=[[WTFTextField alloc]initWithFrame:CGRectMake(30, y, 250, 30) withTag:i+1 withType:[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_type"] isMandatory:[[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_require"] boolValue] withTagName:[[_uiElementsArry objectAtIndex:i] valueForKey:@"tag_name"]];

            textField_.delegate=self;
            textField_.borderStyle=UITextBorderStyleLine;
            textField_.textColor=[UIColor whiteColor];
            
            UIColor *color = [UIColor grayColor];
            
            if ([textField_.Type isEqualToString:@"DATE"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyy-MM-dd"];
                textField_.text = [NSString stringWithFormat:@" %@",[dateFormatter stringFromDate:[NSDate date]]];
            }
           
        if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"Dropdown"])
            {
                
                NSString *dropDownString=[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_option"] ;
                
                dropDownListArry_=[dropDownString componentsSeparatedByString:@","];
                textField_.text = [NSString stringWithFormat:@" %@",[dropDownListArry_ objectAtIndex:0]];
                
                NSLog(@"%@",dropDownListArry_);
            }
 
         
    textField_.placeholder=[NSString stringWithFormat:@" %@",[[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_name"] capitalizedString]];
        

            UIColor *color1 = [UIColor whiteColor];
        textField_.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField_.placeholder attributes:@{NSForegroundColorAttributeName: color1}];
            
                [scrollViewFields_ addSubview:textField_];
 
        
            
            
            [arrayValues_ addObject:textField_];
            y=textField_.frame.origin.y+textField_.frame.size.height+10;
            }

        }
        
        if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"form_field_type"] isEqualToString:@"File"])
        {
            btn_=[[WFTButton alloc]initWithFrame:CGRectMake(191, y, 95, 40) withTag:i isMandatory:[[[_uiElementsArry objectAtIndex:i] valueForKey:@"field_require"] boolValue] withTagName:[[_uiElementsArry objectAtIndex:i] valueForKey:@"tag_name"]];
            
            [btn_ setImage:[UIImage imageNamed:@"btn_browse_n.png"] forState:UIControlStateNormal];
            
            _attachmentLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, y, 150, 40)];
            _attachmentLbl.text=@"Add Attachment";
            _attachmentLbl.textColor=[UIColor whiteColor];
            
            if ([[[_uiElementsArry objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"1"])
            {
                
            [scrollViewFields_ addSubview:btn_];
            [scrollViewFields_ addSubview:_attachmentLbl];
                
            [btn_ addTarget:self action:@selector(browseFile:) forControlEvents:UIControlEventTouchUpInside];
                
                y=btn_.frame.origin.y+btn_.frame.size.height+10;
                [arrayValues_ addObject:_attachmentLbl];
                [arrayValues_ addObject:btn_];
                
            }
        }
       
        _addBtn.frame=CGRectMake(_addBtn.frame.origin.x, y, _addBtn.frame.size.width, _addBtn.frame.size.height);
        _cancelBtn.frame=CGRectMake(_cancelBtn.frame.origin.x, y, _cancelBtn.frame.size.width, _cancelBtn.frame.size.height);
        
    }
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"ui elements :%@",_uiElementsArry);
    
    _form_nameLbl.text=[_form_Name capitalizedString];
    arrayValues_=[[NSMutableArray alloc]init];
    serverData_=[[NSMutableDictionary alloc]init];

    [self customClass];
    scrollViewFields_.contentInset = UIEdgeInsetsMake(-65, 0, 0, 0);
    
    appDelegate_=(AppDelegate*)[[UIApplication sharedApplication] delegate];

    [self WFT_showDatePicker];
    [self WFT_showDropDownPicker];
    
    keyBoardToolBar_ = [[WFTKeyToolBar alloc] initWithFrame:CGRectMake(0, 0, 320, 45) withDelegate:self withPreviousNextItems:YES];
    
    pickerToolBar_ = [[WFTKeyToolBar alloc] initWithFrame:CGRectMake(0, WINDOW_HEIGHT-216-45, 320, 45) withDelegate:self withPreviousNextItems:YES];
    
    pickerToolBar_.hidden = YES;
    
    [self.view addSubview:pickerToolBar_];
    
    if (WINDOW_HEIGHT >= 568)
    {
        [scrollViewFields_ setContentSize:CGSizeMake(320, WINDOW_HEIGHT+100)];
    }
    else
    {
      [scrollViewFields_ setContentSize:CGSizeMake(320, WINDOW_HEIGHT+200)];
    }
    
    
    
    
//    _tollbarForTxtFld=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
//    //[self.view addSubview:_tollbarForTxtFld];
//   // _tollbarForTxtFld.hidden=YES;
//    barbuttonsArray_=[[NSMutableArray alloc]init];
//    prev_=[[UIBarButtonItem alloc]initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(PrevoiusAction:)];
//    [barbuttonsArray_ addObject:prev_];
//    next_=[[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(NextActn:)];
//    [barbuttonsArray_ addObject:next_];
//    flexSpace_=[[UIBarButtonItem alloc]initWithTitle:@"FlexSpace" style:UIBarButtonItemStylePlain target:self action:@selector(FlexSpaceActn:)];
//    [barbuttonsArray_ addObject:flexSpace_];
//    done_=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(DoneActn:)];
//    [barbuttonsArray_ addObject:done_];
//    [_tollbarForTxtFld setItems:barbuttonsArray_];
    
    //int y=70;
}


- (void)WFT_showDatePicker
{
    datePicker_ = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,WINDOW_HEIGHT-216 , 320, 216)];
    datePicker_.datePickerMode = UIDatePickerModeTime;
    
    datePicker_.minimumDate = [NSDate date];
    datePicker_.backgroundColor=[UIColor whiteColor];
    datePicker_.maximumDate = [NSDate dateWithTimeIntervalSince1970:100*60*60*24];
    datePicker_.hidden = YES;
    [self.view addSubview:datePicker_];
}

-(void)WFT_showDropDownPicker
{
    dropDownPicker_=[[UIPickerView alloc]initWithFrame:CGRectMake(0, WINDOW_HEIGHT-216, 320, 216)];
    dropDownPicker_.delegate=self;
    dropDownPicker_.dataSource=self;
    [dropDownPicker_ setBackgroundColor:[UIColor whiteColor]];
    dropDownPicker_.hidden = YES;
    [self.view addSubview:dropDownPicker_];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return dropDownListArry_.count;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dropDownListArry_ objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    txtCurrent_.text=[dropDownListArry_ objectAtIndex:row];
    [txtCurrent_ resignFirstResponder];
  
}

//
   - (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)WFT_setScrollViewEditingPosition
{
    [scrollViewFields_ setUserInteractionEnabled:YES];
    [scrollViewFields_ setScrollEnabled:YES];
    //[scrollViewFiledData_ setContentSize:CGSizeMake(320, 3500)];
    
    //[scrollViewFiledData_ setBackgroundColor:[UIColor greenColor]];
    
     [scrollViewFields_ setContentSize:CGSizeMake(320, 800)];
}

- (void)WFT_setScrollViewZeroPosition
{
    [scrollViewFields_ setContentSize:CGSizeMake(320, WINDOW_HEIGHT+150)];
    [scrollViewFields_ setContentOffset:CGPointZero animated:NO];
}

- (NSArray *)WFT_getSubViews
{
    
    NSMutableArray *arraySubViews = [NSMutableArray new];
    
    for (UIView *view in [scrollViewFields_ subviews]) {
        
        if ([view isKindOfClass:[WTFTextField class]])
        {
            [arraySubViews addObject:view];
        }
    }
    return arraySubViews;
}

- (BOOL)WFT_isValidTextFields
{
    NSArray *arraySub = [self WFT_getSubViews];
    
    for (WTFTextField *txtField in arraySub) {
        
        if (txtField.isMandatory)
        {
            if (txtField.text.length == 0)
            {
                // show alertview
                
                NSLog(@"");
                return NO;
            }
        }
        
    }
    
    return YES;
}

- (void)WFT_storeValuesTimeSheet
{
    
    arrayValues_ = [[NSMutableArray alloc] init];
    serverData_=[[NSMutableDictionary alloc] init];
    NSArray *arraySub = [self WFT_getSubViews];
    
    for (WTFTextField *txtField in arraySub) {
        
        if (txtField.isMandatory)
        {
            for (int idx = 0; idx<_uiElementsArry.count; idx++) {
                
                if ([txtField.placeholder isEqualToString:[[_uiElementsArry objectAtIndex:idx] valueForKey:@"field_name"]])
                {
                    // show alertview
                    
                    // NSLog(@"");
                    
                    if (txtField.text.length != 0)
                    {
                        [arrayValues_ addObject:txtField.text];
                        
                        [serverData_ setObject:txtField.text forKey:txtField.placeholder];
                    }
                    else
                    {
                        //[arrayValues_ addObject:@""];
                        [serverData_ setObject:@"" forKey:txtField.placeholder];
                    }
                    
                    
                }
                
            };
            
            NSMutableString *requestString = [NSMutableString stringWithString:@"http:login/addform/"];
            
            for (int i = 0; i < _uiElementsArry.count ; i++)
            {
                [requestString appendString:[_uiElementsArry objectAtIndex:i]];
                [requestString appendString:@"="];
                [requestString appendString:[arrayValues_ objectAtIndex:i]];
                
                if (i < _uiElementsArry.count - 1)
                {
                    [requestString appendString:@"&"];
                
                }
            
            }
            
            
            //  http:login/addform/tak_id=10&task_name=@""$&iphone=1;
            
            //          else  if ([txtField.placeholder isEqualToString:@"2"])
            //            {
            //                // show alertview
            //
            //                NSLog(@"");
            //                
            //            }
        }
    }
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
        [self WFT_setScrollViewEditingPosition];
    
    
    //[textField setBackgroundColor:[UIColor redColor]];
     txtCurrent_ = textField;
    [textField setInputAccessoryView:keyBoardToolBar_];
    
    NSInteger tag =  txtCurrent_.tag;
    NSLog(@"%ld",(long)tag);
    
    
    //[scrollViewFields_ setContentOffset:CGPointMake(0, tag*textField.frame.size.height) animated:YES];
    
    datePicker_.hidden = YES;
    
    pickerToolBar_.hidden = YES;
    
    dropDownPicker_.hidden=YES;
    
   // NSArray *arraySubViews = [self WFT_getSubViews];
    
    
//    BOOL isValid = [self WFT_isValidTextFields];
    
   // for (WTFTextField *txtField in arraySubViews) {
        
    if ([textField.placeholder isEqualToString:@" Start Time"])
    {
            datePicker_.hidden = NO;
            pickerToolBar_.hidden = NO;
            [self.view endEditing:YES];
            return NO;
    }
    if ([textField.placeholder isEqualToString:@" End Time"])
    {
        datePicker_.hidden = NO;
        pickerToolBar_.hidden = NO;
        [self.view endEditing:YES];
        return NO;
    }
    if ([textField.placeholder isEqualToString:@"working date"])
    {
//        datePicker_.hidden = NO;
//        pickerToolBar_.hidden = NO;
        [self.view endEditing:YES];
        return NO;
    }
    if ([textField.placeholder isEqualToString:@"date"])
    {
//        datePicker_.hidden = NO;
//        pickerToolBar_.hidden = NO;
        [self.view endEditing:YES];
        return NO;
    }
    
    if ([textField.placeholder isEqualToString:@" Activities"])
    {
        datePicker_.hidden = YES;
        dropDownPicker_.hidden=NO;
        pickerToolBar_.hidden = NO;
        [self.view endEditing:YES];
        return NO;
    }
   // }
    
    

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self WFT_setScrollViewZeroPosition];
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

#pragma  mark - CustomToolBar Delegates

- (void)actionDoneBtn
{
    if ([txtCurrent_.placeholder isEqualToString:@" Start Time"])
    {
      [self WFT_getDateFromPicker];
    }
    if ([txtCurrent_.placeholder isEqualToString:@" End Time"])
    {
        [self WFT_getDateFromPicker];
    }
//    if ([txtCurrent_.placeholder isEqualToString:@"working date"])
//    {
//       // [self WFT_getDateFromPicker];
//    }
//    
//    if ([txtCurrent_.placeholder isEqualToString:@"date"])
//    {
//        [self WFT_getDateFromPicker];
//    }
    
    [txtCurrent_ resignFirstResponder];
    datePicker_.hidden = YES;
    dropDownPicker_.hidden=YES;
    pickerToolBar_.hidden = YES;
}

- (void)WFT_getDateFromPicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([txtCurrent_.placeholder isEqualToString:@" Start Time"]||[txtCurrent_.placeholder isEqualToString:@" End Time"])
    {
        
    [dateFormatter setAMSymbol:@"AM"];
    [dateFormatter setPMSymbol:@"PM"];
    //Specify only 1 M for month, 1 d for day and 1 h for hour
    [dateFormatter setDateFormat:@"h:mm a"];
        
    }
//    if ([txtCurrent_.placeholder isEqualToString:@"working date"]||[txtCurrent_.placeholder isEqualToString:@"date"])
//    {
//        [dateFormatter setDateFormat:@"yyy-MM-dd"];
//    }
    NSString *dateStr = [dateFormatter stringFromDate:[datePicker_ date]];
    
    txtCurrent_.text = dateStr;
}



- (void)actionPreviousBtn
{
    
    NSInteger tag = txtCurrent_.tag;
    
    UITextField *txtPrev = (UITextField *)[self.view viewWithTag:tag-1];
    
    [txtPrev becomeFirstResponder];
}

- (void)actionNextBtn
{
    NSInteger tag = txtCurrent_.tag;
    
    UITextField *txtPrev = (UITextField *)[self.view viewWithTag:tag+1];
    
    [txtPrev becomeFirstResponder];
    
}


- (IBAction)actionBtnBack:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelFormActn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)browseFile:(UIButton*)tag
{
    
    imagePicker_ = [[UIImagePickerController alloc] init];
    imagePicker_.delegate = self;
    // picker.allowsEditing = YES;
    imagePicker_.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:imagePicker_ animated:YES completion:NULL];
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    imageDataForPNG_ = UIImagePNGRepresentation(chosenImage);
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    __block    NSString *fileName = nil;
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
    [library assetForURL:imagePath resultBlock:^(ALAsset *asset)
     
     {
         fileName = asset.defaultRepresentation.filename;
         _attachmentLbl.text=fileName;
         
         NSLog(@"%@",fileName);
     }
            failureBlock:nil];
    

    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark submitting form to server

- (IBAction)submittFormActn:(UIButton *)sender
{
   
    for (int i=0; i<arrayValues_.count; i++)
    {
        if ([[arrayValues_ objectAtIndex:i] isKindOfClass:[UITextField class]])
        {
            textField_=[arrayValues_ objectAtIndex:i];
        if (textField_.isMandatory)
        {
            if (textField_.text.length==0)
            {
                
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker" message:[NSString stringWithFormat:@"Please Enter %@",textField_.placeholder] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                
                [alert show];
                return;
            }
            else
            {
                [serverData_ setObject:textField_.text forKey:textField_.tag_Name];
            }
        }
        else
        {
            [serverData_ setObject:textField_.text forKey:textField_.tag_Name];

            NSLog(@"hai");
        }
        }
        
       if ([[arrayValues_ objectAtIndex:i] isKindOfClass:[UIButton class]])
       {
           btn_=[arrayValues_ objectAtIndex:i];
           
           if (btn_.isMandatory)
           {
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker" message:[NSString stringWithFormat:@"Please attach the %@",btn_.tag_Name] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
               
               [alert show];
               return;
           }
       }
    }
    
     NSLog(@"%@",serverData_);
    
    [self WFT_sendRequest];
    
}

- (void)WFT_sendRequest
{
    
    
    [serverData_ setObject:appDelegate_.Emp_ID forKey:@"empid"];
    [serverData_ setObject:[appDelegate_.userInfoDict valueForKey:@"orgid"] forKey:@"orgid"] ;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serverData_ options:NSJSONWritingPrettyPrinted error:&error];
    NSString *resultAsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonData as string:\n%@ Error:%@", resultAsString,error);
    
    
//    NSArray *valueArray = [serverData_ allValues];
//    NSArray *keysArray = [serverData_ allKeys];
    
    NSString *strURL=[NSString  stringWithFormat:@"http://login.workforcetracker.net/services/addformRecord?form_id=%@&iphone=1&json_str=%@",_formId,resultAsString];
    NSLog(@"str URL %@",strURL);
    NSString* escapedUrlString = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedUrlString];
    
    formDataRequest_=[[ASIFormDataRequest alloc]initWithURL:url];

    [formDataRequest_ setDelegate:self];
    [formDataRequest_ setPostFormat:ASIMultipartFormDataPostFormat];
    [formDataRequest_ setTimeOutSeconds:60.0];
    if (imageDataForPNG_!=(NSData *)nil)
    {
        [formDataRequest_ setData:imageDataForPNG_  withFileName:@"CustomerImage.jpg" andContentType:@"image/jpeg" forKey:btn_.tag_Name];
        [formDataRequest_ setPostValue:appDelegate_.Emp_ID forKey:@"empid"];
    }
    [formDataRequest_ addRequestHeader:@"Content-Type" value:@"application/json"];
  
    [formDataRequest_ setRequestMethod:@"POST"];
    [formDataRequest_ setDidFinishSelector:@selector(claimItemDeleterequestSucceeded:)];
    [formDataRequest_ setDidFailSelector:@selector(claimItemDeleterequestFailed:)];
    
    [formDataRequest_ startAsynchronous];
    [_actvtyIndi startAnimating];
    
   
    
//NSMutableData *data = [[NSMutableData alloc] init];
//    self.receivedData = data;
//        NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];

    
//    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831466499882746641449"];
//    
//    NSString *urlString = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/addformRecord"];
//    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
//    
//    [request1 setURL:[NSURL URLWithString:urlString]];
//    [request1 setTimeoutInterval:50.0f];
//    [request1 setHTTPMethod:@"POST"];
//    
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    
//    [request1 addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    NSLog(@"request........%@",request1);
//    //	NSLog(@"token%@....senderemail%@....rname%@....radd1%@....message%@.....radd2%@.......rcity%@...%@...%@.....%@....%@",token,semail,rname,radd1,messageStr,radd2,rcity,rstate,rcountry,rzip,posttype);
//    
//    //================
//    NSMutableData *body = [NSMutableData data];
//    
//    
//    
//    NSArray *valueArray = [serverData_ allValues];
//    NSArray *keysArray = [serverData_ allKeys];
//    
//    for (int i = 0; i < serverData_.count ; i++)
//    {
//                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[keysArray objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[valueArray objectAtIndex:i] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    
//    NSString *phone=@"1";
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"iphone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[phone dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // close form
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    // set request body
//    
//    [request1 setHTTPBody:body];
//    //initialize a connection from request
   // NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    NSLog(@"%@",self.receivedData);
   // self.connection = connection;
    
    
    //start the connection
    //[connection start];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}
/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"%@hh" , error);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //initialize convert the received data to string with UTF8 encoding
     NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@" success %@" , htmlSTR);
    
   // NSMutableDictionary *userinfo=[[NSMutableDictionary dictionaryWithXMLString:htmlSTR] mutableCopy];
}
- (void)claimItemDeleterequestSucceeded:(ASIHTTPRequest *)request
{
    if (request==formDataRequest_)
    {
      
        NSString *responseString = [request responseString];
        //SBJSON *json=[[SBJSON alloc] init];
     //NSArray *itempArray=[json objectWithString:responseString error:nil];
        NSLog(@"RESPONSE STRING %@",responseString);
        
       NSMutableDictionary *userinfo=[[NSMutableDictionary dictionaryWithXMLString:responseString] mutableCopy];
        
        if ([[userinfo valueForKey:@"error"] isEqualToString:@"0"])
        {
            [_actvtyIndi stopAnimating];
           
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker" message:@"Form submitted successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            alert.tag=100;
            
            [alert show];
        }
  
        
    }
    
}

- (void)claimItemDeleterequestFailed:(ASIHTTPRequest *)request
{
    
    __unused NSString *errorResponse = [request responseString];
    NSLog(@"fail");
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag==100)
    {
        if (buttonIndex==0)
        {
             [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

}


@end


