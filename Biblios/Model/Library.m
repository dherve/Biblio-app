//
//  Library.m
//  Biblios
//

#import "Library.h"

@implementation Library
@synthesize librayId = m_librayId;
@synthesize name = m_name;
@synthesize adrStreetNumber = m_adrStreetNumber;
@synthesize adrStreetName = m_adrStreetName;
@synthesize adrZipCode = m_adrZipCode;
@synthesize borough = m_borough;
@synthesize city = m_city;
@synthesize province = m_province;
@synthesize generalPhone = m_generalPhone;
@synthesize youthSectionPhone = m_youthSectionPhone;
@synthesize adultSectionPhone = m_adultSectionPhone;
@synthesize website = m_website;
@synthesize businessHours =  m_businessHours;
@synthesize address = m_address;

-(id)initWithValues:(NSNumber *) librayId libraryName:(NSString *) name 
            address:(Address *) address generalPhone:(NSString *) gPhone 
  youthSectionPhone:(NSString *) yPhone adultSectionPhone:(NSString *) aPhone 
     libraryWebsite:(NSString *) website 
      businessHours:(NSMutableArray *) businessHours
{
    self = [super init];
    if(self)
    {
        m_librayId = librayId;
        m_name = name;
        m_address = address;
        m_generalPhone = gPhone;
        m_youthSectionPhone = yPhone;
        m_adultSectionPhone = aPhone;
        m_website = website;
        m_businessHours = businessHours;
        
    }
    return self;    
}

-(id)initWithValues:(NSNumber *) librayId libraryName:(NSString *) name 
    adrStreetNumber:(NSString *) streetNumber adrStreetName:(NSString *) streetName 
         adrZipCode:(NSString *) zipCode adrBorough:(NSString *) borough 
            adrCity:(NSString *) city adrProvince:(NSString *) province 
       generalPhone:(NSString *) gPhone youthSectionPhone:(NSString *) yPhone 
  adultSectionPhone:(NSString *) aPhone libraryWebsite:(NSString *) website 
      businessHours:(NSMutableArray *) businessHours;
{
    self = [super init];
    if(self)
    {
        m_librayId = librayId;
        m_name = name;
        m_adrStreetNumber = streetNumber;
        m_adrStreetName = streetName;
        m_adrZipCode = zipCode;
        m_borough = borough;
        m_city = city;
        m_province = province;
        m_generalPhone = gPhone;
        m_youthSectionPhone = yPhone;
        m_adultSectionPhone = aPhone;
        m_website = website;
        m_businessHours = businessHours;
        
    }
    return self;
}

-(NSString *) description
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:@"["];
    [desc appendFormat:@"Llibrary Id : %@, ", m_librayId.stringValue];
    [desc appendFormat:@"Name : %@, ", m_name];
    [desc appendFormat:@"Address : %@, ", [m_address description] ];
    if(m_generalPhone != nil)
        [desc appendFormat:@"General phone: %@, ", m_generalPhone];
    if(m_youthSectionPhone != nil)
        [desc appendFormat:@"Youth section phone : %@, ", m_youthSectionPhone];
    
    if(m_adultSectionPhone != nil)
        [desc appendFormat:@"Adult section phone : %@, ", m_adultSectionPhone];
    
    [desc appendFormat:@"website : %@ ", m_website];
    
    [desc appendString:@"]"];
    return  desc;
}

-(void) dealloc
{
    [m_librayId release];
    [m_name release];
    [m_adrStreetNumber release];
    [m_adrStreetName release];
    [m_adrZipCode release];
    [m_borough release];
    [m_city release];
    [m_province release];
    [m_generalPhone release];
    [m_youthSectionPhone release];
    [m_adultSectionPhone release];
    [m_website release];
    [m_businessHours release]; 
    [m_address release];
    [super dealloc];
}
@end
