//
//  XmlResultSet.h
//  Biblios
//
//  Holds the results from a XPath request.
//

#import <Foundation/Foundation.h>

@interface XmlResultSet : NSObject
{
    NSString    *m_resultType;
    NSArray     *m_resultArray;
}
@property (nonatomic, retain) NSString *resultType;
@property (nonatomic, retain) NSArray  *resultArray;
@end
