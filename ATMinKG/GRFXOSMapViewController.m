//
// Created by Adilet Abylov on 4/19/14.
// Copyright (c) 2014 Adilet Abylov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GRFXOSMapViewController.h"


@implementation GRFXOSMapViewController
{

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