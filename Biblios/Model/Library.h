//
//  Library.h
//  Biblios
//

#import <Foundation/Foundation.h>
#import "Address.h"
// Object model holding a librarires informations.

@interface Library : NSObject
{
    NSNumber        *m_librayId;
    NSString        *m_name;
    NSString        *m_adrStreetNumber;
    NSString        *m_adrStreetName;
    NSString        *m_adrZipCode;
    NSString        *m_borough;
    NSString        *m_city;
    NSString        *m_province;
    NSString        *m_generalPhone;
    NSString        *m_youthSectionPhone;
    NSString        *m_adultSectionPhone;
    NSString        *m_website;
    NSMutableArray  *m_businessHours;
    Address         *m_address;
}
@property (nonatomic, retain) NSNumber *librayId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *adrStreetNumber;
@property (nonatomic, retain) NSString *adrStreetName;
@property (nonatomic, retain) NSString *adrZipCode;
@property (nonatomic, retain) NSString *borough;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *generalPhone;
@property (nonatomic, retain) NSString *youthSectionPhone;
@property (nonatomic, retain) NSString *adultSectionPhone;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSMutableArray  *businessHours;
@property (nonatomic, retain) Address  *address;

-(id)initWithValues:(NSNumber *) librayId libraryName:(NSString *) name 
            address:(Address *) address generalPhone:(NSString *) gPhone 
  youthSectionPhone:(NSString *) yPhone adultSectionPhone:(NSString *) aPhone 
     libraryWebsite:(NSString *) website 
      businessHours:(NSMutableArray *) businessHours;

-(id)initWithValues:(NSNumber *) librayId libraryName:(NSString *) name 
    adrStreetNumber:(NSString *) streetNumber adrStreetName:(NSString *) streetName 
         adrZipCode:(NSString *) zipCode adrBorough:(NSString *) borough 
            adrCity:(NSString *) city adrProvince:(NSString *) province 
       generalPhone:(NSString *) gPhone youthSectionPhone:(NSString *) yPhone 
  adultSectionPhone:(NSString *) aPhone libraryWebsite:(NSString *) website 
      businessHours:(NSMutableArray *) businessHours;
@end
