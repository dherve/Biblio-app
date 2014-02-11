//
//  LibraryItem.h
//  Biblios
//
//  A library item is an item form the library borrowed by the user.
//  This class hold informations about that item.
//

#import <Foundation/Foundation.h>

// Different languages in which an item can edited in.
typedef enum
{
    FRENCH      = 0,
    ENGLISH     = 1,
    ARABIC      = 2,
    BENGALI     = 3,
    CHINESE     = 4,
    CREOLE      = 5,
    DUTCH       = 6,
    GERMAN      = 7,
    GREEK       = 8,
    GUJARATI    = 9,
    HINDI       = 10,
    ITALIAN     = 11,
    PANDJABI    = 12,
    PORTUGUESE  = 13,
    RUSSIAN     = 14,
    SPANISH     = 15,
    TAGALOG     = 16,
    TAMIL       = 17,
    URDOUD      = 18,
    VIETNAMIESE = 19
}ITEM_LANGUAGE;

// Different categories that an item can belong to.
// Can be used when searching for a specific item.
typedef enum 
{
    AUDIO_BOOK              = 0,
    AUDIO_CASSETTE          = 1,
    BOOK                    = 2,
    BRAILLE_BOOK            = 3,
    BOARD_BOOK              = 4,
    CARTOGRAPHIC_MATERIAL   = 5,
    CD_ROM                  = 6,
    COMPACT_DISC            = 7,
    DVDS                    = 8,
    DVD_BLU_RAY             = 9,
    DVD_ROMS                = 10,
    E_BOOK                  = 11,
    GAMES_TOYS              = 12,
    GOVERNMENT_DOCUMENTS    = 13,
    INTERNET_RESSOURCES     = 14,
    KITS                    = 15,
    LANGUAGE_COURSES        = 16,
    LARGE_PRINT_BOOKS       = 17,
    MICROFORMS              = 18,
    MUSICAL_SCORES          = 19,
    POSTER                  = 20,
    SERIALS                 = 21,
    VERTICAL_FILES          = 22,
    VIDEOCASSETTES          = 23,
    VIDEO_GAME              = 24,
    ALL                     = 25
}ITEM_CATEGORY;

// Item types
typedef enum 
{
    PRINTED_BOOK = 0,
    NUMERIC_BOOK = 1,
    MUSIC_CD     = 2,
    FILM_DVD     = 3,
    NEWSPAPER    = 4,
    MAGAZINE     = 5,
    JOURNAL      = 6,
    DVD          = 7,
    AUDIO_TAPE   = 8
}ITEM_TYPE;

// Different times t
typedef enum
{ 
    ONE_WEEK_BEFORE    = 0,
    TREE_DAYS_BEFORE   = 1,
    ONE_DAY_BEFORE     = 2,
    ONE_HOUR_BEFORE    = 3,
    THIRTY_MIN_BEFORE  = 4,
    FIFTEEN_MIN_BEFORE = 5,
    ON_TIME            = 6,
    NO_REMINDER        = 7    
}RETURN_DATE_REMINDER;

// Item possible status
typedef enum
{
    ON_HOLD     = 0,
    AVAILABLE   = 1,
    LATE        = 3
}ITEM_STATUS;

@interface LibraryItem : NSObject
{
    ITEM_TYPE               m_type;
    RETURN_DATE_REMINDER    m_reminderTime;
    ITEM_STATUS             m_status;
    NSString                *m_title;
    NSDate                  *m_returnDate;
    NSNumber                *m_libraryID;
    NSNumber                *m_itemID;
}

@property (nonatomic) ITEM_TYPE             type;
@property (nonatomic) RETURN_DATE_REMINDER  reminderTime;
@property (nonatomic) ITEM_STATUS           status;
@property (nonatomic, retain) NSString      *title;
@property (nonatomic, retain) NSNumber      *itemID;
@property (nonatomic, retain) NSNumber      *libraryId;
@property (nonatomic, retain) NSDate        *returnDate;

/**
 * Create a new library item with specifi values.
 * @param : type        type of the item.
 * @param : itemID      id of the item.
 * @param : title       title of the item.
 * @param : returnDate  the date on which the item must be returned.
 * @param : libraryId   library from which the item has been borrowed.
 * @param : status      the item current status.
 * @param : reminder    the time for the reminder.
 */
-(id) initWithValues:(ITEM_TYPE) type itemID:(NSNumber *)itemID
               title:(NSString *)title returnDate:(NSDate *) returnDate 
           libraryId:(NSNumber *) libraryId  status:(ITEM_STATUS) status
        reminderTime:(RETURN_DATE_REMINDER)reminder;

@end
