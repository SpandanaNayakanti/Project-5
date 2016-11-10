//
//  CustomMapViewController.m
//  ChildProtectionFinalProject
//
//  Created by Rapidsoft Systems on 12/08/11.
//  Copyright 2011 rapidsoft systems. All rights reserved.
//

#import "CustomMapViewController.h"


@implementation CustomMapViewController
@synthesize annotationView;
@synthesize emergencymapview;

-(id)initWithCustomeMapFrame:(CGRect)mapFrame anotImage:(UIImageView *)image{
if (self = [super initWithFrame:mapFrame]) {
	self.annotationView = image;

	self.delegate = self;
		
	self.showsUserLocation = YES;
}
	return self;
}
-(id)initWithCustomeMapFrame:(CGRect)mapFrame anotImage1:(UIImage *)image{
	if (self = [super initWithFrame:mapFrame]) {
		
		self.annotationView = [[UIImageView alloc] init];
		
		self.annotationView.image = image;
		
		self.delegate = self;
		
		self.showsUserLocation = YES;
	}
	return self;
}




#pragma mark 
#pragma mark MKMapViewDelegate
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{   
	
	NSData *imageData  =     UIImagePNGRepresentation(self.annotationView.image); 
	UIImage *myThumbNail    = [[UIImage alloc] initWithData:imageData];
	
	// begin an image context that will essentially "hold" our new image
	UIGraphicsBeginImageContext(CGSizeMake(40.0,40.0));
	
	// now redraw our image in a smaller rectangle.
	[myThumbNail drawInRect:CGRectMake(0.0, 0.0,40.0, 40.0)];
	//[myThumbNail release];
	
	// make a "copy" of the image from the current context
	UIImage *newImage    = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	MKAnnotationView  *currentLocationAnnView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	
		

	    UIImageView *one = [[UIImageView alloc] initWithFrame:CGRectMake(5,2,29,31)];
		one.image = newImage;
		one.userInteractionEnabled=YES;
		UIImageView *two = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self-annotation.png"]];
		two.userInteractionEnabled = YES;
		[two addSubview:one];
				
		
		
		//currentLocationAnnView.image = [UIImage imageNamed:@"current-location1.png"];
		currentLocationAnnView.image = newImage;
		//[currentLocationAnnView addSubview:one];
		currentLocationAnnView.userInteractionEnabled=YES;
		
		return currentLocationAnnView;
}	

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
 
//NSLog(@"DidUpdateUserLocation with %@",userLocation);
		
	double ulat1 = userLocation.coordinate.latitude;  
	double ulong1 = userLocation.coordinate.longitude;
	MKCoordinateRegion region;
	
	region.span.latitudeDelta = .005;
	region.span.longitudeDelta = .005;
	region.center = userLocation.coordinate;
	if (ulat1 != -180.000000 || ulong1 != -180.000000) {

	[self setRegion:region animated:YES];
	}
 }

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//NSLog(@"==============================center : %f and %f",(mapView.visibleMapRect.origin.x+320)/2,(mapView.visibleMapRect.origin.y+411)/2);
	
}


- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
	//NSLog(@"Inside Map will load===============================");
}
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
	//NSLog(@"mapViewWillStartLocatingUser=======================");
	
}
@end
