//
//  DataHelper.h
//  Biblios
//
//  Provide functions to get the differents values availables for a specific
//  enum type. Here most of those enum types are related to a library item.
//

#import <Foundation/Foundation.h>
#import "LibraryItem.h"
@interface DataHelper : NSObject

/**
 * @return : An array of all item types values.
 */
+(NSArray *) itemTypeValues;

/**
 * @return : An array of all item status values.
 */
+(NSArray *) itemStatusValues;

/**
 * @return : An array of all reminder time values.
 */
+(NSArray *) reminderDateValues;

/**
 * @return : An array of available languages for a library item.
 */
+(NSArray *) itemLanguageValues;

/**
 * @return : An array of available categories for a library item.
 */
+(NSArray *) itemCategoriesValues;

/**
 * @return : the code of an item language.
 * @param : the language from which to get the code.
 */
+(NSString *) itemLanguageCode:(ITEM_LANGUAGE) language;

/**
 * @return : the code of an item category
 * @param : the category from which to get the code.
 */
+(NSString *) itemCategoryCode:(ITEM_CATEGORY) category;
@end
