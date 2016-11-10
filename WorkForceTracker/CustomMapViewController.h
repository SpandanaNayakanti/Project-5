//
//  CustomMapViewController.h
//  ChildProtectionFinalProject
//
//  Created by Rapidsoft Systems on 12/08/11.
//  Copyright 2011 rapidsoft systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "BadGuyAnnotation.h"

@interface CustomMapViewController : MKMapView<MKMapViewDelegate> {
	UIImageView *annotationView;
	MKMapView *emergencymapview;
}
@property (nonatomic, retain) UIImageView *annotationView;
-(id)initWithCustomeMapFrame:(CGRect)mapFrame anotImage:(UIImageView *)image;
-(id)initWithCustomeMapFrame:(CGRect)mapFrame anotImage1:(UIImage *)image;
@property (nonatomic, retain) MKMapView *emergencymapview;

@end
