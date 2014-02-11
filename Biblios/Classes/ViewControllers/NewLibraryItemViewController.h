//
//  NewLibraryItemViewController.h
//  Biblios
//
//  Allow to add a new item.
//

#import <UIKit/UIKit.h>
#import "SectionedListViewController.h"
#import "LibraryItem.h"
#import "GenericPickerView.h"

// Input fields types.
typedef enum
{
    FIELD_ITEM_TITLE         = 0,
    FIELD_ITEM_CATEGORY      = 1,
    FIELD_ITEM_RETURN_DATE   = 2,
    FIELD_ITEM_LIBRARY       = 3,
    FIELD_ITEM_REMINDER_DATE = 4
    
}FIELD_ROW_INDEX;

// Input cell types.
typedef enum
{
    INTPUT_CELL   = 1,
    PICKLIST_CELL = 2
}CELL_TYPE;

@interface NewLibraryItemViewController : SectionedListViewController
    <UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDelegate>
{
    LibraryItem         *m_itemToAdd;
    UITextField         *m_activeField;
    UIActionSheet       *m_actionSheet;
    GenericPickerView   *m_pickerView;
    
}
@end
