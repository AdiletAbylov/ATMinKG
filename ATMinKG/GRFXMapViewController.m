//
//  GRFXMapViewController.m
//  ATMinKG
//
//  Created by Adilet Abylov on 10/25/13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "GRFXMapViewController.h"
#import "GMSMapView.h"
#import "GMSCameraPosition.h"



@interface GRFXMapViewController ()
{
    GMSMapView *_mapView;
}
@end

@implementation GRFXMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(42.8700000, 74.5900000) zoom:12];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:cameraPosition];
    _mapView.myLocationEnabled = YES;
    self.view  = _mapView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
