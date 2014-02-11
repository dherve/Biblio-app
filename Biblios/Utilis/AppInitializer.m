//
//  AppInitializer.m
//  Biblios
//

#import "AppInitializer.h"
#import "Db.h"
#import "ApplicationConstants.h"
#import "XMLHandler.h"
#import "XML_TAGS.h"
#import "Notifications.h"
@implementation AppInitializer
+(void) loadAppData
{
    
     GDataXMLDocument *doc = (GDataXMLDocument *) [XMLHandler loadXMLFile:LIBRARIES_LIST_XML_FILE];
     GDataXMLElement *root = doc.rootElement;
     if(root != nil)
     {
         NSArray *libraries = [root elementsForName:LIBRARY];
         int counter = 0;
         
         // Any library ?
         if([libraries count] > 0)
         {
             // 
             for (GDataXMLElement *libray in libraries) 
             {
                 counter++;
                 NSNumber *libraryId =  [[NSNumber alloc] initWithInt:counter];
                 
                 Address *address =  [[Address alloc] init];
                 
                 NSString *name =  [XMLHandler elementValueAsString:libray forTag:NAME];
                 
                 NSArray  *adrElements = [XMLHandler elementChildren:libray forTag:ADRESS];
                 address.locationName = name;
                 address.streetNumber = [[adrElements objectAtIndex:0] stringValue];
                 address.streetName = [[adrElements objectAtIndex:1] stringValue];
                 address.zipCode = [[adrElements objectAtIndex:2] stringValue];
                 address.borough = [[adrElements objectAtIndex:3] stringValue];
                 address.city = [[adrElements objectAtIndex:4] stringValue];
                 address.province = [[adrElements objectAtIndex:5] stringValue];
                 address.country = [[adrElements objectAtIndex:6] stringValue];
                 address.streetType = [[[adrElements objectAtIndex:7] stringValue] intValue];
                 address.direction = [[[adrElements objectAtIndex:8] stringValue] intValue];
                 NSArray  *phones = [XMLHandler elementChildren:libray forTag:TELEPHONES];
                 NSString *generalPhone = [[phones objectAtIndex:0]stringValue];
                 NSString *youthPhone =  [[phones objectAtIndex:1]stringValue];
                 NSString *adultPhone =  [[phones objectAtIndex:2]stringValue];
                 
                 NSString *website = [XMLHandler elementValueAsString:libray forTag:WEBSITE];
                 
                 NSMutableArray *businessHours = [[NSMutableArray alloc] init];
                 NSArray *schedule = [XMLHandler elementChildren:libray forTag:LIBRARY_SCHEDULE];
                 for (GDataXMLElement *e in schedule) {
                 [businessHours addObject:[e stringValue]];
                 }
                 
                 Library *library = [[Library alloc] initWithValues:libraryId 
                                                        libraryName:name 
                                                            address:address
                                                       generalPhone:generalPhone 
                                                  youthSectionPhone:youthPhone 
                                                  adultSectionPhone:adultPhone 
                                                     libraryWebsite:website 
                                                      businessHours:businessHours];
                 [[Db sharedDB] addLibray:library];
             }
            
             [[NSNotificationCenter defaultCenter] postNotificationName:LIBRARY_LIST_LOADING_COMPLETED 
                                                                 object:nil]; 
             return;
         }
     }
    [[NSNotificationCenter defaultCenter] postNotificationName:LIBRARY_LIST_LOADING_FAILED 
                                                        object:nil]; 
}
@end
