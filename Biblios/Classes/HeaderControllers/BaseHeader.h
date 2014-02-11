//
//  BaseHeader.h
//  Biblios
//
//  Base headed used by other tableviews or uiview with a header.
//

#import <UIKit/UIKit.h>

@interface BaseHeader : UIView
{
    UILabel *m_labelSubText;
    UILabel *m_labelMainText;
}
-(void) setTextContent:(NSString *) mainText subText:(NSString *) subText;
@end
