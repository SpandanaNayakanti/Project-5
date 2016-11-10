//
//  CoreLocationController.m
//  WorkForceTracker
//
//  Created by Pratibha on 12/02/14.
//  Copyright (c) 2014 Pratibha. All rights reserved.
//

#import "CoreLocationController.h"
#import "CoreLocation/CoreLocation.h"


@implementation CoreLocationController

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.delegate update:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.delegate locationError:error];
}

@end
