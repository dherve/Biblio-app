//
//  InputTableViewCell.h
//  Biblios
//
//  Custom cell used to display input fields in a tableview 
//  (Here search item and add item viewcontrollers).
//

#import <UIKit/UIKit.h>
@interface InputTextCell : UITableViewCell
{
    // The cell's input text field.
    UITextField *m_inputTextField;
    
    // The label to display next to the input text field.
    UILabel     *m_textLabel;
    
    // Flag indicating whether or not the label should be shown.
    BOOL        m_labelVisible;
    
    // Flag indicating whether there is an error for the current textfield input.
    BOOL        m_hasError;
}
@property (nonatomic, retain) UITextField *inputTextField;
@property (nonatomic, retain) UILabel     *inputTextLabel;

/**
 * @return : YES if the inputfield value is invalid, NO otherwise.
 */
-(BOOL) hasError;

/**
 * Mark the cell with an asterix when the input value is invalid.
 */
-(void) markForError;

/**
 * Clear the error mark.
 */
-(void) clearErrorMark;
@end
