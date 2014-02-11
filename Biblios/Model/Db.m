//
//  Db.m
//  Biblios
//

#import "Db.h"
#import "XMLHandler.h"

static Db *_Db = nil;
static int _itemCounter;

// Librarie list
static NSMutableDictionary *_libraries;

// List of items borrowed from libraries.
static NSMutableDictionary *_librariesItems;

// List of listeners interested in any update ot the db.
static NSMutableDictionary *_dbListeners;

@implementation Db
+(Db *) sharedDB
{
    if(_Db == nil)
    {
        _Db = [[super allocWithZone:NULL] init];
        _itemCounter = 1;
        _libraries =  [[NSMutableDictionary alloc] init];
        _librariesItems = [[NSMutableDictionary alloc] init];
        _dbListeners = [[NSMutableDictionary alloc] init];
    }
    return _Db;
}

-(int) nextItemID
{
    return _itemCounter++;
}

-(void) addLibray:(Library *) library
{
    if(library != nil){
        NSLog(@"DB LIBRARY ADDED : ID => %@, NAME => %@", library.librayId.stringValue, library.name);
        [_libraries setObject:library forKey:library.librayId];
    }
}

-(Library *) getLibrary:(NSNumber*) libraryId
{
    return [_libraries objectForKey:libraryId];
}

-(NSDictionary *) getAllLibraries
{
    return  _libraries;
}

-(NSDictionary *) getAllLibrariesItems
{
    // sort them by date befo
    return  _librariesItems;
}

-(NSDictionary *) getAllItemsSortedByDate
{
    NSMutableDictionary * items = [[NSMutableDictionary alloc] init];
    
    return items;
}

-(NSArray *) getLibrariesNames
{
    NSMutableArray *names =  [[NSMutableArray alloc] init];
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] 
                                         initWithKey:@"librayId" ascending:YES] autorelease]; 
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *libraries = [[_libraries allValues] 
                            sortedArrayUsingDescriptors:sortDescriptors];
    for (Library *library in libraries) {
        [names addObject:library.name];
    }
    return names;
}

-(NSDictionary *) getAllItemsByLibrary
{
    NSMutableDictionary *allItems = [[NSMutableDictionary alloc] init];
    
    for (LibraryItem *item in _librariesItems) {
        
        // we use the library name as a key to retrieve the corresponding items.
        NSString *libraryName = [[_libraries objectForKey:[item libraryId]] name];
        NSMutableArray *libraryItems = [allItems objectForKey:libraryName];
        
        // If the item's library is not on the list, add it
        if(libraryItems == nil){
            libraryItems = [[NSMutableArray alloc] init];
            [allItems setValue:libraryItems forKey:libraryName];
        }
        
        // Add the item.
        [libraryItems addObject:item];
    }
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"returnDate"
                                                  ascending:YES] autorelease];
    
    // Sort every library's item list by ite return date.
    NSArray *keys = [allItems allKeys];
    for (NSString *key in keys) {
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [[allItems objectForKey:key] 
                                sortedArrayUsingDescriptors:sortDescriptors];
        [allItems setValue:sortedArray forKey:key];
    }
    return  allItems;
}

-(NSDictionary *) getLibrarieItems:(NSNumber *) libraryId
{
    return [_librariesItems objectForKey:libraryId];
}

-(void) addLibrayItem:(LibraryItem *) item;
{
    if(item != nil){
        [_librariesItems setObject:item forKey:item.itemID];
        [self notifyListeners];
    }
}

-(BOOL) removeLibraryItem:(NSNumber *) itemID
{
    if(itemID == nil || [_librariesItems objectForKey:itemID] == nil)
        return NO;
    [_librariesItems removeObjectForKey:itemID];
    [self notifyListeners];
    return YES;
}

-(void) setItemUpdated:(BOOL) itemUpdated
{
    m_itemsUpdated = itemUpdated;
}

-(BOOL) itemsUpdated
{
    return m_itemsUpdated;
}

#pragma mark - listene handling method

-(void) notifyListeners
{
    if(_dbListeners.count > 0){
        NSEnumerator *enumerator = [_dbListeners objectEnumerator];
        id<DbListener> listener;
        while ((listener = [enumerator nextObject])) {
            [listener notifyDbUpdated];
        }        
    }

}

-(void) addDbListener:(id<DbListener>) listener
{
    if(listener != nil){
        [_dbListeners setObject:listener forKey:[[listener class] description]];
    }
}

-(void) removeDbListener:(id<DbListener>) listener
{
    if(listener != nil){
        [_dbListeners removeObjectForKey:[[listener class] description]];
    }
}
#pragma mark -
#pragma mark base protocol methods implementation

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedDB] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

/*
 - (void)release
 {
 //do nothing
 }*/

- (id)autorelease
{
    return self;
}

@end
