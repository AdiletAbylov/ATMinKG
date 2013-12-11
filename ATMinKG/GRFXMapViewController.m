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
#import "GMSMarker.h"
#import "GRFXATMDetailsViewController.h"
#import "GMSMapView+Animation.h"
#import "GRFXFilterButton.h"
#import "UIView+blur.h"
#import "GRFXFilterPredicates.h"

@interface GRFXMapViewController ()
{
    GMSMapView *_mapView;
    GRFXATMProxy *_atmProxy;
    GRFXBanksProxy *_banksProxy;
    NSArray *_atms;
    GMSMarker *_selectedMarker;
    NSArray *_banks;
    NSArray *_filteredAtms;
    GRFXFilterView *_filterView;
    GRFXFilterButton *_filterButton;
    NSString *_selectedBank;
    CardTypeFilter _selectedCardTypeFilter;
    UIImageView *_snapshotImageView;
}
@end

@implementation GRFXMapViewController
{

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMap];
    _atmProxy = [GRFXATMProxy new];
    _atmProxy.delegate = self;
    _banksProxy = [GRFXBanksProxy new];
    _banksProxy.delegate = self;
    _selectedBank = @"All Banks";
    _selectedCardTypeFilter = CardTypeFilterAll;

    [self fetchAllData];
    [self initFilterButtonAndView];

}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)initMap
{
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:BISHKEK_CENTER zoom:12];
    _mapView = [GMSMapView mapWithFrame:self.view.frame camera:cameraPosition];
    _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.settings.compassButton = YES;
    _mapView.delegate = self;
    [_mapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:_mapView];
}

- (void)initFilterButtonAndView
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"FilterView" owner:self options:nil];
    _filterView = [GRFXFilterView new];
    _filterView = (GRFXFilterView *) [views objectAtIndex:0];
    _filterView.frame = (CGRect) {0, self.view.frame.size.height, _filterView.frame.size};
    _filterView.delegate = self;

    _filterButton = [[GRFXFilterButton alloc] initWithFrame:(CGRect) {12, self.view.frame.size.height - 40 - 7, 241, 40}];
    [self.view addSubview:_filterButton];
    _filterButton.selectedBank = _selectedBank;
    _filterButton.selectedCardTypeFilter = _selectedCardTypeFilter;
    [_filterButton addTarget:self action:@selector(didTouchFilterButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_filterView];
}

- (void)fetchAllData
{
    [_atmProxy fetchAllTAMs];
    [_banksProxy fetchBanks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)atmProxyCompleteWithATMS:(NSArray *)array
{
    _atms = array;
    [self applyFilterWithCardTypeFilter:_selectedCardTypeFilter bankName:_selectedBank];
    [self showMarkersOnMap];
}

- (void)proxyRequestFailedWithError:(NSError *)error
{

}

- (void)banksProxySuccesWithBanks:(NSArray *)banks
{
    _banks = banks;
    NSMutableArray *array = [NSMutableArray arrayWithObject:@"All Banks"];
    [array addObjectsFromArray:banks];
    _filterView.banks = array;

}

- (void)banksProxyFailedWithMessage:(NSString *)message
{

}

- (void)showMarkersOnMap
{
    [_mapView clear];
    for (GRFXATM *atm in _filteredAtms)
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

- (void)filterViewDidApplyFilterForCards:(CardTypeFilter)cardTypeFilter bank:(NSString *)bank
{
    _selectedBank = bank;
    _selectedCardTypeFilter = cardTypeFilter;
    _filterButton.selectedCardTypeFilter = _selectedCardTypeFilter;
    _filterButton.selectedBank = _selectedBank;
    [self applyFilterWithCardTypeFilter:_selectedCardTypeFilter bankName:_selectedBank];
    [self showMarkersOnMap];
    [self hideFilterAnimated];
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

- (void)didTouchFilterButton:(id)sender
{
    [self showFilterAnimated];
}

- (void)initSnapshotImage
{
    UIImage *snapshot = [self.view blurredSnapshot];
    _snapshotImageView = [[UIImageView alloc] initWithImage:snapshot];
    _snapshotImageView.alpha = 0;
    _snapshotImageView.userInteractionEnabled = YES;
    [_snapshotImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchSnapshotImage:)]];
    [self.view insertSubview:_snapshotImageView belowSubview:_filterView];
}

- (void)didTouchSnapshotImage:(id)sender
{
    if (_snapshotImageView)
    {
        [self filterViewDidApplyFilterForCards:_filterView.selectedCardTypeFilter bank:_filterView.selectedBank];
    }
}

- (void)showFilterAnimated
{
    [self initSnapshotImage];
    [UIView animateWithDuration:0.3 animations:^
    {
        _filterView.frame = (CGRect) {0, self.view.frame.size.height - _filterView.frame.size.height, _filterView.frame.size};
        _snapshotImageView.alpha = 1;
    }                completion:^(BOOL finished)
    {
        _mapView.userInteractionEnabled = NO;
    }];
}

- (void)hideFilterAnimated
{
    [UIView animateWithDuration:0.3 animations:^
    {
        _filterView.frame = (CGRect) {0, self.view.frame.size.height, _filterView.frame.size};
        _snapshotImageView.alpha = 0;
    }                completion:^(BOOL finished)
    {
        _mapView.userInteractionEnabled = YES;
        [_snapshotImageView removeFromSuperview];
        [_snapshotImageView removeGestureRecognizer:[_snapshotImageView.gestureRecognizers objectAtIndex:0]];
        _snapshotImageView = nil;
    }];
}


- (void)applyFilterWithCardTypeFilter:(CardTypeFilter)cardTypeFilter bankName:(NSString *)bankName
{
    NSPredicate *predicate = [GRFXFilterPredicates predicateForCardTypeFilter:cardTypeFilter bankName:bankName];
    _filteredAtms = [_atms filteredArrayUsingPredicate:predicate];
}
@end
