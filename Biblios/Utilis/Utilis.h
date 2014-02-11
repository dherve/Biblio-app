//
//  Utilis.h
//  Biblios
//
//  Provide common utility functions.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "LibraryItem.h"
#define DATE_DEFAULT_FORMAT     @"dd.MM.yyyy"
#define DATE_DAY_FORMAT         @"EEE"
@interface Utilis : NSObject

/**
 * Get the date from  the date's string representation.
 * @param : date   String representation of the date.
 * @param : format The format used to represent the date.
 * @return : A date object corresponding to the input string date.
 */
+(NSDate *) dateFromString:(NSString *) date withFormat:(NSString *) format;

/**
 * Get the String representation of a date object.
 * @param : date   the date object.
 * @param : format The format used to represent the date.
 * @return : String representation of the date object.
 */
+(NSString *) dateToString:(NSDate *) date withFormat:(NSString *) format;

/**
 * Convert a numeric string to the correpsponding number.
 * @param : number String representation of the number ot convert.
 * @param : style  The style to use for.
 * @return : A number object corresponnding to the input string.
 */
+(NSNumber *) numberFromString:(NSString *) number 
                     withStyle:(NSNumberFormatterStyle) style;

/**
 * Get the current date string representation.
 * @param : format the format used to represent the date.
 * @return : String representation of the current date in the specified format.
 */
+(NSString *) currentDateAsString:(NSString *) format;


/**
 * @return the user current language, if is is part of the supported languages
 * (english and french). Otherwise return english  by default.
 */
+(NSString *) userLanguage;

/**
 * Get the description and the reason of an error.
 * @param : error the error object.
 * @return : string description and reason of ther error, nil if not available.
 */
+(NSString *) getErrorDescription:(NSError *) error;

/**
 * Filter a given string by removing specific symbols.
 * @param : stringToFilter  the string to filter.
 * @param : filter          an array containing the symbols to remove.
 * @return : A string with the specified symbols removed.
 */
+(NSString *) filterString:(NSString *) stringToFilter filter:(NSArray *) filter;

/**
 * Create a string from data.
 * @param : data the date ot use to create a string.
 * @return : String representation of the data, nil if the data is nil.
 */
+(NSString *) stringFromData:(NSMutableData *) data;

/**
 * Remove white space from a string.
 * @param  : string the string to remove whitespace from.
 * @return : A corresponding without whitespaces, nil if the string received was
 *           nil.
 */
+(NSString *) trimLeadingWhiteSpace:(NSString *) string;

/**
 * Get the string value of a key from a dictionary. This is a more "safe" 
 * method checking for null values.
 * @param : dictionary The dictionary from which to retrieve the value.
 * @param : key The for which the value is retrieved.
 * A string object corresponding to the key if the key is valis, nil otherwise.
 */
+(NSString *) stringValueFromDictionary:(NSDictionary *) dictionary 
                                  forKey:(NSString *) key;

/**
 * Return the name of day based on its numeric representation.
 * @param : value : numeric representation of the day.
 * @return : The localized name of the corresponding day.
 */
+(NSString *) dayFromNumericValue:(NSInteger) value;

/**
 * Sort an array of objects based on a specific attribute of those objects.
 * @param : array       the array of objects to sort.
 * @param : attribute   the attribute to be used when sorting.
 * @param : ascending   flag indicating whether or not the sorted objects should
 *                      be in ascending order or not.
 * @return  the corresponding array with the objects sorted.
 */
+(NSArray *) sortArray:(NSArray *) array usingAttribute:(NSString *) attribute 
             ascending:(BOOL) ascending;

@end
