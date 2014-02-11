//
//  Db.h
//  Biblios
//
//  local database to store library items. 
//  #TODO : investigate existing db mechanismes that can be used instead.
//

#import <Foundation/Foundation.h>
#import "Library.h"
#import "LibraryItem.h"
#import "DbListener.h"
@interface Db : NSObject
{
    // Flag to keep track of updated on the items.
    BOOL m_itemsUpdated;
}
+(Db *) sharedDB;

/**
 * Get a library based on it's id.
 * @param : libraryId id of the library.
 */
-(Library *) getLibrary:(NSNumber*) libraryId;

/**
 * @return : a dictionary containing all libraries.
 */
-(NSDictionary *) getAllLibraries;

/**
 * @return : a dictionary of all librairies items
 */
-(NSDictionary *) getAllLibrariesItems;

/**
 * @return : dictionary of all libraries items, groupe by library
 */
-(NSDictionary *) getAllItemsByLibrary;

/**
 * Get the items of specific library  
 * @param  : libraryId id of the library that has the items.
 * @return : A dictionary of items.
 */
-(NSDictionary *) getLibrarieItems:(NSNumber *) libraryId;

/**
 * @return : An array of all libraries names.
 */
-(NSArray *) getLibrariesNames;

/**
 * Add a new library.
 * @param : library the library to add.
 */
-(void) addLibray:(Library *) library;

/**
 * Add a new item library.
 * @param : item the item to add.
 */
-(void) addLibrayItem:(LibraryItem *) item;

/**
 * @return : the id of an item ot be added.
 */
-(int) nextItemID;

/**
 * Set the flag indicating that one or more items in the library items has been
 * added or removed.
 * @param : itemUpdated Flad indicating the item update status
 */
-(void) setItemUpdated:(BOOL) itemUpdated;

/**
 * @return YES if there were any update in the items, NO otherwise.
 */
-(BOOL) itemsUpdated;

/**
 * Remove a library item.
 * @param : itemID id of the item to be removed.
 * @return : true if the item has been successfully removed, false otherwise.
 */
-(BOOL) removeLibraryItem:(NSNumber *) itemID;

/**
 * Notify all registered listeners whenever there is any update to the data.
 */
-(void) notifyListeners;

/**
 * Add a new listener for updates to the db.
 * @param : listener the listener object ot add.
 */
-(void) addDbListener:(id<DbListener>) listener;

/**
 * Remove a listener for updates to the db.
 * @param : listener the listener to remove.
 */
-(void) removeDbListener:(id<DbListener>) listener;

@end
