//
//  GenericPickerView.m
//  Biblios
//

#import "GenericPickerView.h"
#import "UIStyles.h"
#import "Utilis.h"
#import "DataHelper.h"
#import "Db.h"
@implementation GenericPickerView
@synthesize type = m_pickerType;
-(id) initWithType:(PICKER_VIEW_TYPE) pickerViewType
{
    m_pickerType = pickerViewType;
    CGRect frame = CGRectMake(0, CELL_PADDING_TOP*2, 
                              APPLICATION_WIDTH, UIPICKER_DEFAULT_HEIGHT);
    self = [super initWithFrame:frame];
    if(self != nil)
    {
        if(pickerViewType == DATE_PICKER)
        {
            m_datePicker= [[UIDatePicker alloc] initWithFrame:frame];
            m_datePicker.datePickerMode = UIDatePickerModeDate;
            m_selectedValue = [Utilis dateToString:m_datePicker.date 
                                        withFormat:DATE_DEFAULT_FORMAT];
            [self addSubview:m_datePicker];
        }
        else
        {
            // Load the corresponding values.
            switch (pickerViewType) 
            {
                case LIBRARY_NAME_PICKER :
                    m_pickerValues = [[[Db sharedDB] getLibrariesNames] retain]; 
                    break;
                    
                case LIBRARY_ITEM_REMINDER:
                    m_pickerValues = [[DataHelper reminderDateValues] retain];
                    break;
                    
                case LIBRARY_ITEM_TYPE_PICKER:
                    m_pickerValues = [[DataHelper itemTypeValues] retain];
                    break;
                    
                case LIBRARY_ITEM_LANGUAGE:
                    m_pickerValues = [[DataHelper itemLanguageValues] retain];
                    break;
                    
                case LIBRARY_ITEM_CATEGORY:
                    m_pickerValues = [[DataHelper itemCategoriesValues] retain];
                    break;
                    
                default:
                    break;
            }
            
            // By default the item in the middle is selected, so the picker view
            // can look "balanced"
            
            m_selectedValueIndex = (m_pickerType == LIBRARY_ITEM_LANGUAGE) ? 
                                    0:[m_pickerValues count] / 2;
            m_selectedValue = [m_pickerValues objectAtIndex:m_selectedValueIndex];
            m_pickerView = [[UIPickerView alloc] initWithFrame:frame];
            m_pickerView.delegate = self;
            m_pickerView.showsSelectionIndicator = YES;
            [m_pickerView selectRow:m_selectedValueIndex inComponent:0 animated:NO];
            [self addSubview:m_pickerView];            
        }
    }
    return self;    
}

-(void)dealloc
{
    [m_pickerValues release];
    [m_selectedValue release];  
    if(m_pickerType  == DATE_PICKER)
        [m_datePicker release];
    else
        [m_pickerView release];
}

-(NSString *) selectedValue
{
    if(m_pickerType == DATE_PICKER) {
        
        NSDate *date = m_datePicker.date;
        
        m_selectedValue = [ Utilis dateToString:date withFormat:DATE_DEFAULT_FORMAT];
    }
    return m_selectedValue;
}

-(int) selectedValueIndex
{
    return m_selectedValueIndex;
}

#pragma mark - picker view delegate methods.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(m_pickerType != DATE_PICKER) {
        m_selectedValueIndex = row;
        m_selectedValue = [m_pickerValues objectAtIndex:row];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {    
    return [m_pickerValues count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [m_pickerValues objectAtIndex:row];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return APPLICATION_WIDTH - (VIEW_LEFT_MARGINS + VIEW_RIGHT_MARGINS);
}
@end
