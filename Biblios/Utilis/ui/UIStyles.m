//
//  UIStyles.m
//  Biblios
//

#import "UIStyles.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark -
#pragma mark base protocol methods implementation
@interface UIStyles(PrivateAPI)
+(void) loadColors;
+(void) loadFonts;
+(void) loadIcons;
@end

@implementation UIStyles

static NSMutableArray *colors;
static NSMutableArray *fonts;
static NSMutableArray *icons;

#pragma mark - 
+(void) loadColors
{
    colors = [[NSMutableArray alloc] init];
    
    // tab and nav bar color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(176) 
                                      green:RGBVAL_TO_FLOAT(22) 
                                       blue:RGBVAL_TO_FLOAT(6) 
                                      alpha:1.0]];
    
    // Background light color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(241) 
                                      green:RGBVAL_TO_FLOAT(242) 
                                       blue:RGBVAL_TO_FLOAT(239) 
                                      alpha:1.0]];
    // Background dark color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(222) 
                                      green:RGBVAL_TO_FLOAT(223) 
                                       blue:RGBVAL_TO_FLOAT(221) 
                                      alpha:1.0]];
    // Icon background gray color 3
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(102) 
                                      green:RGBVAL_TO_FLOAT(102) 
                                       blue:RGBVAL_TO_FLOAT(102) 
                                      alpha:1.0]];
    
    // List line separator gray color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(210) 
                                      green:RGBVAL_TO_FLOAT(211) 
                                       blue:RGBVAL_TO_FLOAT(209) 
                                      alpha:1.0]];  
    
    // Header title text color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(51) 
                                      green:RGBVAL_TO_FLOAT(51) 
                                       blue:RGBVAL_TO_FLOAT(51) 
                                      alpha:1.0]]; 
    
    // Warning text color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(151) 
                                      green:RGBVAL_TO_FLOAT(0) 
                                       blue:RGBVAL_TO_FLOAT(0) 
                                      alpha:1.0]];
    
    // Content text color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(51) 
                                      green:RGBVAL_TO_FLOAT(51) 
                                       blue:RGBVAL_TO_FLOAT(51) 
                                      alpha:1.0]]; 
 
    // List small text color
    [colors addObject:[UIColor colorWithRed:RGBVAL_TO_FLOAT(51) 
                                      green:RGBVAL_TO_FLOAT(51) 
                                       blue:RGBVAL_TO_FLOAT(51) 
                                      alpha:1.0]]; 
}

+(void) loadFonts
{    
    fonts = [[NSMutableArray alloc] init];
        
    // Header font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT
                                      size:HEADER_TEXT_FONT_SIZE]];
    
    // Title font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT 
                                      size:VIEW_TITLE_FONT_SIZE]];
    
    // Medium font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT 
                                      size:MEDIUM_TEXT_FONT_SIZE]];
    // Content font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT_BOLD
                                      size:CONTENT_TEXT_FONT_SIZE]];
    
    // Normal font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT
                                      size:CONTENT_TEXT_FONT_SIZE]];
    
    // Header fon bold
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT_BOLD
                                      size:HEADER_TEXT_FONT_SIZE]];
    
    // Medium font bold
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT_BOLD 
                                      size:MEDIUM_TEXT_FONT_SIZE]];
    
    // Button font
    [fonts addObject: [UIFont fontWithName:APPLICATION_FONT_BOLD 
                                      size:BUTTON_TITLE_FONT_SIZE]];
}

+(void) loadImages
{
    icons = [[NSMutableArray alloc] init];
    
    // Holder image
    [icons addObject:[UIImage imageNamed:IMG_ICON_HOLDER]];
    
    // Load the remaining images
}

#pragma mark - element accessors implementation
+(UIColor *) getColor:(APPLICATION_THEME_COLOR) color
{
    if(colors == nil)
        [self loadColors];
    return  [colors objectAtIndex:color];
}

+(UIFont *)  getFont:(APPLICATION_THEME_FONT) font
{
    if(fonts == nil)
        [self loadFonts];
    return [fonts objectAtIndex:font];
}

+(UIImage *) getIcon:(APPLICATION_THEME_ICON) icon
{
    if(icons == nil)
        [self loadIcons];
    return  [icons objectAtIndex:icon];
}

+(UIButton *) customButton:(CGFloat)x y:(CGFloat) y width:(CGFloat) width 
                    height:(CGFloat)height color:(APPLICATION_THEME_COLOR) color 
              cornerRadius:(CGFloat)radius;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[colors objectAtIndex:color]];    
    [button setFrame:CGRectMake(x, y, width, height)];
    [[button layer] setCornerRadius:radius];    
    return button;
}


+(UIButton *) customButton:(CGFloat)x y:(CGFloat)y width:(CGFloat)width 
                    height:(CGFloat)height backgroundImage:(NSString *)image 
    backgroundImagePressed:(NSString *) imagePressed
{
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x,y,width,height)];
    [button setBackgroundImage:[[UIImage imageNamed:image] 
                                stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] 
                      forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:imagePressed] 
                                stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] 
                      forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIStyles getFont:BUTTON_TITLE_FONT]];   
    return button;
}


+(UIButton *) defaultCustomButton:(CGFloat)x y:(CGFloat)y width:(CGFloat)width 
                           height:(CGFloat)height
{
    UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(x,y,width,height)];
    [button setBackgroundImage:[[UIImage imageNamed:IMG_BUTTON_NORMAL] 
                                stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] 
                      forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:IMG_BUTTON_PRESSED] 
                                stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] 
                      forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIStyles getFont:BUTTON_TITLE_FONT]];
    return button;
}

+(UILabel *) customLabel:(CGFloat)x y:(CGFloat) y width:(CGFloat) width 
                  height:(CGFloat)height font:(APPLICATION_THEME_FONT)font
{
    
    // Header title text
    CGRect frame = CGRectMake(x, y,width,height);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[colors objectAtIndex:CONTENT_TEXT_COLOR]];

    if(fonts == nil)
        [self loadFonts];
    [label setFont:[fonts objectAtIndex:font]];
    
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0,1);
    return label;
}

+(UISegmentedControl *) customSegmentedControl:(CGFloat)x y:(CGFloat) y 
                                         width:(CGFloat) width 
                                        height:(CGFloat)height 
                                         items:(NSArray *)items 
                                         color:(APPLICATION_THEME_COLOR) color;
{
    
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:items];
    control.momentary = YES; 
    control.frame = CGRectMake(x, y, width,height);
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    control.tintColor = [colors objectAtIndex:color];
    return  control;
}

+(UIActionSheet *) customActionSheet:(CGFloat) x y:(CGFloat)y 
                               width:(CGFloat)width 
                              height:(CGFloat)height 
                     backgroundColor:(APPLICATION_THEME_COLOR) color
{
     UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                delegate:nil
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
    CGRect frame = CGRectMake(x, y, width, height);
    UIView *background = [[UIView alloc] initWithFrame:frame];
    background.backgroundColor = [UIStyles getColor:BACKGROUND_UIBAR_COLOR];
    [background setAlpha:0.65];
    [actionSheet addSubview:background];
    [background release];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet setBounds:frame];
    return actionSheet;
}

+(CGFloat) heightForText:(NSString *) text textOffSet:(float) offSet
{
    CGSize maxSize =CGSizeMake(CUSTOM_CELL_WIDTH-offSet, APPLICATION_HEIGHT/3);
    CGSize expectedSize = [text sizeWithFont:[fonts objectAtIndex:CONTENT_FONT]
                           constrainedToSize:maxSize
                               lineBreakMode:UILineBreakModeWordWrap];
    return expectedSize.height;
}

@end
