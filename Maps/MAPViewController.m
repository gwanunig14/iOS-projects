//
//  MAPViewController.m
//  Maps
//
//  Created by T.J. Mercer on 5/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "MAPViewController.h"
#import "MAPAnnotation.h"

@interface MAPViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

@end

@implementation MAPViewController
{
    CLLocationManager * lManager;
    MKMapView * myMapView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        
        lManager.distanceFilter = 10;
        
        [lManager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [myMapView removeAnnotations:myMapView.annotations];
    for (CLLocation * location in locations)
    {
        MAPAnnotation * annotation = [[MAPAnnotation alloc]initWithCoordinate:location.coordinate];
        
        [myMapView addAnnotation:annotation];
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.5, 0.5));
        
        [myMapView setRegion:region animated:YES];
        
//        [mapView selectAnnotation:annotation animated:YES];
        NSLog(@"%@",location);
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                NSLog( @"%@",placemark.addressDictionary);
                
                NSString * cityState = [NSString stringWithFormat:@"%@, %@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                
                [annotation setTitle:cityState];
                [annotation setSubtitle:placemark.country];
            }
        }];
    }
    
//    [lManager stopUpdatingLocation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSLog(@"WORKING");
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    } else {
        annotationView.annotation = annotation;
    };
    
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;

    return annotationView;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.view];
    
    CLLocationCoordinate2D coordinate = [myMapView convertPoint:location toCoordinateFromView:myMapView];
    
    MAPAnnotation * annotation = [[MAPAnnotation alloc]initWithCoordinate:coordinate];
    
    [myMapView addAnnotation:annotation];
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"new state: %d and old state %d",(int)newState,(int)oldState);
    switch ((int)newState) {
        case 0:
        {
            [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
            
            CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
            
            CLLocation * location = [[CLLocation alloc]initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
            
            [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                for (CLPlacemark * placemark in placemarks) {
                    NSLog( @"%@",placemark.addressDictionary);
                    
                    NSString * cityState = [NSString stringWithFormat:@"%@, %@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                    
                    [(MAPAnnotation *)view.annotation setTitle:cityState];
                    [(MAPAnnotation *)view.annotation setSubtitle:placemark.country];
                }
            }];
        }
            
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        case 4:
            
            break;
            
        default:
            break;
    }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   myMapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
}

@end
