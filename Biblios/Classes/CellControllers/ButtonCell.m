//
//  ButtonCell.m
//  Biblios
//

#import "ButtonCell.h"
#import "UIStyles.h"
@implementation ButtonCell
@synthesize button = m_button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Set the background of the cell.
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, CUSTOM_CELL_WIDTH, INPUT_CELL_HEIGHT)];
        
        background.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        self.backgroundView = background;
        [background release];
        
        // set the button to be shown.
        m_button = [UIStyles defaultCustomButton:CELL_PADDING_LEFT*2 y:CELL_PADDING_TOP 
                                           width:UIBUTTON_DEFAULT_HEGIHT *2 
                                          height:UIBUTTON_DEFAULT_HEGIHT];

        [[m_button titleLabel] setFont:[UIStyles getFont:CONTENT_FONT]];
        [self addSubview:m_button];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) dealloc
{
    [m_button release];
}

@end
