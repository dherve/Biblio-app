//
//  LocationAnnotation.m
//  Biblios
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation
@synthesize coordinate;

-(id) initWithTitle:(NSString *)title subTitle:(NSString *) subTitle 
        coordinates:(LocationCoordinates *) coordinates
{
    self = [super init];
    if(self){
        m_title = title;
        m_subTitle = subTitle;
        coordinate.latitude = coordinates.latitude;
        coordinate.longitude = coordinates.longitude;
    }
    return self;
}
-(id) initWithCoordinates:(LocationCoordinates *) coordinates
{
    coordinate.latitude = coordinates.latitude;
    coordinate.longitude = coordinates.longitude;
    return  self;
}
- (NSString *)subtitle{
    return m_subTitle;
}

- (NSString *)title{
    return m_title;
}

-(void) dealloc{
    [m_title release];
    [m_subTitle release];
}
@end
