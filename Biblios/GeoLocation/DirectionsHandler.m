//
//  LocationHandlerWithGMaps.m
//  Biblios
//

#import "DirectionsHandler.h"
#import "Utilis.h"
#import "ErrorDialogHandler.h"

@implementation DirectionsHandler
-(id) initWithDestination:(Address *) destination
{
    self =  self = [super init];
    if(self){
        m_destination =  [destination description];
        m_userCoordinates = [[LocationCoordinates alloc ]init];
        m_userLocations = [[NSMutableArray alloc] init];
        if([CLLocationManager locationServicesEnabled] == YES)
        {

            m_locationManager = [[CLLocationManager alloc] init];
            m_locationManager.delegate = self;
            [m_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        }
    
    }
    return self;
}
-(void) startMonitoringUserLocation;
{
    [m_locationManager startUpdatingLocation];
}
-(void) stopMonitoringUserLocation
{
    [m_locationManager stopUpdatingLocation];
}

-(void) dealloc
{
    [m_destination release];
    [m_locationManager release];
    [m_userLocations release];
    [m_userCoordinates release];
}

-(void) showDirections;
{
    [self stopMonitoringUserLocation];
    [m_userLocations removeAllObjects];
    CLLocationCoordinate2D coords = [[m_userLocations lastObject] coordinate];
    
    // Format the origin and the destination
    NSString *origin = [NSString stringWithFormat:@"%f,%f", coords.latitude, coords.longitude];
    NSString *destination = [m_destination stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    // Format the url.
    m_urlDirections = [NSString stringWithFormat:GOOGLE_MAPS_URL, origin,destination];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:m_urlDirections]];
}


#pragma mark - location delegate methods
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    
    if([m_userLocations count] < MAX_USER_LOCATIONS_ALLOWABLE)
    {
        [m_userLocations addObject:newLocation];
    }
    else
    {
        // remove the oldest element since the queue is full.
        [m_userLocations removeObjectAtIndex:0];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [m_userLocations removeAllObjects];
    
    NSString *message = [Utilis getErrorDescription:error];
    [ErrorDialogHandler showDialogForErrorMessage:message];
}


@end
