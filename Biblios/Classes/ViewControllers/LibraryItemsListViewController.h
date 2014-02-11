//
//  LibraryItemsListViewController.h
//  Biblios
//
//  Shows the items borrowed by a user from a specif library.
//

#import <UIKit/UIKit.h>
#import "SectionedListViewController.h"
#import "DbListener.h"
@interface LibraryItemsListViewController : SectionedListViewController<DbListener>

@end
