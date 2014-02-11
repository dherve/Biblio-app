//
//  UIStyles.h
//  Biblios
//
//  Provide creational methods for differents UI elements used in the application.
//  Holds constants that are used to define the look and feel of those elements.
//

#import <Foundation/Foundation.h>

// Convert rgb value (0-255) to float
#define RGBVAL_TO_FLOAT(a) a/255.0f

// Margins and paddings
#define VIEW_LEFT_MARGINS           20.0f
#define VIEW_RIGHT_MARGINS          20.0f
#define VIEW_TOP_MARGINS            20.0f
#define CELL_PADDING_LEFT           10.0f
#define CELL_PADDING_RIGHT          10.0f
#define CELL_PADDING_TOP            10.0f
#define CELL_PADDING_BOTTOM         10.0f

// Icon width
#define ICON_WIDTH                  25.0f
#define ICON_HEIGHT                 25.0f

// Application font
#define APPLICATION_FONT            @"Helvetica"
#define APPLICATION_FONT_BOLD       @"Helvetica-Bold"

// Text size
#define HEADER_TEXT_FONT_SIZE       18.0f
#define MEDIUM_TEXT_FONT_SIZE       14.0f
#define CONTENT_TEXT_FONT_SIZE      12.0f
#define VIEW_TITLE_FONT_SIZE        26.0f
#define BUTTON_TITLE_FONT_SIZE      13.0f

// UI Dimensions
#define APPLICATION_WIDTH           320.0f
#define APPLICATION_HEIGHT          480.0f
#define TABLEVIEW_DEFAULT_WIDTH     APPLICATION_WIDTH - (CELL_PADDING_LEFT * 2)
#define TABLEVIEW_DEFAULT_HEIGHT    APPLICATION_HEIGHT - VIEW_TOP_MARGINS
#define HEADER_TEXT_HEIGHT          15.0f
#define HEADER_TITLE_HEIGHT         20.0f
#define HEADER_HEIGHT               60.0f
#define HEADER_WIDTH                APPLICATION_WIDTH - (VIEW_RIGHT_MARGINS) 
#define CUSTOM_CELL_WIDTH           APPLICATION_WIDTH - (VIEW_RIGHT_MARGINS * 2)
#define CUSTOM_CELL_HEIGHT          45.0
#define INPUT_CELL_HEIGHT           60.0f
#define INPUT_FIELD_DEFAULT_HEIGHT  25.0F
#define BUSINESS_HOURS_CELL_HEIGHT  21.0f
#define UILABEL_DEFAULT_HEIGHT      12.0f
#define UIPICKER_DEFAULT_HEIGHT     216.0f
#define UIBUTTON_DEFAULT_WIDTH      50.0f
#define UIBUTTON_DEFAULT_HEGIHT     30.0f
#define LABEL_LEADING_SPACE         0.83f

// Application images
#define IMG_ICON_HOLDER             @"icon_holder.png"
#define IMG_NAVBAR_BG_PATTERN       @"nav_bar_bg_img.png"
#define IMG_INPUT_FIELD_BG          @"input_field_bg.png"
#define IMG_CAR_ICON                @"car_icon.png"
#define IMG_METRO_ICON              @"metro_icon.png"
#define IMG_WALK_ICON               @"walk_icon.png"
#define IMG_LIBRARY_ICON            @"library_icon.png"
#define IMG_COMPASS_ICON            @"compass_icon.png"
#define IMG_PHONE_ICON              @"phone_icon.png"
#define IMG_BUTTON_PRESSED          @"btn_stretchable_btn_selected2.png"
#define IMG_BUTTON_NORMAL           @"btn_stretchable_btn2.png"
#define IMG_NAVIGATION_BAR_BG       @"topbar_bg.png"
#define IMG_TAB_BAR_BG              @"tab_bar_bg.png"
#define BLANK_TEXT                  @" "

#define INPUT_FIELD_MIN_VALUE       1
#define INPUT_FIELD_ERROR_MARK      NSLocalizedString(@" (INVALID VALUE)", nil)

// Application colors
typedef enum
{

    BACKGROUND_UIBAR_COLOR = 0,
    BACKGROUND_LIGHT_COLOR = 1,
    BACKGROUND_DARK_COLOR  = 2,
    BACKGROUND_GRAY_COLOR  = 3,
    LINE_SEPARATOR_COLOR   = 4,
    
    // Text colors
    HEADER_TEXT_COLOR      = 5,
    WARNING_TEXT_COLOR     = 6,
    CONTENT_TEXT_COLOR     = 7,
    LIST_SMALL_TEXT_COLOR  = 8,
    
    
}APPLICATION_THEME_COLOR;

// Application font
typedef enum
{
    HEADER_FONT         = 0,
    TITLE_FONT          = 1,
    MEDIUM_FONT         = 2,
    CONTENT_FONT        = 3,
    NORMAL_FONT         = 4,
    HEADER_FONT_BOLD    = 5,
    MEDIUM_FONT_BOLD    = 6,
    BUTTON_TITLE_FONT   = 7
}APPLICATION_THEME_FONT;

// Application icons
typedef enum 
{
    IMG_HOLDER_ICON = 0,
    LIBRARY_ICON    = 1,
    TELEPHONE_ICON  = 2,
    COMPASS_ICON    = 3,
    SEARCH_ICON     = 4,
    METRO_ICON      = 5,
    BUS_ICON        = 6,
    PEDESTRIAN_ICON = 7,
    VEHICLE_ICON    = 8,
    CD_ICON         = 9,
    BOOK_ICON       = 10,
    REFRESH_ICON    = 11,
    ITEMS_LIST_ICON = 12,
    CHECKBOX_CHECKED_ICON   = 14,
    CHECKBOX_UNCHECKED_ICON = 15
    
}APPLICATION_THEME_ICON;

@interface UIStyles : NSObject


/**
 * Get a color
 * @param : color enum value of the color to get.
 * @return A new color object corresponding to the specified color.
 */
+(UIColor *) getColor:(APPLICATION_THEME_COLOR) color;

/**
 * Get a font.
 * @param : font the enum value of the font to get.
 * @return a UIFont object corresponding to the specified font, nil if not found.
 */
+(UIFont *)  getFont:(APPLICATION_THEME_FONT) font;

/**
 * Get the image of an icon.
 * @param : icon enum value of the icon to get.
 * @return a UIImage corresponding to the specified icon, nil if not found.
 */
+(UIImage *) getIcon:(APPLICATION_THEME_ICON) icon;

/**
 * Create a custom text label.
 * @param : x         horizontal position of the label.
 * @param : y         vertical position of the label.
 * @param : width     width of the label.
 * @param : height    height of the label.
 * @param : font      font to use for the label text.
 * @ return a custom label set as specified with the parameters.
 */
+(UILabel *) customLabel:(CGFloat)x y:(CGFloat) y width:(CGFloat) width 
                  height:(CGFloat)height font:(APPLICATION_THEME_FONT)font;

/**
 * Create a custom button with a specific color and corner radius.
 * @param : x             horizontal position of the button.
 * @param : y             vertical position of the button.
 * @param : width         width of the button.
 * @param : height        height of the button.
 * @param : color         color of the button.
 * @param : cornerRadius  radius for the button corners.
 * @return A custom button with attributes set as specified by the parameters.
 */
+(UIButton *) customButton:(CGFloat)x y:(CGFloat) y width:(CGFloat) width 
                    height:(CGFloat)height color:(APPLICATION_THEME_COLOR) color 
              cornerRadius:(CGFloat)radius;

/**
 * Create a custom button with specific images as background.
 * @param : x                         horizontal position of the button.
 * @param : y                         vertical position of the button.
 * @param : width                     width of the button.
 * @param : height                    height of the button.
 * @param : backgroundImage           the image to use as background when the button is not pressed.
 * @param : backgroundImagePressed    the image to use as background when the button is pressed.
 * @return A custom button with attributes set as specified by the parameters.
 */
+(UIButton *) customButton:(CGFloat)x y:(CGFloat)y width:(CGFloat)width 
                    height:(CGFloat)height backgroundImage:(NSString *)image 
    backgroundImagePressed:(NSString *) imagePressed;

/**
 * Create a custom button.
 * @param : x horizontal position of the button.
 * @param : y vertical position of the button.
 * @param : width width of the button.
 * @param : height height of the button.
 * @return A custom button with attributes set as specified by the parameters.
 */
+(UIButton *) defaultCustomButton:(CGFloat)x y:(CGFloat)y width:(CGFloat)width 
                           height:(CGFloat)height;

/**
 * Create a custom segmented control.
 * @param : x       horizontal position of the segmented control.
 * @param : y       vertical position of the segmented control.
 * @param : width   width of the segmented control.
 * @param : height  height of the segmented control.
 * @param : items   array of text titles or image to use in segments.
 * @param : color   color of the segmented control.
 * @return A custom segmented control with attributes set as specified by the parameters.
 */
+(UISegmentedControl *) customSegmentedControl:(CGFloat)x y:(CGFloat) y 
                                         width:(CGFloat) width 
                                        height:(CGFloat)height 
                                         items:(NSArray *)items 
                                         color:(APPLICATION_THEME_COLOR) color;

/**
 * Create a custom action sheet.
 * @param : x               horizontal position of the action sheet.
 * @param : y               vertical position of the action sheet.
 * @param : width           width of the action sheet.
 * @param : height          height of the action sheet.
 * @param : backgroundColor background color of the action sheet.
 * @return A custom action sheet with attributes set as specified by the parameters.
 */
+(UIActionSheet *) customActionSheet:(CGFloat)x y:(CGFloat)y 
                               width:(CGFloat)width 
                              height:(CGFloat)height 
                     backgroundColor:(APPLICATION_THEME_COLOR) color;

/**
 * Get the expected height to use in order to display a text.
 * @param : text        the text to display.
 * @param : textOffSet  value of the offset uses when displaying the text.
 * @return  height ot be used by the text container (uilabel).
 */
+(CGFloat) heightForText:(NSString *) text textOffSet:(float ) offSet;
@end
