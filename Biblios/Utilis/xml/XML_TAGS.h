//
//  XML_TAGS.h
//  Biblios
//
//  The class encpsulates names of tags used in external xml resources files.
//  Theses names are used for reading and parsing the xml files.
//

#import <Foundation/Foundation.h>

@interface XML_TAGS : NSObject
    
    // Library xml tags
    extern NSString * const LIBRARIES;
    extern NSString * const LIBRARY;
    extern NSString * const NAME;
    extern NSString * const ADRESS;
    extern NSString * const ADRESS_STREET_NO;
    extern NSString * const ADRESS_STREET_NAME;
    extern NSString * const ADRESS_STREET_TYPE;
    extern NSString * const ADRESS_STREET_DIRECTION;
    extern NSString * const ADRESS_ZIP_CODE;
    extern NSString * const ADRESS_BOROUGH;
    extern NSString * const ADRESS_CITY;
    extern NSString * const ADRESS_PROVINCE;
    extern NSString * const ADRESS_COUNTRY;
    extern NSString * const TELEPHONES;
    extern NSString * const GENERAL_TELEPHONE;
    extern NSString * const YOUTH_SECTION_TELEPHONE;
    extern NSString * const ADULT_SECTION_TELEPHONE;
    extern NSString * const WEBSITE;

    extern NSString * const LIBRARY_SCHEDULE;
    extern NSString * const SCHEDULE_TIMESLOT;

    // Location and directions tags
    extern NSString * const LATITUDE;
    extern NSString * const LONGITUDE;
    extern NSString * const STATUS;
    extern NSString * const CODE;
    extern NSString * const RESPONSE;
    extern NSString * const PLACEMARK;
    extern NSString * const POINT;
    extern NSString * const COORDINATES;
    extern NSString * const STEP_HTML_INSTRUCTIONS;
    extern NSString * const END_LOCATION;
    extern NSString * const ADDR_COMP_SHORT_NAME;
    extern NSString * const ADDR_COMP_LONG_NAME;
    extern NSString * const ADDR_COMP_TYPE;
    extern NSString * const PT_ADDR_DESCRIPTION;


    // Application text tags
    extern NSString * const ABOUT_TEXT;


@end
