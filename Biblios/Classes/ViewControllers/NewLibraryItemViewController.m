//
//  NewLibraryItemViewController.m
//  Biblios
//

#import "NewLibraryItemViewController.h"
#import "UIStyles.h"
#import "InputTextCell.h"
#import "Db.h"
#import "Utilis.h"
@interface NewLibraryItemViewController(PrivateAPI)

    /**
     * Scroll the table view in order to show a specific field.
     * @param : textField the textfield to show
     */
    -(void) scrollToField:(UITextField *) textField;

    // Scroll back the table to the original position.
    -(void) scrollTableViewTodefaultPosition;

    // Add the item to the database.
    -(void) addItem;

    // Cancel item add action and pop the current viewcontroller
    -(void) cancel;

    /**
     * Display a pickerView.
     * @param : pickerViewType the type of the pickerView to show.
     */
    -(void) showPickerView:(PICKER_VIEW_TYPE) pickerViewType;

    // Dismiss picket view.
    -(void) dismissPickerView;

    /**
     * validate the value of an 
     * @param  : fieldRowIndex the index of the field (the enclosing cell) 
     *           in the tableview.
     * @return : Yes if the value is valid, NO otherwise.
     */
    -(BOOL) validateFieldValue:(FIELD_ROW_INDEX) fieldRowIndex;

    /**
     * Get the cell enclosing a field.
     * @param  : fieldRowIndex the index of the field (the cell) in the tableview.
     * @return : the enclosing cell.
     */
    -(InputTextCell *) fieldEnclosingCell:(FIELD_ROW_INDEX)fieldRowIndex;
    
@end

@implementation NewLibraryItemViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
    [super dealloc];
    [m_activeField release];
    [m_actionSheet release];
    [m_pickerView release];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    m_viewTitle = NSLocalizedString(@"NEW BORROWING", @"Borrowings screen title");
    m_header = [[BaseHeader alloc]initWithFrame:CGRectMake(0, 0,HEADER_WIDTH,
                                                           HEADER_HEIGHT)];
    [m_header setTextContent:NSLocalizedString(@"New borrowed item", 
                                               @"Title for the screen to add a new item")
                     subText:NSLocalizedString(@"Add", 
                                               @"Text for the screen to add a new item")];
    
    m_itemToAdd = [[LibraryItem alloc] init];
    
    m_sections = [[NSMutableArray alloc] init];
    m_sectionData = [[NSMutableDictionary alloc] init];
    
    // Set the input fields with the corresponding titles.
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    [fields addObject:[NSArray arrayWithObjects: @"InputTextCell", 
                       NSLocalizedString(@"ITEM TITLE",@"Title of the item to add"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: @"InputTextCell", 
                       NSLocalizedString(@"ITEM TYPE",@"Type of the item to add"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: @"InputTextCell", 
                       NSLocalizedString(@"RETURN DATE",@"Date on which the item is to be returned"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: @"InputTextCell", 
                       NSLocalizedString(@"LIBRARY FROM",@"Libray where the item is from"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: @"InputTextCell", 
                       NSLocalizedString(@"REMINDER ",@"Remider time"),
                       nil]];

    [m_sectionData setValue:fields forKey:SECTION_DATA];
    [m_sections addObject:SECTION_DATA];
    
    [super loadView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBarRightButton:NSLocalizedString(@"Done", @"Label for back button")];
    [self initNavigationBarLeftButton:NSLocalizedString(@"Cancel", @"Label for cancel button")];
    [m_navBarRightButton addTarget:self action:@selector(addItem) forControlEvents:UIControlEventTouchUpInside];
    [m_navBarLeftButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self registerForKeyboardNotifications];
}


- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"InputTextCell";
    InputTextCell *cell;
    NSString *section = [m_sections objectAtIndex:indexPath.section];
    NSMutableArray *sectionData = [m_sectionData objectForKey:section];
    if([section isEqualToString:SECTION_DATA])
    {
        NSUInteger row = indexPath.row;
        NSArray *cellData  = [sectionData objectAtIndex:row];
        cellIdentifier = [cellData objectAtIndex: 0];
        NSString *label = [cellData objectAtIndex:1];
        
        cell = (InputTextCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[InputTextCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                              reuseIdentifier:cellIdentifier] autorelease];
        } 
        
        NSString *currentText = [[cell inputTextLabel] text];
        
        // Set the text if it not already set.
        if(currentText == nil)
        {
            [[cell inputTextLabel] setText:label];
        }
        
        [[cell inputTextField] setDelegate:self]; 
        [[cell inputTextField] setTag:row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return INPUT_CELL_HEIGHT;
}


#pragma mark - TextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    m_activeField = textField;
    if(textField.tag != FIELD_ITEM_TITLE)
    {
        [self showPickerView:LIBRARY_NAME_PICKER];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    m_activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *inputText = [textField text];
    if(textField.tag == FIELD_ITEM_TITLE && 
       [self validateFieldValue:FIELD_ITEM_TITLE])
    {
            m_itemToAdd.title = inputText;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    m_activeField.text = [textField text];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - TableView scrolling methods
-(void) scrollToField:(UITextField *) textField
{

    // 
    CGSize hiddenAreaSize = CGSizeMake(APPLICATION_WIDTH, UIPICKER_DEFAULT_HEIGHT);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, hiddenAreaSize.height, 0.0);
    m_tableView.contentInset = contentInsets;
    m_tableView.scrollIndicatorInsets = contentInsets;

    float visibleZoneHeight = APPLICATION_HEIGHT - (UIPICKER_DEFAULT_HEIGHT + INPUT_CELL_HEIGHT);
    CGRect visibleZone = CGRectMake(0, 0, APPLICATION_WIDTH, 
                                    visibleZoneHeight - hiddenAreaSize.height); 
    
    // The cell enclosing the current field.
    UITableViewCell *textFieldCell =  (UITableViewCell *) [textField superview];
    CGFloat originY = textFieldCell.frame.origin.y;
    
    // Is the enclosing cell in the visble area
    if (!CGRectContainsPoint(visibleZone, textFieldCell.frame.origin) ) 
    {
        
        // Find to which position we need ot scroll the view, in order to show 
        // the current text field. For aesthetic reason we want the bottom
        // line separator of the current cell to match the top edge of the
        // hidding area.
        CGFloat newY = (originY-hiddenAreaSize.height) + (INPUT_CELL_HEIGHT *2) 
                        - CELL_PADDING_BOTTOM/2;
        
        // If the new 
        if(newY  > 0)
        {
            CGPoint scrollPoint = CGPointMake(0.0, newY);
            
            // sezame, sezame avance :) !
            [m_tableView setContentOffset:scrollPoint animated:YES];
            
            // change the background color of the cell so the user knows which
            // cell is being edited.
            
        }
    }
}

-(void) scrollTableViewTodefaultPosition
{
    [m_tableView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

#pragma mark - pickerView handling methods
-(void) showPickerView:(PICKER_VIEW_TYPE) pickerViewType
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    m_actionSheet = [UIStyles customActionSheet:x y:y width:APPLICATION_WIDTH 
                                         height:485 
                                backgroundColor:BACKGROUND_UIBAR_COLOR];
    [m_actionSheet setDelegate:self];
    
    CGRect frame = CGRectMake(x, y, APPLICATION_WIDTH, 485);

    // Add the picker view
    m_pickerView = [[GenericPickerView alloc]initWithType:m_activeField.tag];
    [m_actionSheet addSubview:m_pickerView];
    
    // Set  the position coordinates of the button "Cancel"
    x = CELL_PADDING_LEFT;
    y = (CELL_PADDING_TOP / 2) + 1;

    // Cancel button
    UISegmentedControl *cancelButton = [UIStyles customSegmentedControl:x y:y 
                                        width:UIBUTTON_DEFAULT_WIDTH 
                                        height:UIBUTTON_DEFAULT_HEGIHT 
                                        items:[NSArray arrayWithObject:@"Cancel"]
                                        color:BACKGROUND_UIBAR_COLOR];
    
    // Set the targe and action
    [cancelButton addTarget:self action:@selector(dismissPickerView) 
           forControlEvents:UIControlEventValueChanged];
    
    // The button done is on the right side.
    x = APPLICATION_WIDTH - CELL_PADDING_RIGHT - UIBUTTON_DEFAULT_WIDTH;
    UISegmentedControl *doneButton = [UIStyles customSegmentedControl:x y:y 
                                        width:UIBUTTON_DEFAULT_WIDTH 
                                        height:UIBUTTON_DEFAULT_HEGIHT 
                                        items:[NSArray arrayWithObject:@"Done"]
                                        color:BACKGROUND_UIBAR_COLOR];

    // Set the target and action
    [doneButton addTarget:self action:@selector(dismissPickerView) 
         forControlEvents:UIControlEventValueChanged];
    
    // Add buttons to the view
    [m_actionSheet addSubview:doneButton];   
    [doneButton release];
    
    [m_actionSheet addSubview:cancelButton];
    [cancelButton release];
    
    [m_actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [m_actionSheet setBounds:frame];
}

-(void) dismissPickerView
{
    [m_actionSheet dismissWithClickedButtonIndex:0 animated:YES]; 
    int pickerType = m_pickerView.type;
    
    // Retrieve the selected value in the pickerview.
    switch (pickerType) 
    {
        case LIBRARY_ITEM_TYPE_PICKER:
            m_itemToAdd.type = m_pickerView.selectedValueIndex;
            break;
            
        case DATE_PICKER:
            m_itemToAdd.returnDate = [Utilis dateFromString:m_pickerView.selectedValue 
                                               withFormat:DATE_DEFAULT_FORMAT];
            break;
        case LIBRARY_NAME_PICKER:
            m_itemToAdd.libraryId = [NSNumber numberWithInt:
                                     m_pickerView.selectedValueIndex];
            break;
        case LIBRARY_ITEM_REMINDER:
            m_itemToAdd.reminderTime = m_pickerView.selectedValueIndex;
            break;
    }
    
    // If any field has an error, remove the error mark.
    [[self fieldEnclosingCell:pickerType]clearErrorMark];
}

#pragma mark - action sheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Retrieve the value
    m_activeField.text = [m_pickerView selectedValue];
    if(m_activeField.tag == FIELD_ITEM_REMINDER_DATE)
    {
        [self scrollTableViewTodefaultPosition];
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    [self scrollToField:m_activeField];
}


-(void) addItem{

    int fieldsWithError = 0;
    
    // Check all input fields values.
    for (int fieldIndex = FIELD_ITEM_TITLE;  fieldIndex < 5 ; fieldIndex ++) {
        if([self validateFieldValue:fieldIndex] == NO)
        {
            fieldsWithError ++;
        }
    }
    
    // No error found then the item can be added.
    if(fieldsWithError == 0)
    {
        m_itemToAdd.itemID = [NSNumber numberWithInt:[[Db sharedDB]nextItemID]];
        [[Db sharedDB] addLibrayItem:m_itemToAdd];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void) cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - input fields validattion
-(BOOL) validateFieldValue:(FIELD_ROW_INDEX) fieldRowIndex
{
    // Get the enclosing cell
    InputTextCell *cell = [self fieldEnclosingCell:fieldRowIndex];
    
    // Get the field value
    NSString *fieldValue = [[cell inputTextField] text];
    
    // Remove white space
    fieldValue = [fieldValue stringByReplacingOccurrencesOfString:BLANK_TEXT 
                                                       withString:@""];
    
    // Check the value
    if(fieldValue == nil || fieldValue.length < INPUT_FIELD_MIN_VALUE)
    {
        [cell markForError];
        return NO;
    }
    if([cell hasError])
    {
        [cell clearErrorMark];
    }
    return YES;
}

-(InputTextCell *) fieldEnclosingCell:(FIELD_ROW_INDEX)fieldRowIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:fieldRowIndex 
                                                inSection:0];
    return (InputTextCell *) [m_tableView cellForRowAtIndexPath:indexPath];
}

@end
