//
//  Utilis.m
//  Biblios
//

#import "Utilis.h"

@implementation Utilis
static NSDateFormatter      *_dateFormatter;
static NSNumberFormatter    *_numberFormatter; 

+(NSDate *) dateFromString:(NSString *) date withFormat:(NSString *) format
{
    if(_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    [_dateFormatter setDateFormat:format];
    return [_dateFormatter dateFromString:date];
}

+(NSString *) dateToString:(NSDate *) date withFormat:(NSString *) format
{
    
    if(_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    [_dateFormatter setDateFormat:format];
    
    return [_dateFormatter stringFromDate:date];
}

+(NSNumber *) numberFromString:(NSString *) number 
                     withStyle:(NSNumberFormatterStyle) style
{
    if(_numberFormatter == nil)
    {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:style];
    }
    return [_numberFormatter numberFromString:number];
}

+(NSString *) filterString:(NSString *) stringToFilter filter:(NSArray *) filter
{
    for (NSString *toRemove in filter) {
        stringToFilter =  [stringToFilter stringByReplacingOccurrencesOfString:toRemove 
                                                                    withString:@""];
    }
    return stringToFilter;
}

+(NSString *) currentDateAsString:(NSString *) format
{
    if(_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    [_dateFormatter setDateFormat:format];
    return [_dateFormatter stringFromDate:[NSDate date]];
}

+(NSString *) userLanguage
{
    NSString* language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    // If the user language is not supported return english
    if(![language isEqualToString:@"fr" ] && ![language isEqualToString:@"en"])
    {
        return @"en";
    }
    return language;
}

+(NSString *) getErrorDescription:(NSError *) error
{
    NSString *description = nil;
    if(error != nil)
    {     
        description = [NSString stringWithFormat:@"ERROR : %@, REASON : %@",
                       [error localizedDescription],[error localizedFailureReason]];
    }
    return  description;
}


+(NSString *) stringFromData:(NSMutableData *) data
{
    NSString *dataString = nil;
    if(data != nil && [data length] > 0)
    {
        dataString = [[NSString alloc] initWithData:data 
                                           encoding:NSASCIIStringEncoding];
    }
    return dataString;
}

+(NSString *) trimLeadingWhiteSpace:(NSString *) string
{
    if(string != nil){
        return [string stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];       
    }
    return nil;
}

+ (NSString *) stringValueFromDictionary:(NSDictionary *) dictionary 
                                  forKey:(NSString *) key
{
    NSString *value  = @"";
    if(dictionary != nil && key != nil){
        NSString *dicValue = [dictionary objectForKey:key];
        value = (dicValue== nil) ? @"" : dicValue;
    }
    return value;
}

+(NSString *) dayFromNumericValue:(NSInteger) value;
{
    switch (value) {
        case 1: return NSLocalizedString(@"Monday", nil);
        case 2: return NSLocalizedString(@"Tuesday", nil);
        case 3: return NSLocalizedString(@"Wednesday", nil);
        case 4: return NSLocalizedString(@"Thursday", nil);
        case 5: return NSLocalizedString(@"Friday", nil);
        case 6: return NSLocalizedString(@"Saturday", nil);
        case 7: return NSLocalizedString(@"Sunday", nil);
    }
    return nil;
    
}

+(NSArray *) sortArray:(NSArray *) array usingAttribute:(NSString *) attribute 
             ascending:(BOOL) ascending;
{
    if(array == nil || attribute == nil || array.count == 0)
        return array;
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:attribute
                                                                    ascending:ascending] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [array sortedArrayUsingDescriptors:sortDescriptors];
}
@end
