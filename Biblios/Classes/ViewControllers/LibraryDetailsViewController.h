//
//  LibraryDetailsViewController.h
//  Biblios
//
//  Shows detailed informations about a specific library.
//

#import <UIKit/UIKit.h>
#import "SectionedListViewController.h"
#import "Library.h"
#import "DirectionsHandler.h"
#define SECTION_FULL_ADDRESS    @"Full address"
#define SECTION_BUSINESS_HOURS  @"Business hours"
@interface LibraryDetailsViewController : SectionedListViewController
{
    Library *m_library; 
    DirectionsHandler *m_directionsHandler;
}

// Constructor with a library for which the information are to be displayed.
-(id) initWithLibrary:(Library *) library;
@end
