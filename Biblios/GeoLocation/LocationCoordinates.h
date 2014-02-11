//
//  LocationCoordinates.h
//  Biblios
//
//  Wrapper class for latitude and longitude of a specific location.
//

#import <Foundation/Foundation.h>
@interface LocationCoordinates : NSObject
{
    double m_latitude;
    double m_longitude;
}
-(id) init;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end
