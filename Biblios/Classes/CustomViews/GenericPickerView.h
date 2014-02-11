//
//  GenericPickerView.h
//  Biblios
//
//  Generic pickerview used to show a list of values avalaible
//  for a specific input field.
//

#import <UIKit/UIKit.h>

// Picker view types
typedef enum
{
    LIBRARY_ITEM_TYPE_PICKER = 1,
    DATE_PICKER              = 2,
    LIBRARY_NAME_PICKER      = 3,
    LIBRARY_ITEM_REMINDER    = 4,
    LIBRARY_ITEM_LANGUAGE    = 5,
    LIBRARY_ITEM_CATEGORY    = 6
}PICKER_VIEW_TYPE;

@interface GenericPickerView : UIView <UIPickerViewDelegate>
{
    PICKER_VIEW_TYPE m_pickerType;
    
    // Values of text to be displayed in the picker.
    NSArray          *m_pickerValues;
    
    // Since UIPickerView and UIDatePicker have different behaviors, we need
    // the two component.
    UIPickerView     *m_pickerView;
    UIDatePicker     *m_datePicker;
    
    // String representation of the selected value
    NSString         *m_selectedValue;
    
    // Index of the value selected in the picker view. This index is use when
    // the current picket is not a date picker. In that case the value of the 
    // index is either the id of the library or the value of the enum type
    // corresponding to the text currently selected in the pickerview.
    int              m_selectedValueIndex;
    
}
@property (nonatomic) PICKER_VIEW_TYPE type;

/**
 * Create a new picker view
 * @param : pickerViewType, type of the picker to create and show
 */
-(id) initWithType:(PICKER_VIEW_TYPE) pickerViewType;

/**
 * @return : the current value selected in the picker view.
 */
-(NSString *) selectedValue;

/**
 * @return : the index of the selected value.
 */
-(int) selectedValueIndex;
@end
