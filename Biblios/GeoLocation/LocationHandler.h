//
//  DirectionsHandler.h
//  Biblios
//
//  Keep track of the user location and allows to get informations about that 
//  location.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Address.h"
#import "LocationCoordinates.h"

#define MAX_USER_LOCATIONS_ALLOWABLE    3
#define GOOGLE_MAPS_URL                 @"http://maps.google.com/?saddr=%@&daddr=%@"

@interface LocationHandler : NSObject<CLLocationManagerDelegate>
+(LocationHandler *) instance;

/**
 * Request geographic coordinates of an address.
 * @param address   the address to get coordinates for.
 */
-(void) requestCoordinatesForAddress:(Address *) address;

/**
 * @return An object containing the coordinates previousely requested for 
 *         a specific destination.
 */
-(LocationCoordinates *) getCoordinates;

/**
 * Request geographic coordinates for the user current location.
 */
-(void) requestUserLocation;

/**
 * @return the user current location.
 */
-(CLLocation *) getuserLocation;

/**
 * @return the coordinates of the user current location as a string.
 */
-(NSString *) userCoordinatesAsString;

@end
