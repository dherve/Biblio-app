//
//  XmlResultSet.m
//  Biblios
//

#import "XmlResultSet.h"

@implementation XmlResultSet
@synthesize resultType = m_resultType;
@synthesize resultArray = m_resultArray;

-(id)init
{
    self = [super init];
    if(self)
    {
        m_resultType = @"";
        m_resultArray = [[NSArray alloc] init];
    }
    return self;
}
-(void) dealloc
{
    if(m_resultType != nil)
        [m_resultType release];
    [m_resultArray release];
}
@end
