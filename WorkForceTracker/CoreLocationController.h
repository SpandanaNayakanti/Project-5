//
//  CoreLocationController.h
//  WorkForceTracker
//
//  Created by Pratibha on 12/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"


@protocol CoreLocationControllerDelegate
@required
- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end


@interface CoreLocationController : NSObject<CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) id delegate;

@end
