//
//  InputTableViewCell.m
//  Biblios
//

#import "InputTextCell.h"
#import "UIStyles.h"
@implementation InputTextCell

@synthesize inputTextField = m_inputTextField;
@synthesize inputTextLabel = m_textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Set the background.
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, CUSTOM_CELL_WIDTH, INPUT_CELL_HEIGHT)];
        
        background.backgroundColor = [UIStyles getColor:BACKGROUND_DARK_COLOR];
        self.backgroundView = background;
        [background release];
        
        // Set the separator.
        UIView *separator = [[UIView alloc] initWithFrame:
                             CGRectMake(CELL_PADDING_LEFT, INPUT_CELL_HEIGHT, 
                                        CUSTOM_CELL_WIDTH, 1)];
        separator.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        [self addSubview:separator];
        [separator release];
        
        // Set the coordinates of the label
        float x = CELL_PADDING_LEFT *2;
        float y = CELL_PADDING_TOP;
        float width = CUSTOM_CELL_WIDTH - CELL_PADDING_LEFT - CELL_PADDING_RIGHT;

        // Set the label.
        m_textLabel = [UIStyles customLabel:x y:y width:width 
                                     height:UILABEL_DEFAULT_HEIGHT 
                                       font:CONTENT_FONT];
        [self addSubview:m_textLabel];
        
        // Shift below the label the input field.
        y += UILABEL_DEFAULT_HEIGHT + 5;
        m_inputTextField = [[UITextField alloc] initWithFrame:
                            CGRectMake(x, y, width, INPUT_FIELD_DEFAULT_HEIGHT)]; 
        [m_inputTextField setFont:[UIStyles getFont:CONTENT_FONT]];
         m_inputTextField.textAlignment = UITextAlignmentLeft;
         m_inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:m_inputTextField];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [m_textLabel release];
    [m_inputTextField release];
    [super dealloc];
}

-(BOOL) hasError
{
    return m_hasError;
}

-(void) markForError
{
    if(!m_hasError)
    {
        [m_textLabel setTextColor:[UIStyles getColor:WARNING_TEXT_COLOR]];
        NSString *text = [NSString stringWithFormat:@"%@ %@",m_textLabel.text,
                          INPUT_FIELD_ERROR_MARK];
        m_textLabel.text = text;
        m_hasError = YES;
    }
}

-(void) clearErrorMark
{
    if(m_hasError)
    {
        NSString *text = m_textLabel.text;
        NSRange end = [text rangeOfString:INPUT_FIELD_ERROR_MARK];
        m_textLabel.text = [text substringToIndex:end.location];
        [m_textLabel setTextColor:[UIStyles getColor:CONTENT_TEXT_COLOR]];
        m_hasError = NO;
    }
}

@end
