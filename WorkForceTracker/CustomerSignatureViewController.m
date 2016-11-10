//
//  CustomerSignatureViewController.m
//  WorkForceTracker
//
//  Created by Karthik  on 18/09/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "CustomerSignatureViewController.h"
#import "AppDelegate.h"

@interface CustomerSignatureViewController ()
{
    AppDelegate *app;
}

@property (nonatomic) SmoothLineView * canvas;
@property (nonatomic,strong)SmoothLineView * smoothLineView;

@end


@implementation CustomerSignatureViewController

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
    
    
    app=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    if (WINDOW_HEIGHT >= 568)
    {
        self.smoothLineView =[[SmoothLineView alloc] initWithFrame:CGRectMake(0, 60, 320, WINDOW_HEIGHT-140)];

    }
    else
    {
        self.smoothLineView =[[SmoothLineView alloc] initWithFrame:CGRectMake(0, 60, 320, WINDOW_HEIGHT-140)];
    }
    
    
    self.smoothLineView.csvc=self;
    [self.smoothLineView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.canvas = _smoothLineView;
    [self.view addSubview:_smoothLineView];
    
  


    // Do any additional setup after loading the view from its nib.
}
-(BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)   savedPhotoImage:(UIImage *)image
  didFinishSavingWithError:(NSError *)error
               contextInfo:(void *)contextInfo
{
    NSString *message = @"This image has been saved to your Photos album";
    if (error) {
        message = [error localizedDescription];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //[self.canvas clear];
}

//
//-(void)saveBtnAction
//{
//    if (self.smoothLineView.isEmpty==YES)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                        message:@"Please do Sign and save"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    UIGraphicsBeginImageContext( self.smoothLineView.bounds.size);
//    [self.smoothLineView drawRect:self.view.bounds];
//    [self.smoothLineView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    NSLog(@"%@",NSStringFromCGRect(self.smoothLineView.bounds));
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"MyFolder"];
//    
//    NSData *imageData = UIImagePNGRepresentation(image);
//    NSString *personName=@"customer";
//    NSString *fileName = [filePath stringByAppendingPathComponent:
//                          [NSString stringWithFormat:@"%@.png", personName]];
//    
//    //creates an image file with the specified content and attributes at the given location
//    [fileManager createFileAtPath:fileName contents:imageData attributes:nil];
//    
//    //    NSString *strImage=[NSString stringWithFormat:@"%@.jpeg",image];
//    //    ;
//    //
//    NSData *dataForPNGFile = UIImageJPEGRepresentation(image, 0.9f);
//    //
//    NSString* myString;
//    myString = [[NSString alloc] initWithData:dataForPNGFile encoding:NSASCIIStringEncoding];
//    //
//    //
//    
//    
//    
//    NSLog(@"%@",fileName);
//    
//    
//    UIImageWriteToSavedPhotosAlbum(image,
//                                   self,
//                                   @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:),
//                                   NULL);
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    
//    // picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    
//    NSLog(@"%@",picker);
//    
//    
//}
////-(void)okBtnAction{
////
////    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
////
////
//}
-(void)resetBtnAction
{
   
    [self.canvas clear];
    [self.smoothLineView clear];
    self.smoothLineView.isEmpty=YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)termsAndConditions:(id)sender
{
    
    UIGraphicsBeginImageContext( self.smoothLineView.bounds.size);
    [self.smoothLineView drawRect:self.view.bounds];
    [self.smoothLineView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    NSLog(@"%@",NSStringFromCGRect(self.smoothLineView.bounds));
    
    _image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  
    

    [_delegate sendimageData:_image withName:@"customer.jpg"];
    
    UIImageWriteToSavedPhotosAlbum(_image,
                                   self,
                                   @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
    
   

}

- (IBAction)backActn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}
//- (NSUInteger) supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}
//- (void)willAnimateRotationToInterfaceOrientation:
//(UIInterfaceOrientation)toInterfaceOrientation
//                                         duration:(NSTimeInterval)duration
//{
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft)
//    {
//        
//        CGFloat windowHeight = [UIScreen mainScreen].bounds.size.height;
//        CGFloat windowWidth = [UIScreen mainScreen].bounds.size.width;
//        //_termsAndCndtnsBtn.frame = CGRectMake(0, 300, 200, 40);
//        _smoothLineView.frame=CGRectMake(0, 70, windowHeight, windowWidth-150);
//       // [_smoothLineView setBackgroundColor:[UIColor blackColor]];
//       
//    }
//    
//}



@end
