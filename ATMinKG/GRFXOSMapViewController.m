//
// Created by Adilet Abylov on 4/19/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GRFXOSMapViewController.h"
#import "MKMapView+ZoomLevel.h"
#import "RXCollection.h"
#import "GRFXATM.h"

@implementation GRFXOSMapViewController
{
    GRFXATMProxy *_atmProxy;
@private
    __weak MKMapView *_mapView;
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
    NSArray *annotations = [array rx_mapWithBlock:^id(id each)
    {
        return ((GRFXATM *) each).annotation;
    }];
    [_mapView addAnnotations:annotations];
}

- (void)proxyRequestFailedWithError:(NSError *)error
{

}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^
    {
        [_mapView setCenterCoordinate:userLocation.location.coordinate zoomLevel:9 animated:YES];
        [_atmProxy fetchAllTAMs];
    });

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *const indentifier = @"lll";
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKPinAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
        if (!view)
        {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentifier];
            view.annotation = annotation;
        }

        return view;
    }
    return nil;
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