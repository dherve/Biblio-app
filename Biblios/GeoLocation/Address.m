//
//  Address.m
//  Biblios
//

#import "Address.h"

@implementation Address
@synthesize streetNumber = m_streetNumber;
@synthesize streetName = m_streetName;
@synthesize zipCode = m_zipCode;
@synthesize city = m_city;
@synthesize province = m_province;
@synthesize country = m_country;
@synthesize borough = m_borough;
@synthesize locationName = m_locationName;
@synthesize direction = m_direction;
@synthesize streetType = m_streetType;
-(void) dealloc
{
    [m_streetNumber release];
    [m_streetName release];
    [m_zipCode release];
    [m_city release];
    [m_province release];
    [m_country release];
    [m_borough release];
    [m_locationName release];
    [super dealloc];
}

-(NSString *) description
{
    NSMutableString *desc = [[NSMutableString alloc] init];    
    [desc appendString:m_streetNumber];
    [desc appendFormat:@" %@,", m_streetName];
    [desc appendFormat:@" %@,", m_city];
    [desc appendFormat:@" %@", m_province];
    [desc appendFormat:@" %@,", m_zipCode];
    [desc appendFormat:@" %@", m_country];
    return  desc;    
}

+(NSString *) streetDescriptionFromType:(STREET_TYPE) type
{
    switch (type) {
        case STREET:    return NSLocalizedString(@"Street", nil);
        case BOULEVARD: return NSLocalizedString(@"Blvd", nil);
        case AVENUE:    return NSLocalizedString(@"Avenue", nil);
        case WAY:       return NSLocalizedString(@"Way", nil);
            
        case TYPE_UNDEFINED:
        default: return nil;
            break;
    }
}

+(NSString *) streetDirectionDescription:(STREET_DIRECTION) direction
{
    switch (direction) {
        case EAST : return NSLocalizedString(@"east", nil);
        case WEST : return NSLocalizedString(@"west", nil);
        case DIR_UNDEFINED:
        default: return  nil;
    }
}
@end
