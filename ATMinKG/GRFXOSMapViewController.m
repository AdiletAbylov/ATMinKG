//
// Created by Adilet Abylov on 4/19/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GRFXOSMapViewController.h"
#import "MKMapView+ZoomLevel.h"
#import "RXCollection.h"
#import "GRFXATMDetailsViewController.h"
#import "GRFXATM.h"

@implementation GRFXOSMapViewController
{
    GRFXATMProxy *_atmProxy;
@private
    __weak MKMapView *_mapView;
    GRFXATM *_selectedATM;
}
@synthesize mapView = _mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *template = @"http://tile.openstreetmap.org/{z}/{x}/{y}.png";
    MKTileOverlay *overlay = [[MKTileOverlay alloc] initWithURLTemplate:template];
    overlay.canReplaceMapContent = YES;
    [_mapView addOverlay:overlay level:MKOverlayLevelAboveLabels];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _atmProxy = [[GRFXATMProxy alloc] init];
    _atmProxy.delegate = self;

}

- (void)atmProxyCompleteWithATMS:(NSArray *)array
{

    [_mapView addAnnotations:array];
}

- (void)proxyRequestFailedWithError:(NSError *)error
{

}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^
    {
        [_mapView setCenterCoordinate:userLocation.location.coordinate zoomLevel:12 animated:YES];
        [_atmProxy fetchAllTAMs];
    });

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *const indentifier = @"lll";
    if ([annotation isKindOfClass:[GRFXATM class]])
    {
        MKPinAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
        if (!view)
        {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentifier];
            view.annotation = annotation;
            view.canShowCallout = YES;
            view.enabled = YES;
            view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        return view;
    }
    return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    _selectedATM = view.annotation;
    [self performSegueWithIdentifier:@"ATMDetailsSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GRFXATMDetailsViewController *detailsViewController = segue.destinationViewController;
    detailsViewController.atm = _selectedATM;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKTileOverlay class]])
    {
        return [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay];
    }
    return nil;
}
@end