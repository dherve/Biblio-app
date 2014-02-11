//
//  LibraryItemsListViewCell.m
//  Biblios
//

#import "LibraryItemsListViewCell.h"
#import "UIStyles.h"
#import "Db.h"
#import "Utilis.h"
#import "Notifications.h"
@interface LibraryItemsListViewCell(PrivateAPI)
    -(void) removeItem;
@end

@implementation LibraryItemsListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, CUSTOM_CELL_WIDTH , 
                                         60)];
        background.backgroundColor = [UIStyles getColor:BACKGROUND_DARK_COLOR];
        self.backgroundView = background;
        [background release];
        
        m_separator= [[UIView alloc] initWithFrame:
                             CGRectMake(CELL_PADDING_LEFT, 60, 
                                        CUSTOM_CELL_WIDTH , 1)];
        m_separator.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        [self addSubview:m_separator];
        
        CGFloat x = CELL_PADDING_LEFT * 2;
        CGFloat y = CELL_PADDING_TOP;

        CGFloat width = CUSTOM_CELL_WIDTH - CELL_PADDING_RIGHT - x - UIBUTTON_DEFAULT_WIDTH;
        
        m_titleLabel = [UIStyles customLabel:x y:y width:width 
                                      height:UILABEL_DEFAULT_HEIGHT 
                                        font:CONTENT_FONT];
        [self addSubview:m_titleLabel];
                
        m_deleteButton = [UIStyles defaultCustomButton:x + width + CELL_PADDING_RIGHT y:y 
                                                 width:UIBUTTON_DEFAULT_WIDTH 
                                                height:UILABEL_DEFAULT_HEIGHT*2 + LABEL_LEADING_SPACE];
        [m_deleteButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
        [m_deleteButton addTarget:self action:@selector(removeItem) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:m_deleteButton];
        
        y += UILABEL_DEFAULT_HEIGHT + LABEL_LEADING_SPACE;
        m_dateLabel = [UIStyles customLabel:x y:y width:width 
                                     height:UILABEL_DEFAULT_HEIGHT 
                                       font:CONTENT_FONT];
        [self addSubview:m_dateLabel];
        
        y += UILABEL_DEFAULT_HEIGHT + LABEL_LEADING_SPACE;
        m_libraryNameLabel = [UIStyles customLabel:x y:y width:width 
                                            height:UILABEL_DEFAULT_HEIGHT 
                                              font:CONTENT_FONT];
        [self  addSubview:m_libraryNameLabel];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setContentData:(LibraryItem *) libraryItem
{
    m_itemId = libraryItem.itemID;
    [m_titleLabel setText:libraryItem.title];
    NSDate *today = [NSDate date];
    NSString *returnDateText = [Utilis dateToString:libraryItem.returnDate 
                                         withFormat:DATE_DEFAULT_FORMAT];
    
    
    // The item is late set the return date in red
    if([libraryItem.returnDate compare:today] == NSOrderedAscending){
        returnDateText = [returnDateText stringByAppendingFormat:@" (%@)",
                          NSLocalizedString(@"Overdue", "Message shown when an item is overdue")];
        [m_dateLabel setTextColor:[UIStyles getColor:WARNING_TEXT_COLOR]];
    }
    else
    {
        [m_dateLabel setTextColor:[UIStyles getColor:CONTENT_TEXT_COLOR]];
    }
    [m_dateLabel setText:returnDateText];
    [m_libraryNameLabel setText:[[[Db sharedDB] 
                                  getLibrary:libraryItem.libraryId] name]];   
}

-(void) dealloc
{
    [m_titleLabel release];
    [m_dateLabel release];
    [m_libraryNameLabel release];
    [m_deleteButton release];
    [m_separator release];
    [m_itemId release];
    [super dealloc];
}
-(void) removeItem
{
    [[Db sharedDB] removeLibraryItem:m_itemId];
}

@end
