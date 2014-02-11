//
//  BaseHeader.m
//  Biblios
//

#import "BaseHeader.h"
#import "UIStyles.h"
@implementation BaseHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_labelSubText = [UIStyles customLabel:CELL_PADDING_LEFT y:VIEW_TOP_MARGINS 
                                      width:HEADER_WIDTH height:HEADER_TEXT_HEIGHT 
                                       font:MEDIUM_FONT_BOLD];
        [self addSubview:m_labelSubText];
      
        m_labelMainText = [UIStyles customLabel:CELL_PADDING_LEFT 
                                           y:VIEW_TOP_MARGINS + HEADER_TEXT_HEIGHT 
                                       width:HEADER_WIDTH height:HEADER_TITLE_HEIGHT 
                                        font:HEADER_FONT_BOLD];
        [self addSubview:m_labelMainText];
    }
    return self;
}

-(void) setTextContent:(NSString *) mainText subText:(NSString *) subText
{
    [m_labelSubText setText:subText];
    [m_labelMainText setText:mainText];
}

-(void) dealloc
{
    [m_labelSubText release];
    [m_labelMainText release];
}

@end
