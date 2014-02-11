//
//  LibraryDetailsCell.m
//  Biblios
//

#import "LibraryDetailsCell.h"
#import "UIStyles.h"
@implementation LibraryDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, CUSTOM_CELL_WIDTH , CUSTOM_CELL_HEIGHT)];
        
        background.backgroundColor = [UIStyles getColor:BACKGROUND_DARK_COLOR];
        self.backgroundView = background;
        [background release];
        
        UIView *separator = [[UIView alloc] initWithFrame:
                             CGRectMake(CELL_PADDING_LEFT, CUSTOM_CELL_HEIGHT, CUSTOM_CELL_WIDTH , 1)];
        separator.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        [self addSubview:separator];
        [separator release];

        
        // Set the position and the size of the icon view
        float x = CELL_PADDING_LEFT * 2;
        float y = CELL_PADDING_TOP;
        float width = ICON_WIDTH;
        float height = ICON_HEIGHT;
        self.backgroundColor = [UIStyles getColor:BACKGROUND_DARK_COLOR];
        m_iconView = [[UIView alloc]initWithFrame:
                      CGRectMake(x, y,ICON_WIDTH , ICON_HEIGHT)];
        [self addSubview:m_iconView];
        
        // Set the position and the size for the label of the first line.
        x += ICON_WIDTH + CELL_PADDING_LEFT;
        width = APPLICATION_WIDTH  -(VIEW_RIGHT_MARGINS *2) - 
                (CELL_PADDING_LEFT *3) - ICON_WIDTH;
        height = (height - 1) / 2 ;
        m_firstLineTextLabel = [UIStyles customLabel:x y:y width:width 
                                              height:height font:CONTENT_FONT];
        
        [self addSubview:m_firstLineTextLabel];
        
        // Label have the same size, we need to shift the second one below
        y += height + 1;
        m_secondLineTextLabel = [UIStyles customLabel:x y:y width:width 
                                              height:height font:CONTENT_FONT];
        
        [self addSubview:m_secondLineTextLabel];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTextLines:(NSString *) firstLineText secondLineText:(NSString *) secondText
{
    [m_firstLineTextLabel setText:firstLineText];
    [m_secondLineTextLabel setText:secondText];
    
}
-(void) setIconImage:(UIImage  *) iconImage
{
    [m_iconView addSubview:[[UIImageView alloc] initWithImage:iconImage]];
}

-(void) dealloc
{
    [m_iconView release];
    [m_firstLineTextLabel release];
    [m_secondLineTextLabel release];
    [super dealloc];
}
@end
