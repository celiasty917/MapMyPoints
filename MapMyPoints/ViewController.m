//
//  ViewController.m
//  MapMyPoints
//
//  Created by Song, Tianyi | RASIA on 9/4/20.
//  Copyright © 2020 Song, Tianyi | RASIA. All rights reserved.
//

#import "ViewController.h"
#import "MapKit/Mapkit.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *luciAnno;
@property (strong, nonatomic) MKPointAnnotation *wiclAnno;
@property (strong, nonatomic) MKPointAnnotation *gradientAnno;
@property (strong, nonatomic) MKPointAnnotation *currentAnno;


@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    [self addAnnotations];
    
}

- (IBAction)switchChanged:(id)sender {
    
    if (self.switchField.isOn){
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    
    if (self.mapIsMoving == NO) {
        [self centerMap:self.currentAnno];
    }
}

- (IBAction)luciTapped:(id)sender {
    [self centerMap:self.luciAnno];
}

- (IBAction)wiclTapped:(id)sender {
     [self centerMap:self.wiclAnno];
}

- (IBAction)gradientTapped:(id)sender {
     [self centerMap:self.gradientAnno];
}

- (void) centerMap: (MKPointAnnotation *)centerPoint{
    
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
    
}

- (void) addAnnotations{
    
    self.luciAnno = [[MKPointAnnotation alloc] init];
    self.luciAnno.coordinate = CLLocationCoordinate2DMake(1.2830, 103.8579);
    self.luciAnno.title = @"Marina Bay Sands, Singapore";
    
    self.wiclAnno = [[MKPointAnnotation alloc] init];
    self.wiclAnno.coordinate = CLLocationCoordinate2DMake(30.529100, 114.082199);
    self.wiclAnno.title = @"Huoshenshan Hospital, Wuhan, Hubei, China";
    
    self.gradientAnno = [[MKPointAnnotation alloc] init];
    self.gradientAnno.coordinate = CLLocationCoordinate2DMake(42.3601, -71.0942);
    self.gradientAnno.title = @"Massachusetts Institute of Technology(MIT), U.S.";
    
    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnno.title = @"My Location";
    
    [self.mapView addAnnotations:@[self.luciAnno, self.wiclAnno, self.gradientAnno]];
    
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.mapIsMoving = NO;
}

@end
