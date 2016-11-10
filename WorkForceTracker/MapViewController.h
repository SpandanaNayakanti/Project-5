//
//  MapViewController.h
//  WorkForceTracker
//
//  Created by Pratibha on 12/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"

@interface MapViewController : UIViewController<CoreLocationControllerDelegate,MKMapViewDelegate>
{
    IBOutlet UIButton *Btnback;
    IBOutlet MKMapView *mapView;
    IBOutlet UILabel *lblLatitude,*lblLongitude;
}
@property (nonatomic, retain) CoreLocationController *locationController;

-(IBAction)BackAction;
@end
