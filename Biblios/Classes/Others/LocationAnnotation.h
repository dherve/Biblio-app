//
//  LocationAnnotation.h
//  Biblios
//
//  Holds the coordinates of a location to be shown as an annotation
//  on a mapview.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationCoordinates.h"
@interface LocationAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *m_title;
    NSString *m_subTitle;
}

// Constructor with the annotation title, subtitle and coordinates.
-(id) initWithTitle:(NSString *)title subTitle:(NSString *) subTitle 
        coordinates:(LocationCoordinates *) coordinates;

// Constructor with the coordinates.
-(id) initWithCoordinates:(LocationCoordinates *) coordinates;

@end
