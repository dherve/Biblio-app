//
//  SearchViewController.h
//  Biblios
//

#import <UIKit/UIKit.h>
#import "SectionedListViewController.h"
#import "GenericPickerView.h"
#import "LibraryItem.h"

// Search fields types.
typedef enum
{
    FIELD_ITEM_TITLE         = 0,
    FIELD_ITEM_AUTOR         = 1,
    FIELD_ITEM_CATEGORY      = 2,
    FIELD_ITEM_LANGUAGE      = 3,  
    FIELD_BUTTON             = 4
}FIELD_ROW_INDEX;

@interface SearchViewController : SectionedListViewController
<UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDelegate>
{
    // Field that is being currently edited.
    UITextField             *m_activeField;
    
    // Action sheet to display the pickerview.
    UIActionSheet           *m_actionSheet;
    
    // Pickerview to show different values available for a field being edited.
    GenericPickerView       *m_pickerView;
    UIButton                *m_searchButton;
    NSMutableDictionary     *m_searchTerms;
}

@end
