//
//  GRFXMapViewController.h
//  ATMinKG
//
//  Created by Adilet Abylov on 10/25/13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google-Maps-iOS-SDK/GoogleMaps/GMSMapView.h>
#import "GRFXATMProxy.h"

@interface GRFXMapViewController : UIViewController<GRFXATMProxyDelegate, GMSMapViewDelegate>

@end
