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
    GRFXATMProxy *_atmProxy;
    NSArray *_atms;
}
@end

@implementation GRFXMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMap];
    _atmProxy = [GRFXATMProxy new];
    _atmProxy.delegate = self;
    [self fetchAllATMs];
}

- (void)initMap
{
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(42.8700000, 74.5900000) zoom:12];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:cameraPosition];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
}

- (void)fetchAllATMs
{
    [_atmProxy fetchAllTAMs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)atmProxyCompleteWithATMS:(NSArray *)array
{
    _atms = array;
}

- (void)proxyRequestFailedWithError:(NSError *)error
{

}

@end
