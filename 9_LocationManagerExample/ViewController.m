//
//  ViewController.m
//  9_LocationManagerExample
//
//  Created by tigi on 13/03/2019.
//  Copyright © 2019 tigi. All rights reserved.
//

/*
 Must add one or more of the things below in info.plist
 
 Privacy - Location When In Use Usage Description
 Privacy - Location Always Usage Description
 Privacy - Location Always and When In Use Usage Description
*/


#import "ISDebugLog.h"
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property(nonatomic, readwrite) CLLocationManager *locationManager;
@property(nonatomic, readwrite) CLGeocoder *geocoder;

@property(nonatomic, readwrite) UIButton *locationButton;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 500;
    
    _geocoder = [[CLGeocoder alloc] init];
    
    [self setupLocationButton];
}

- (void)viewDidAppear:(BOOL)aAnimated
{
    [super viewDidAppear:aAnimated];
    
//    [self checkPermissionOfLocation];
}

- (void)setupLocationButton
{
    _locationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_locationButton setTitle:@"GET MY LOCATION" forState:UIControlStateNormal];
    
    [_locationButton addTarget:self action:@selector(actionLocationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_locationButton sizeToFit];
    
    [self.view addSubview:_locationButton];
    
    _locationButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_locationButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [_locationButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
}


#pragma mark - action


- (void)actionLocationButton:(id)aSender
{
    [_locationManager startUpdatingLocation];
}


#pragma mark - private


//- (BOOL)isPermissionAuthOfLocation
//{
//    BOOL sResult = YES;
//
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ||
//        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
//    {
//        sResult = NO;
//    }
//
//    return sResult;
//}
//
//- (void)checkPermissionOfLocation
//{
//    BOOL sLocationEnabled = [CLLocationManager locationServicesEnabled];
//    BOOL sLoactionAuthPermission = [self isPermissionAuthOfLocation];
//
//    if (!sLocationEnabled || !sLoactionAuthPermission)
//    {
//        [_locationManager requestWhenInUseAuthorization];
//    }
//}

- (void)showAlertWithTitle:(NSString *)aTitle message:(NSString *)aMessage actionHandler:(void (^ __nullable)(UIAlertAction *action))aHandler
{
    UIAlertController *sAlertController = [UIAlertController alertControllerWithTitle:aTitle
                                                                              message:aMessage
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sAction = [UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:aHandler];
    [sAlertController addAction:sAction];
    
    [self presentViewController:sAlertController animated:YES completion:nil];
}


#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)aManager didFailWithError:(NSError *)aError
{
    [_locationManager stopUpdatingLocation];
    ISDebugLog(@"didFailWithError: %@", aError);
    
    [self showAlertWithTitle:@"Failed to Get Your Location" message:[aError localizedDescription] actionHandler:nil];
}

- (void)locationManager:(CLLocationManager *)aManager didUpdateLocations:(NSArray<CLLocation *> *)aLocations
{
    [_locationManager stopUpdatingLocation];
    ISDebugLog(@"didUpdateToLocation: %@", [aLocations lastObject]);
    
    CLLocation *sCurrentLocation = [aLocations lastObject];
    NSString *sLongitude = [NSString stringWithFormat:@"%.8f", sCurrentLocation.coordinate.longitude];
    NSString *sLatitude = [NSString stringWithFormat:@"%.8f", sCurrentLocation.coordinate.latitude];
    
    [_geocoder reverseGeocodeLocation:sCurrentLocation completionHandler:^(NSArray *aPlacemarks, NSError *aError) {
        ISDebugLog(@"Found Placemarks: %@, Error: %@", aPlacemarks, aError);
        
        if (aError == nil && [aPlacemarks count] > 0) {
            CLPlacemark *sPlacemark = [aPlacemarks lastObject];
            
            NSString *sGeoStr = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@",
                                 sPlacemark.name, sPlacemark.thoroughfare, sPlacemark.subThoroughfare,
                                 sPlacemark.locality, sPlacemark.subLocality, sPlacemark.administrativeArea,
                                 sPlacemark.subAdministrativeArea, sPlacemark.postalCode, sPlacemark.ISOcountryCode,
                                 sPlacemark.country, sPlacemark.inlandWater, sPlacemark.ocean, [sPlacemark.areasOfInterest componentsJoinedByString:@" "]];
            
            [self showAlertWithTitle:@"My Location" message:[NSString stringWithFormat:@"%@, %@,\n\n%@", sLongitude, sLatitude, sGeoStr] actionHandler:nil];
        } else {
            ISDebugLog(@"reverseGeocodeLocation Error : %@", [aError localizedDescription]);
        }
    } ];
}

- (void)locationManager:(CLLocationManager*)aManager didChangeAuthorizationStatus:(CLAuthorizationStatus)aStatus
{
    switch (aStatus) {
        case kCLAuthorizationStatusNotDetermined:
            ISDebugLog(@"kCLAuthorizationStatusNotDetermined");
            [_locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusRestricted:
            ISDebugLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            ISDebugLog(@"kCLAuthorizationStatusDenied");
            [self showAlertWithTitle:@"Location Authorization Status Denied" message:@"Move to the setting menu for setting permission of locatioin servicee" actionHandler:^(UIAlertAction *aAction) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            }];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            ISDebugLog(@"kCLAuthorizationStatusAuthorized");
//            [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            ISDebugLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
//            [_locationManager startUpdatingLocation];
            break;
    }
}


@end
