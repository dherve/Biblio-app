//
//  Address.h
//  Biblios
//
//  Holds address information.
//

#import <Foundation/Foundation.h>

// Street types.
typedef enum{
    TYPE_UNDEFINED  = 0,
    STREET          = 1,
    BOULEVARD       = 2,
    AVENUE          = 3,
    WAY             = 4
}STREET_TYPE;

// Street directions.
typedef enum{
    DIR_UNDEFINED   = 0,
    EAST            = 1,
    WEST            = 2
}STREET_DIRECTION;

@interface Address : NSObject
{
    NSString    *m_locationName;
    NSString    *m_streetNumber;
    NSString    *m_streetName;
    NSString    *m_zipCode;
    NSString    *m_city;
    NSString    *m_province;
    NSString    *m_country;
    NSString    *m_borough;
    NSInteger   m_direction;
    NSInteger   m_streetType;
}

@property(nonatomic,retain) NSString *locationName;
@property(nonatomic,retain) NSString *streetNumber;
@property(nonatomic,retain) NSString *streetName;
@property(nonatomic,retain) NSString *zipCode;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *province;
@property(nonatomic,retain) NSString *country;
@property(nonatomic,retain) NSString *borough;
@property(nonatomic) NSInteger direction;
@property(nonatomic) NSInteger streetType;

/**
 * Get the description of a street type enum.
 * @param : type the enum from which to get the description.
 * @return An nsstring object corresponding to the specific enum type.
 */
+(NSString *) streetDescriptionFromType:(STREET_TYPE) type;

/**
 * Get the description of a street direction enum.
 * @param : type the enum from which to get the description.
 * @return An nsstring object corresponding to the specific enum type.
 */
+(NSString *) streetDirectionDescription:(STREET_DIRECTION) direction;
@end
