//
//  LocationHandlerWithGMaps.h
//  Biblios
//
//  Loads Google maps to show directions instructions to go to a specific library.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Address.h"
#import "LocationCoordinates.h"

#define GOOGLE_MAPS_URL                 @"http://maps.google.com/?saddr=%@&daddr=%@"
#define MAX_USER_LOCATIONS_ALLOWABLE    5

@interface DirectionsHandler : NSObject<CLLocationManagerDelegate>
{
    NSString                *m_destination; 
    CLLocationManager       *m_locationManager;
    LocationCoordinates     *m_userCoordinates;
    NSString                *m_urlDirections;
    NSMutableArray          *m_userLocations;
    
}

// Constructor with the destination address for which the directions may be requested.
-(id) initWithDestination:(Address *) destination;

// Start retrieving the coordinates of the user current location.
-(void) startMonitoringUserLocation;

// Strop retrieving the coordinates of the user current location.
-(void) stopMonitoringUserLocation;

// Launch Google maps in order to show the directions from the current location
// to the library destination specified when the class instance was initialized.
-(void) showDirections;
@end
