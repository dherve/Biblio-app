//
//  DirectionsHandler.m
//  Biblios
//

#import "RequestHandler.h"
#import "LocationHandler.h"
#import "Notifications.h"
#import "XMLHandler.h"
#import "XML_TAGS.h"
#import "Request.h"
#import "Utilis.h"
#import "ErrorDialogHandler.h"


@interface LocationHandler(PrivateAPI)
    /**
     * Handle a notification from a successfull request response.
     * @param : notification the notification to handle.
     */
    +(void) handleRequestSuccessNotification:(NSNotification*)notification;

    /**
     * Handle a notification from a unsuccessfull request response.
     * @param : notification the notification to handle.
     */
    +(void) handleRequestFailureNotification:(NSNotification*)notification;

    /**
     * Parse the xml location data received.
     * @param : data location data.
     * @return the coordinates (latitude,longitude) retrieve from the xml data.
     */
    +(LocationCoordinates *) parseLocationData:(NSString *) data;

@end

static LocationHandler          *_instance = nil;
static NSMutableDictionary      *_cachedAddresses = nil;
static LocationCoordinates      *_coordinates;
static NSMutableArray       *_userLocations;
static CLLocationManager    *_locationManager;
 
@implementation LocationHandler
+(LocationHandler *) instance
{
    if(_instance == nil)
    {
        _instance = [[super allocWithZone:NULL] init];
        _cachedAddresses = [[NSMutableDictionary alloc] init];
        _coordinates = [[LocationCoordinates alloc] init];
        _userLocations = [[NSMutableArray alloc]init];
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // Register for successfull request notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleRequestSuccessNotification:) 
                                                     name:REQUEST_COMPLETED_NOTIFICATION 
                                                   object:nil];
        
        // Register for unsuccessfull request notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleRequestFailureNotification:) 
                                                     name:REQUEST_FAILED_NOTIFICATION 
                                                   object:nil];
    }
    return _instance;
}

-(void)requestCoordinatesForAddress:(Address *) address
{
    _coordinates = [_cachedAddresses objectForKey:[address description]];
    if( _coordinates != nil)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DATA_AVAILABLE_NOTIFICATION 
                                                            object:self];
        
    }
    else
    {
        Request *request = [[Request alloc] initWithType:LOCATION_REQUEST];
        NSString *locationAddress = [[address description] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
                
        [request setParameter:ADDRESS_PARAM value:locationAddress];
        [RequestHandler sendRequest:request];        
    }    
}



-(LocationCoordinates *) getCoordinates
{
    
    return _coordinates;
}


#pragma mark - methods to handle the request 
+(void) handleRequestSuccessNotification:(NSNotification*)notification;
{

    NSDictionary *userInfos = [notification userInfo];
    REQUEST_TYPE requestType = [Request requestTypeFromDescription:
                                [userInfos objectForKey:NOTIFICATION_KEY_REQUEST_TYPE]];
    NSString *url = [userInfos objectForKey:NOTIFICATION_KEY_REQUEST_URL];
    NSString *data = [Utilis stringFromData:[RequestHandler getDataForRequest:url]];
    

    switch (requestType) 
    {
        case LOCATION_REQUEST:
        {
            _coordinates = [self parseLocationData:data];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DATA_AVAILABLE_NOTIFICATION 
                                                                object:self];
            // Add the coord to the address here
            //_cachedAddresses setObject:_coordinates forKey:<#(id)#>
        }
            break;
            
        // Not handled in this version.
        case REVERSE_GEOCODING_REQUEST:
        case DIRECTIONS_REQUEST: 
        case LOCATION_ADDRESS_FROM_ZIPCODE:
        default:break;
    }
}

+(void) handleRequestFailureNotification:(NSNotification*)notification;
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATION_DATA_UNAVAILABLE_NOTIFICATION 
                                                        object:self];
}



+(LocationCoordinates *) parseLocationData:(NSString *) data
{
    GDataXMLDocument *document = [XMLHandler loadXMLFileFromString:data];
    LocationCoordinates *coordinates = [[LocationCoordinates alloc] init];
    if(document != nil)
    {
        GDataXMLElement *root = document.rootElement;
        NSString *status = [XMLHandler elementValueAsString:root forTag:STATUS];
        if(status != nil && [status isEqualToString:@"OK"])
        {
            // Get the location coordinates from the xml
            NSString *xpath = @"//GeocodeResponse/result/geometry/location";
            XmlResultSet *result = [XMLHandler executeXpathQuery:document 
                                                       withQuery:xpath];
            if([result.resultArray count] > 0)
            {
                
                GDataXMLElement *element = (GDataXMLElement *) [result.resultArray objectAtIndex:0];                
                coordinates.latitude = [[XMLHandler elementValueAsNumber:element 
                                                                  forTag:LATITUDE] doubleValue];
                coordinates.longitude = [[XMLHandler elementValueAsNumber:element 
                                                                   forTag:LONGITUDE] doubleValue];
                
                // here the key = the adress
                // Whenever we receive the coordinates we need to cache them
                // for later use -> same request or for directions
                //[_cachedAddresses setObject:coords forKey:nil];
                
            }
        }
    }
    return coordinates;
    
}


-(void) requestUserLocation
{
    if([CLLocationManager locationServicesEnabled] == YES)
    {
        _locationManager.delegate = _instance;
        [_locationManager startUpdatingLocation];
    }
}

-(CLLocation*) getUserLocation
{
    
    return [_userLocations lastObject];    
}



#pragma mark - location delegate methods
- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation 
           fromLocation:(CLLocation *)oldLocation
{
    
    if([_userLocations count] < MAX_USER_LOCATIONS_ALLOWABLE)
    {
        [_userLocations addObject:newLocation];
    }
    else
    {
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        if(newLocation.coordinate.longitude == oldLocation.coordinate.longitude && 
           newLocation.coordinate.latitude  == oldLocation.coordinate.latitude){
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOCATION_AVAILABLE_NOTIFICATION 
                                                                object:nil];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@ -> locationManager:didFailWithError: %@", [[self class] description],
          [Utilis getErrorDescription:error]);
}

-(NSString *) userCoordinatesAsString
{
    NSString *coordinates;
    CLLocation *location = [_userLocations lastObject];
    coordinates = [NSString stringWithFormat:@"%f,%f",  location.coordinate.latitude,
                   location.coordinate.longitude];
    
    return  coordinates;
}

#pragma mark - base protocol methods implementation

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self instance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

/*
 - (void)release
 {
 //do nothing
 }*/

- (id)autorelease
{
    return self;
}
@end
