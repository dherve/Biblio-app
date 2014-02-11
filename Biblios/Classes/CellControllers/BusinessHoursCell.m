//
//  BusinessHoursCell.m
//  Biblios
//

#import "BusinessHoursCell.h"
#import "UIStyles.h"
#import "Utilis.h"
@implementation BusinessHoursCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        float x = CELL_PADDING_LEFT;
        float width = CUSTOM_CELL_WIDTH;
        
        // Set the Background
        UIView *background = [[UIView alloc] initWithFrame:
                              CGRectMake(0, 0, width, BUSINESS_HOURS_CELL_HEIGHT)];
        background.backgroundColor = [UIStyles getColor:BACKGROUND_DARK_COLOR];
        self.backgroundView = background;
        [background release];
        
        // Set the line separator
        UIView *separator = [[UIView alloc] initWithFrame:
                             CGRectMake(x, BUSINESS_HOURS_CELL_HEIGHT, width , 1)];
        separator.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
        [self addSubview:separator];
        [separator release];
        
        // 
        x += CELL_PADDING_LEFT;
        
        // Width = half of the available width
        width = (width - CELL_PADDING_LEFT - CELL_PADDING_RIGHT) /2;
        //height = 12.0;
        // Create the label for the day
        m_dayLabel = [UIStyles customLabel:x y:0 width:width 
                                    height:BUSINESS_HOURS_CELL_HEIGHT 
                                      font:CONTENT_FONT];
        [self addSubview:m_dayLabel];
        
        // Shift the next label to the middle.
        x += width;
        
        // Create the label for the hours.
        m_hoursLabel = [UIStyles customLabel:x y:0 width:width 
                                    height:BUSINESS_HOURS_CELL_HEIGHT 
                                        font:CONTENT_FONT];
        [m_hoursLabel setTextAlignment:UITextAlignmentRight];
        [self addSubview:m_hoursLabel];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setTime:(NSString *) day openHours:(NSString *) hours
{
    [m_dayLabel setText:day];
    if([hours isEqualToString:@"00h00-00h00"]){
        [m_hoursLabel setText:NSLocalizedString(@"Closed", nil)];
    }else{
        [m_hoursLabel setText:hours];
    }
    
    NSString *today = [Utilis currentDateAsString:DATE_DAY_FORMAT];
    
    // Highlight the day it's the current day.
    if([day hasPrefix:today]){
        [m_dayLabel setTextColor:[UIColor blackColor]];
        [m_dayLabel setShadowColor:nil];
        [m_hoursLabel setTextColor:[UIColor blackColor]];
        [m_hoursLabel setShadowColor:nil];
    }
    
}

-(void) dealloc{
    [m_dayLabel release];
    [m_hoursLabel release];
    [super dealloc];
}
@end
