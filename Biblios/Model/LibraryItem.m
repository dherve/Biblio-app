//
//  LibraryItem.m
//  Biblios
//

#import "LibraryItem.h"
#import "Utilis.h"
@implementation LibraryItem
@synthesize type = m_type;
@synthesize reminderTime = m_reminderTime;
@synthesize title = m_title;
@synthesize returnDate = m_returnDate;
@synthesize itemID =  m_itemID;
@synthesize libraryId = m_libraryID;
@synthesize status = m_status;

-(id) initWithValues:(ITEM_TYPE) type itemID:(NSNumber *)itemID
               title:(NSString *)title returnDate:(NSDate *) returnDate 
           libraryId:(NSNumber *) libraryId  status:(ITEM_STATUS) status
        reminderTime:(RETURN_DATE_REMINDER)reminder;
{
    self = [super init];
    if(self != nil)
    {
        m_itemID = [itemID retain];
        m_type = type;
        m_title = [title retain];
        m_returnDate = [returnDate retain];
        m_libraryID = [libraryId retain];
        m_reminderTime = reminder;
        m_status = status;
    }
    return self;
}

-(NSString *) description
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:@"["];
    [desc appendFormat:@"item Id : %@, ", m_itemID.stringValue];
    [desc appendFormat:@"type %d", m_type];
    [desc appendFormat:@"title : %@, ", m_title];
    [desc appendFormat:@"return date : %@, ", [Utilis dateToString: m_returnDate 
                                                        withFormat:DATE_DEFAULT_FORMAT]];
    [desc appendFormat:@"reminder Time : %d, ", m_reminderTime];
    [desc appendFormat:@"Library Id : %@, ", m_libraryID.stringValue];
    
    [desc appendString:@"]"];
    return  desc;   
}

-(void) dealloc
{
    [m_title release];
    [m_returnDate release];
    [m_itemID release];
    [m_libraryID release];
    [super dealloc];
}

#pragma mark - static methods

@end
