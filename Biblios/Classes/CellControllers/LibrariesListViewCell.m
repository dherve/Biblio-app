//
//  LibrariesListViewCell.m
//  Biblios
//

#import "LibrariesListViewCell.h"
#import "UIStyles.h"
@implementation LibrariesListViewCell
@synthesize name = m_name;
@synthesize libraryID = m_libraryID;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, APPLICATION_WIDTH , 50)];
        
        background.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        self.backgroundView = background;
        [background release];
        
        CGFloat x = CELL_PADDING_LEFT;
        CGFloat y = CELL_PADDING_TOP;
        CGFloat width = CUSTOM_CELL_WIDTH - x;
        m_subTextLabel = [UIStyles customLabel:x y:y 
                                        width:width
                                       height:UILABEL_DEFAULT_HEIGHT 
                                         font:CONTENT_FONT];
        [m_subTextLabel setTextColor:[UIStyles getColor:BACKGROUND_GRAY_COLOR]];
        m_subTextLabel.shadowColor = nil;
        [self addSubview:m_subTextLabel];
        
        y += UILABEL_DEFAULT_HEIGHT + 1;
        m_libraryNameLabel = [UIStyles customLabel:x y:y width:width 
                                            height:20 
                                              font:HEADER_FONT_BOLD];
        m_libraryNameLabel.shadowColor = nil;
        [self  addSubview:m_libraryNameLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setContentData:(Library *) library
{
    m_libraryID = library.librayId;
    [m_subTextLabel setText:NSLocalizedString(@"Library", "Library naming")];
    [m_libraryNameLabel setText:library.name];
}
-(void) dealloc
{
    [m_name release];
//    [m_iconView release];
    [m_libraryID release];
    [m_subTextLabel release];
    [m_libraryNameLabel release];
    [super dealloc];
}
@end
