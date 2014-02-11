//
//  Request.h
//  Biblios
//
//  Holds information about for request to be sent.
//

#import <Foundation/Foundation.h>

#define BASE_URL_LOCATION_REQUEST       @"http://maps.googleapis.com/maps/api/geocode/xml?address=%@&sensor=true&region=CA"
#define BASE_URL_REVERSE_GEOLOCATION    @"http://maps.googleapis.com/maps/api/geocode/xml?latlng=%@&sensor=true"

#define ADDRESS_PARAM                   @"ADDRESS"

// Request types.
typedef enum
{
    DIRECTIONS_REQUEST              = 0,
    LOCATION_REQUEST                = 1,
    ITEM_SEARCH_REQUEST             = 2,
    REVERSE_GEOCODING_REQUEST       = 3,
    LOCATION_ADDRESS_FROM_ZIPCODE   = 4
}REQUEST_TYPE;

@interface Request : NSObject
{
    REQUEST_TYPE        m_type;
    NSString            *m_url;
    NSMutableDictionary *m_parameters;
    BOOL                m_urlFormatted;
}

// Constructor with the type of the request.
-(id) initWithType:(REQUEST_TYPE) type;

/**
 * Set a parameter for the request.
 * @param : name    the name of the parameter to set.
 * @param : value   the value of the parameter to set.
 */
-(void) setParameter:(NSString *)name value:(NSString *)value;

/**
 * Get the value of a parameter as a string.
 * @param : name name of the parameter for which to get the value.
 * @return the parameter value.
 */
-(NSString *) getParameter:(NSString *) name;

/**
 * @return the request's url.
 */
-(NSString *) getURL;

/**
 * @return the request's type.
 */
-(REQUEST_TYPE ) getType;

/**
 * Get the string description of a specific request enum type.
 * @param : requestType the request type enum.
 * @return The description of the corresponding enum.
 */
+(NSString *) requestTypeDescription:(REQUEST_TYPE) requestType;

/**
 * Get the enum type from the description of a specific request enum type.
 * @param : requestDescription the enum description.
 * @return The enum of the corresponding description.
 */
+(REQUEST_TYPE) requestTypeFromDescription:(NSString *) requestDescription;
@end
