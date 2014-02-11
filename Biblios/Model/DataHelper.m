//
//  DataHelper.m
//  Biblios
//

#import "DataHelper.h"
static NSMutableArray  *_itemTypeValues = nil;
static NSMutableArray  *_itemCategorieValues = nil;
static NSMutableArray  *_itemLanguageValues = nil;
static NSMutableArray  *_itemStatusValues = nil;
static NSMutableArray  *_itemReminderDateValues = nil;
@implementation DataHelper

+(NSArray *) itemTypeValues
{
    if(_itemTypeValues == nil)
    {
        _itemTypeValues = [[NSMutableArray alloc] init];
        [_itemTypeValues addObject:NSLocalizedString(@"PRINTED BOOK",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"NUMERIC BOOK",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"MUSIC CD",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"NEWSPAPER",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"MAGAZINE",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"JOURNAL",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"DVD",nil)];
        [_itemTypeValues addObject:NSLocalizedString(@"AUDIO TAPE",nil)];        
    }
    return  _itemTypeValues;
}

+(NSArray *) itemStatusValues
{
    if(_itemStatusValues == nil){
        _itemStatusValues = [[NSMutableArray alloc] init];
        [_itemStatusValues addObject:NSLocalizedString(@"ON HOLD",nil)];
        [_itemStatusValues addObject:NSLocalizedString(@"AVAILABLE",nil)];
        [_itemStatusValues addObject:NSLocalizedString(@"LATE",nil)];
    }
    return  _itemStatusValues;    
}

+(NSArray *) reminderDateValues
{
    if(_itemReminderDateValues == nil)
    {
        _itemReminderDateValues = [[NSMutableArray alloc] init];
        [_itemReminderDateValues addObject:NSLocalizedString(@"ONE WEEK BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"TREE DAYS BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"ONE DAY BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"ONE HOUR BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"THIRTY MIN BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"FIFTEEN MIN BEFORE",nil)];
        [_itemReminderDateValues addObject:NSLocalizedString(@"ON TIME",nil)];  
        [_itemReminderDateValues addObject:NSLocalizedString(@"NO REMINDER",nil)]; 
    }
    return  _itemReminderDateValues;
}

+(NSArray *) itemLanguageValues
{
    if(_itemLanguageValues == nil){
        _itemLanguageValues = [[NSMutableArray alloc] init];
        [_itemLanguageValues addObject:NSLocalizedString(@"FRENCH",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"ENGLISH",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"ARABIC",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"BENGALI",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"CHINESE",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"CREOLE",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"DUTCH",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"GERMAN",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"GREEK",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"GUJARATI",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"HINDI",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"ITALIAN",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"PANDJABI",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"PORTUGUESE",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"RUSSIAN",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"SPANISH",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"TAGALOG",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"TAMIL",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"URDOUD",nil)];
        [_itemLanguageValues addObject:NSLocalizedString(@"VIETNAMIESE",nil)];        
    }
    return  _itemLanguageValues;
}
+(NSArray *) itemCategoriesValues
{
    if(_itemCategorieValues == nil){
        _itemCategorieValues = [[NSMutableArray alloc] init];
        [_itemCategorieValues addObject:NSLocalizedString(@"AUDIO BOOKS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"AUDIO CASSETTE",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"BOOK",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"BRAILLE BOOK",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"BOARD BOOK",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"CARTOGRAPHIC MATERIAL",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"CD ROM",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"COMPACT DISC",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"DVD",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"DVD BLU-RAYS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"DVD ROMS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"E BOOKS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"GAME AND TOYS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"GOVERNEMENT DOCS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"INTERNET RESSOURCES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"KITS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"LANGUAGE COURSES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"LARGE PRINT BOOKS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"MICROFORMS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"MUSICAL SCORES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"POSTER",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"SERIALS",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"VERTICAL FILES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"VIDEOCASSETTES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"VIDEO GAMES",nil)];
        [_itemCategorieValues addObject:NSLocalizedString(@"ALL",nil)];        
    }
    return  _itemCategorieValues;   
}

+(NSString *) itemLanguageCode:(ITEM_LANGUAGE) language
{
    NSString *code = @"";
    switch (language) {
        // Special handling for creole and tagalog.
        case CREOLE:    return @"hat";
        case TAGALOG:   return @"tgl";
        default:
        {
            NSString *lang = [[self itemLanguageValues] objectAtIndex:language];            
            if(lang && lang.length > 3){
                code = [lang substringToIndex:3];
            }
        }
            break;
    }
    return code;
}

+(NSString *) itemCategoryCode:(ITEM_CATEGORY) category
{
    switch (category) {
        case AUDIO_BOOK:            return  @"t";
        case AUDIO_CASSETTE:        return  @"u";
        case BOOK:                  return  @"-";
        case BRAILLE_BOOK:          return  @"b";
        case BOARD_BOOK:            return  @"a";
        case CARTOGRAPHIC_MATERIAL: return  @"w";
        case CD_ROM:                return  @"r";
        case COMPACT_DISC:          return  @"c";
        case DVDS:                  return  @"d";
        case DVD_BLU_RAY:           return  @"f";
        case DVD_ROMS:              return  @"e";
        case E_BOOK:                return  @"y";
        case GAMES_TOYS:            return  @"j";
        case GOVERNMENT_DOCUMENTS:  return  @"o";
        case INTERNET_RESSOURCES:   return  @"i";
        case KITS:                  return  @"k";
        case LANGUAGE_COURSES:      return  @"l";
        case LARGE_PRINT_BOOKS:     return  @"g";
        case MICROFORMS:            return  @"q";
        case MUSICAL_SCORES:        return  @"m";
        case POSTER:                return  @"p";
        case SERIALS:               return  @"s";
        case VERTICAL_FILES:        return  @"h";
        case VIDEOCASSETTES:        return  @"v";
        case VIDEO_GAME:            return  @"x";
        case ALL:                   return  @"";
        default:        return  @"";
    }
}
@end
