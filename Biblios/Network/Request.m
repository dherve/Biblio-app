//
//  Request.m
//  Biblios
//

#import "Request.h"
@interface Request(PrivateApi)
    -(void) formatURL;
@end

@implementation Request

-(id) initWithType:(REQUEST_TYPE) type
{
    self = [super init];
    if(self)
    {
        m_type = type;
        switch (type) {
            case LOCATION_REQUEST:
            {
                m_url = [[NSString alloc] initWithString:BASE_URL_LOCATION_REQUEST];
            }
            break;
                
            // Not handled in this version.
            case REVERSE_GEOCODING_REQUEST:            
            case DIRECTIONS_REQUEST:
            case ITEM_SEARCH_REQUEST:                
            case LOCATION_ADDRESS_FROM_ZIPCODE:                
            default: break;
        }
        m_parameters = [[NSMutableDictionary alloc] init];
        m_urlFormatted = NO;
    }
    return self;
}


-(REQUEST_TYPE ) getType
{
    return m_type;
}

-(NSString *) getURL
{
    if(m_urlFormatted == NO){
        [self formatURL];
    }
    return m_url;
}

-(void) setParameter:(NSString *)name value:(NSString *)value
{
    [m_parameters setObject:value forKey:name];
}
-(NSString *) getParameter:(NSString *) name
{
    if(m_parameters != nil && name != nil)
    {
        return  [m_parameters objectForKey:name];
    }
    return @"";
}

-(void) dealloc
{
    [m_url release];
    [m_parameters release];
    //[super dealloc];
}

#pragma mark - private methods
-(void) formatURL
{
    switch (m_type) 
    {

            
        case LOCATION_REQUEST:
        {
            NSString *address = [m_parameters objectForKey :ADDRESS_PARAM];
            m_url = [NSString stringWithFormat:m_url, address];
        }
        break;
            
        // Not handled in this version.
        case REVERSE_GEOCODING_REQUEST:
        case DIRECTIONS_REQUEST:
        case ITEM_SEARCH_REQUEST:
        case LOCATION_ADDRESS_FROM_ZIPCODE:
        default: break;
    } 
    m_urlFormatted = YES;
}

#pragma mark - class helper methods
+(NSString *) requestTypeDescription:(REQUEST_TYPE) requestType
{
    switch (requestType) {
        case DIRECTIONS_REQUEST: return @"DIRECTIONS_REQUEST";
        case LOCATION_REQUEST : return @"LOCATION_REQUEST";
        case ITEM_SEARCH_REQUEST : return @"ITEM_SEARCH_REQUEST";
        case REVERSE_GEOCODING_REQUEST : return @"REVERSE_GEOCODING_REQUEST";
        case LOCATION_ADDRESS_FROM_ZIPCODE : return @"LOCATION_ADDRESS_FROM_ZIPCODE";
    }
    
    // default throw exception  : unkown type
}

+(REQUEST_TYPE) requestTypeFromDescription:(NSString *) requestDescription
{
    if([requestDescription isEqualToString:@"DIRECTIONS_REQUEST"])
        return DIRECTIONS_REQUEST;
    if([requestDescription isEqualToString:@"LOCATION_REQUEST"])
        return LOCATION_REQUEST;
    if([requestDescription isEqualToString:@"ITEM_SEARCH_REQUEST"])
        return ITEM_SEARCH_REQUEST;
    if([requestDescription isEqualToString:@"REVERSE_GEOCODING_REQUEST"])
        return REVERSE_GEOCODING_REQUEST;
    if([requestDescription isEqualToString:@"LOCATION_ADDRESS_FROM_ZIPCODE"])
        return LOCATION_ADDRESS_FROM_ZIPCODE;
    // else throws exception : type not found
}
@end
