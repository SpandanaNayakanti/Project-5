//
//  JobStatusViewController.m
//  WorkForceTracker
//
//  Created by karthik  on 20/08/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "JobStatusViewController.h"
#import "AppDelegate.h"
#import "LogViewController.h"
#import "WFTUserModel.h"
#import "JobStatusDetailViewController.h"
#import "ActivitiesModel.h"
#import "CustomerSignatureViewController.h"


@interface JobStatusViewController ()<JobStatusCellDelegate>
{
    NSMutableArray *arrayModels_;
    ActivitiesModel *actvtyModel_;
    CustomerSignatureViewController *CSVC_;
    UIImagePickerController *imagePicker_;
    NSData *signDataForPNG_,*imageDataForPNG_;
    NSString *workermodulesId_;
    NSInteger cell_;
   
    
     IBOutlet UITableView *tblViewJobStatus_;
}

@property (nonatomic,strong)AppDelegate *appDelegate;
@end


@implementation JobStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _sgnature_imageView.hidden=YES;
    _commentTxtFld.delegate=self;
    _titleLbl.text=[NSString stringWithFormat:@"%@ Jobs",[self.jobStatus capitalizedString]];
    
    [self performSelector:@selector(statusAction) withObject:nil afterDelay:0.1];
   
    
    // Do any additional setup after loading the view from its nib.
}
-(void)statusAction
{
     self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"There is no internet connection" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        [alert show];
        
    }
    else
    {
    
    
   
    NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/empworkorderstatus?orgid=%@&empid=%@&status=%@&iphone=1",[self.appDelegate.userInfoDict valueForKey:@"orgid"],self. appDelegate.Emp_ID,self.jobStatus];
      //NSString *subURL=[NSString stringWithFormat:@"http://184.168.101.168/workforcetracker/services/empworkorderstatus?orgid=%@&empid=31&status=%@&iphone=1",[self.appDelegate.userInfoDict valueForKey:@"orgid"],self.jobStatus];
    

   
    NSLog(@"%@%@%@",[self.appDelegate.userInfoDict valueForKey:@"orgid"], self.appDelegate.Emp_ID,self.jobStatus );
    NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
   
    NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"string%@",string);
    NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
    NSLog(@"userInfoDict%@",userInfoDict);
     id emptask=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"emptask"];
    NSLog(@"emptask%@",emptask);
    
    
    
    
    arrayModels_ = [[NSMutableArray alloc] init];
    

    
    if ([emptask isKindOfClass:[NSDictionary class]])
   {
        NSLog(@"dictionary");
            NSDictionary *curDict=[[NSDictionary alloc]initWithDictionary:emptask];
            WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:curDict];
            [arrayModels_ addObject:model];
      //  return;
   }
    else if ([emptask isKindOfClass:[NSArray class]])
  {
                  NSLog(@"Array");
              
    for (NSDictionary *currentDict in emptask)
      {
        
        WFTUserModel *model = [[WFTUserModel alloc] initWithDictionary:currentDict];
        
        [arrayModels_ addObject:model];
        NSLog(@"%d",arrayModels_.count);
      
        
        
        }
         
     
   }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [tblViewJobStatus_ reloadData];
        
    });
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayModels_.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"JobStatusCell";
    JobStatusCell *Cell =(JobStatusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (Cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"JobStatusCell" owner:self options:nil];
        Cell = [cellArray objectAtIndex:0];
        
      //  Cell = [[JobStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
    }
    
    Cell.typeBtn = _typeBtn;
    [Cell setCellView];
   
    
    Cell.delegate = self;
    Cell.tag = indexPath.row;
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 169, 320, 1)];
    separatorLineView.backgroundColor = [UIColor blackColor]; // as per your requirement set color.
    [Cell.contentView addSubview:separatorLineView];

    

    [Cell setDataForUserWith:[arrayModels_ objectAtIndex:indexPath.row]];
    return Cell;
}







#pragma mark - CustomTblViewCell Delegates

- (void)sendDetailDataForCell:(JobStatusCell *)cell
{
    JobStatusDetailViewController *detailViewCont = [[JobStatusDetailViewController alloc] initWithNibName:@"JobStatusDetailViewController" bundle:nil];
    
    detailViewCont.typeBtn=cell.typeBtn;
    
    if (cell.typeBtn==btnTypeRunning)
    {
        NSLog(@"%@",[[arrayModels_ objectAtIndex:cell.tag] valueForKey:@"uId"]);
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/woitems?orgid=%@&workorder=%@&iphone=1",[self.appDelegate.userInfoDict valueForKey:@"orgid"],[[arrayModels_ objectAtIndex:cell.tag] valueForKey:@"uId"]];
        
        
        
        NSLog(@"%@%@",[self.appDelegate.userInfoDict valueForKey:@"orgid"],[[arrayModels_ objectAtIndex:cell.tag] valueForKey:@"uId"] );
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"string%@",string);
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"userInfoDict%@",userInfoDict);
        id emptask=[[NSDictionary dictionaryWithXMLString:string] valueForKey:@"emptask"];
        NSLog(@"emptask%@",emptask);
        _actvtyModelArry=[[NSMutableArray alloc]init];
        
        if (emptask)
        {
            
            
            
            if ([emptask isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"dictionary");
                NSDictionary *curDict=[[NSDictionary alloc]initWithDictionary:emptask];
                actvtyModel_ = [[ActivitiesModel alloc] initWithDictionary:curDict];
                [_actvtyModelArry addObject:actvtyModel_];
                
                
                
                detailViewCont.activityArry=[NSMutableArray arrayWithArray:_actvtyModelArry];
                //  return;
                
            }
            else if ([emptask isKindOfClass:[NSArray class]])
            {
                NSLog(@"Array");
                
                for (NSDictionary *currentDict in emptask)
                {
                    
                    actvtyModel_ = [[ActivitiesModel alloc] initWithDictionary:currentDict];
                    
                    
                    [_actvtyModelArry addObject:actvtyModel_];
                    NSLog(@"%d",_actvtyModelArry.count);
                    
                    
                }
                detailViewCont.activityArry=[NSMutableArray arrayWithArray:_actvtyModelArry];
              
                
            }

        

 
    }
    }
    detailViewCont.detailModel = [arrayModels_ objectAtIndex:cell.tag];
    [self presentViewController:detailViewCont animated:YES completion:nil];

}
-(void)updateJobForCell:(JobStatusCell *)cell
{
    if (_typeBtn==btnTypeAccepted)
    {
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/workorderupdatestatus?orgid=%@&workorderid=%@&changeto=running&iphone=1",[_appDelegate.userInfoDict valueForKey:@"orgid"] ,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]] ;
        NSLog(@"subURL");
        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
        NSLog(@"string%@%@",string,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]);
        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
        NSLog(@"userInfoDict%@",userInfoDict);
        NSString *jobid=[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"];
        
        if ([[userInfoDict valueForKey:@"error"] isEqualToString:@"0"])
        {
            [arrayModels_ removeObjectAtIndex:cell.tag];
            
            [tblViewJobStatus_ performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker"  message:[NSString stringWithFormat:@"Job %@ is successfully started",jobid] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            
            [alert show];
            
            
        }
       

        
    }
   else if(_typeBtn==btnTypePending)
    {
        
       NSLog(@"%@",[[arrayModels_ objectAtIndex:cell.tag] valueForKey:@"uId"]);
        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/workorderupdatestatus?orgid=%@&workorderid=%@&changeto=accept&iphone=1",[_appDelegate.userInfoDict valueForKey:@"orgid"] ,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]] ;
               NSLog(@"subURL%@",subURL);
                NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
               NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
          NSString *jobid=[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"];
        
               NSLog(@"string%@%@",string,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]);
                NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
                NSLog(@"userInfoDict%@",userInfoDict);
        
                if ([[userInfoDict valueForKey:@"error"] isEqualToString:@"0"])
                {
                    [arrayModels_ removeObjectAtIndex:cell.tag];
                    [tblViewJobStatus_ performSelectorOnMainThread:@selector(reloadData)
                                                        withObject:nil
                                                     waitUntilDone:NO];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker"  message:[NSString stringWithFormat:@"Job %@ is successfully Accepted",jobid] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    
                    [alert show];
                    
                    
                }
    }
   else if (_typeBtn==btnTypeRunning)
    {
        

        
//        NSLog(@"%d",cell.tag);
//        NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/workorderupdatestatus?orgid=%@&workorderid=%@&changeto=completed&iphone=1",[_appDelegate.userInfoDict valueForKey:@"orgid"] ,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]] ;
//        NSLog(@"subURL");
//
//        NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        
//       
//        NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
//        NSLog(@"string%@%@",string,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]);
//        NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
//        NSLog(@"userInfoDict%@",userInfoDict);
//        if (userInfoDict)
//        {
//            [arrayModels_ removeObjectAtIndex:cell.tag];
//            [tblViewJobStatus_ performSelectorOnMainThread:@selector(reloadData)
//                                                withObject:nil
//                                             waitUntilDone:NO];
//        }
       
        workermodulesId_=[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"] ;
        cell_=cell.tag;
        _sgnature_imageView.hidden=NO;
        tblViewJobStatus_.userInteractionEnabled=NO;
        tblViewJobStatus_.alpha=0.9;
        _backBtn.hidden=YES;
        
    }
    
}


- (IBAction)cancelActn:(id)sender
{
    _sgnature_imageView.hidden=YES;
    _backBtn.hidden=NO;
    tblViewJobStatus_.userInteractionEnabled=YES;
    tblViewJobStatus_.alpha=1.0;
}

- (IBAction)signatureActon:(id)sender
{
    
   CSVC_=[[CustomerSignatureViewController alloc]initWithNibName:@"CustomerSignatureViewController" bundle:nil];
    CSVC_.delegate=self;
    [self presentViewController:CSVC_ animated:YES completion:nil];
}

- (IBAction)browseImageActn:(UIButton *)sender
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
    imageDataForPNG_ = UIImageJPEGRepresentation(chosenImage, 0.9f);
    
    
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    __block    NSString *fileName = nil;
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
    [library assetForURL:imagePath resultBlock:^(ALAsset *asset)
     
     {
         fileName = asset.defaultRepresentation.filename;
                  
         NSLog(@"%@",fileName);
     }
            failureBlock:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)sendimageData:(UIImage *)image withName:(NSString *)name
{
    
    UIImage *image1=image;
    signDataForPNG_=UIImageJPEGRepresentation(image1, 0.9f);
    _sgnatureLbl.text=name;
    
    
    NSLog(@"%@%@",image1,name);
    
}
#pragma mark submitting the image and signature using post method

- (IBAction)submitUserSignImageActn:(UIButton *)sender
{
    if ([_commentTxtFld.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForceTracker" message:@" Please Enter Comment" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        
        [alert show];
        
    }
    else
    {
        
        [_actvtyIndi startAnimating];
        [_sgnature_imageView setUserInteractionEnabled:NO];
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831466499882746641449"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://login.workforcetracker.net/services/updatesignature?"];
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    
    [request1 setURL:[NSURL URLWithString:urlString]];
    [request1 setTimeoutInterval:50.0f];
    [request1 setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request1 addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSLog(@"request........%@",request1);
    //	NSLog(@"token%@....senderemail%@....rname%@....radd1%@....message%@.....radd2%@.......rcity%@...%@...%@.....%@....%@",token,semail,rname,radd1,messageStr,radd2,rcity,rstate,rcountry,rzip,posttype);
    
    //================
    NSMutableData *body = [NSMutableData data];
        
    
    //orgid parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"orgid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[_appDelegate.userInfoDict valueForKey:@"orgid"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //empid parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"empid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[_appDelegate.Emp_ID dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //employeetaskid Parameter
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"employeetasks_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[workermodulesId_ dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //comment parameter
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"comment\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[_commentTxtFld.text dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //sign Parameter
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"signature_attachment\"; filename=\"customerSignature.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:signDataForPNG_]];
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // imageparameter
    
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_attachment\"; filename=\"customerImage.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageDataForPNG_]];
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //iphone paramaeter
    NSString *phone=@"1";
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"iphone\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[phone dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // set request body
    
    [request1 setHTTPBody:body];
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    NSLog(@"%@",self.receivedData);
    self.connection = connection;
    
    
    //start the connection
    [connection start];
}



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
    
    NSMutableDictionary *userinfo=[[NSMutableDictionary dictionaryWithXMLString:htmlSTR] mutableCopy];
    
    if ([[userinfo valueForKey:@"error"] isEqualToString:@"0"])
    {
        NSLog(@"success");
        
        [_actvtyIndi startAnimating];
        
        _sgnature_imageView.hidden=YES;
        
        _sgnatureLbl.text=@"";
        
                NSString *subURL=[NSString stringWithFormat:@"http://login.workforcetracker.net/services/workorderupdatestatus?orgid=%@&workorderid=%@&changeto=completed&iphone=1",[_appDelegate.userInfoDict valueForKey:@"orgid"] ,workermodulesId_] ;
                NSLog(@"subURL");
        
                NSURL *URL = [NSURL URLWithString:[subURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
                NSString *string = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
               // NSLog(@"string%@%@",string,[[arrayModels_ objectAtIndex:cell.tag]valueForKey:@"uId"]);
                NSDictionary *userInfoDict = [[NSDictionary dictionaryWithXMLString:string] mutableCopy];
                NSLog(@"userInfoDict%@",userInfoDict);
                if ([[userInfoDict valueForKey:@"error"] isEqualToString:@"0"])
                {
                    
                    [arrayModels_ removeObjectAtIndex:cell_];
                   [tblViewJobStatus_ performSelectorOnMainThread:@selector(reloadData)
                                                        withObject:nil
                                                     waitUntilDone:NO];
                    
                    
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"WorkForce Tracker"  message:[NSString stringWithFormat:@"Job %@ is successfully completed",workermodulesId_] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                    
                    [alert show];
                    
                    _sgnature_imageView.hidden=YES;
                    _backBtn.hidden=NO;
                    _commentTxtFld.text=@"";
                    tblViewJobStatus_.userInteractionEnabled=YES;
                    tblViewJobStatus_.alpha=1.0;
                }
        
        
        
    }
    
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [_commentTxtFld resignFirstResponder];
}
-(BOOL)shouldAutorotate
{
    return NO;
}

@end
