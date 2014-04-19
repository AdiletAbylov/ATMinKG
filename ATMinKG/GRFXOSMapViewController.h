//
// Created by Adilet Abylov on 4/19/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class MKMapView;

@interface GRFXOSMapViewController : UIViewController <MKMapViewDelegate>
@property(weak) IBOutlet MKMapView *mapView;
@end