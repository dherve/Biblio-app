//
//  MapViewController.h
//  Biblios
//
//  Loads the mapview to show the location of a library
//

#import <UIKit/UIKit.h>
#import "Library.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface MapViewController : UIViewController<MKMapViewDelegate>
{
    Address                 *m_address;
    NSString                *m_locationName;
    MKMapView               *m_mapView;
    UILabel                 *m_searchingLabel;
    UIActivityIndicatorView *m_activityIndicator;
}

// Constructor with the library address and name to be shown on the map
// as parameters.
-(id) initWithLocation:(Address *) address locationName:(NSString *) name;

@end
