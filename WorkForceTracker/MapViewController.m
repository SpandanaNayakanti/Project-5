//
//  MapViewController.m
//  WorkForceTracker
//
//  Created by Pratibha on 12/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    
    mapView.showsUserLocation = YES;
    mapView.mapType=MKMapTypeStandard;
    mapView.delegate=self;
        
    self.locationController = [[CoreLocationController alloc] init];
    self.locationController.delegate = self;
    [self.locationController.locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)update:(CLLocation *)location
{
//    self->lblLatitude.text= [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
//    
//    self->lblLongitude.text = [NSString stringWithFormat:@"Longitude: %f", [location coordinate].longitude];
    

    
    //[mapView setCenterCoordinate:location.coordinate];

    [mapView setCenterCoordinate:location.coordinate animated:YES];
    
    if ([mapView showsUserLocation] == NO)
    {
        [mapView setShowsUserLocation:YES];
    }
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    
     //Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = @"Where am I?";
//    point.subtitle = @"I'm here!!!";
//    
//    [mapView addAnnotation:point];
}

- (void)locationError:(NSError *)error
{
    self->lblLatitude.text = [error description];
    self->lblLongitude.text = nil;
}
-(IBAction)BackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
{
    // When returning nil, it should show the default blue dot
    if(annotation == mapView.userLocation)
    {}
        
        return nil;
    
    // Dequeue the annotations for actual points, do whatever, and return the correct pins
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
