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
#import "GRFXATM.h"
#import "GMSMarker.h"
#import "GMSOverlay.h"
#import "GRFXATMDetailsViewController.h"
#import "GMSMapView+Animation.h"


@interface GRFXMapViewController ()
{
    GMSMapView *_mapView;
    GRFXATMProxy *_atmProxy;
    NSArray *_atms;
    GMSMarker *_selectedMarker;
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

- (void)viewDidAppear:(BOOL)animated
{

    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)initMap
{
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:BISHKEK_CENTER zoom:12];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:cameraPosition];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.settings.compassButton = YES;
    _mapView.delegate = self;
    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
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
    [self addMarkersToMap];
}

- (void)proxyRequestFailedWithError:(NSError *)error
{

}

- (void)addMarkersToMap
{
    for (GRFXATM *atm in _atms)
    {
        GMSMarker *marker = [GMSMarker markerWithPosition:atm.coordinate];
        marker.title = atm.bankName;
        marker.snippet = atm.address;
        marker.icon = [UIImage imageNamed:@"iconAtm.png"];
        marker.map = _mapView;
        marker.userData = atm;
    }
}

- (void)moveMapToMyLocation
{
    GMSCameraPosition *position = [GMSCameraPosition cameraWithTarget:_mapView.myLocation.coordinate zoom:14];
    [_mapView animateToCameraPosition:position];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    _selectedMarker = marker;
    [self performSegueWithIdentifier:@"ATMDetailsSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GRFXATMDetailsViewController *detailsViewController = segue.destinationViewController;
    detailsViewController.atm = _selectedMarker.userData;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"])
    {
        [self moveMapToMyLocation];
        [_mapView removeObserver:self forKeyPath:@"myLocation"];
    }
}
@end
