//
//  LocationCoordinates.m
//  Biblios
//

#import "LocationCoordinates.h"

@implementation LocationCoordinates
-(id) init
{
    self = [super init];
    if(self){
        m_latitude = 0;
        m_longitude = 0;
    }
    return  self;
}
@synthesize latitude = m_latitude;
@synthesize longitude = m_longitude;
@end
