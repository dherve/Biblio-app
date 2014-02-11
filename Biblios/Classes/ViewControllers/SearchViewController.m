//
//  SearchViewController.m
//  Biblios
//

#import "SearchViewController.h"
#import "UIStyles.h"
#import "InputTextCell.h"
#import "ButtonCell.h"
#import "SearchWebViewController.h"
#import "Utilis.h"
#import "DataHelper.h"

#define INPUT_TEXT_CELL_IDENTIFIER      @"InputTextCell"
#define BUTTON_CELL_IDENTIFIER          @"ButtonCell"

#define URL_ITEM_SEARCH         @"http://nelligan.ville.montreal.qc.ca/search%@/X?SEARCH=(%@)&SORT=D&l=%@&m=%@"

#define ITEM_TITLE          @"TITLE"
#define ITEM_AUTHOR         @"AUTHOR"
#define ITEM_LANGUAGE       @"LANGUAGE"
#define ITEM_TYPE           @"TYPE"
#define ITEM_CATEGORY       @"ITEM_CATEGORY"



@interface SearchViewController(PrivateAPI)

    /**
     * Scroll the table view in order to show a specific field.
     * @param : textField the textfield to show
     */
    -(void) scrollToField:(UITextField *) textField;

    // Scroll back the table to the original position.
    -(void) scrollTableViewTodefaultPosition;

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

    
    /**
     * Show the view the search for the item to search
     */
    -(void) searchForItem;

@end



@implementation SearchViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void) loadView
{
    m_viewTitle = NSLocalizedString(@"Search", @"Search screen title");
    m_header = [[BaseHeader alloc]initWithFrame:CGRectMake(0, 0,HEADER_WIDTH,
                                                           HEADER_HEIGHT)];
    [m_header setTextContent:NSLocalizedString(@"SEARCH", 
                                               @"Title for the screen to search for item")
                     subText:NSLocalizedString(@"item", 
                                               @"Text for the screen to add a new item")];
        
    m_sections = [[NSMutableArray alloc] init];
    m_sectionData = [[NSMutableDictionary alloc] init];
    m_searchTerms = [[NSMutableDictionary alloc] init];
    
    // Set the fields
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    [fields addObject:[NSArray arrayWithObjects: INPUT_TEXT_CELL_IDENTIFIER, 
                       NSLocalizedString(@"TITLE",@"Title of the item to add"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: INPUT_TEXT_CELL_IDENTIFIER, 
                       NSLocalizedString(@"AUTOR",@"Type of the item to add"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: INPUT_TEXT_CELL_IDENTIFIER, 
                       NSLocalizedString(@"TYPE",@"Date on which the item is to be returned"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: INPUT_TEXT_CELL_IDENTIFIER, 
                       NSLocalizedString(@"LANGUAGE",@"Libray where the item is from"),
                       nil]];
    [fields addObject:[NSArray arrayWithObjects: BUTTON_CELL_IDENTIFIER, 
                       NSLocalizedString(@"Search",@"Label of the button to show"),
                       nil]];
    
    [m_sectionData setValue:fields forKey:SECTION_DATA];
    [m_sections addObject:SECTION_DATA];
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"InputTextCell";
    id cell;
    NSString *section = [m_sections objectAtIndex:indexPath.section];
    NSMutableArray *sectionData = [m_sectionData objectForKey:section];
    if([section isEqualToString:SECTION_DATA])
    {
        NSUInteger row = indexPath.row;
        NSArray *cellData  = [sectionData objectAtIndex:row];
        cellIdentifier = [cellData objectAtIndex: 0];
        NSString *label = [cellData objectAtIndex:1];
        
        if([cellIdentifier isEqualToString:INPUT_TEXT_CELL_IDENTIFIER]){
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
        else if([cellIdentifier isEqualToString:BUTTON_CELL_IDENTIFIER])
        {
            cell = (ButtonCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[[ButtonCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                             reuseIdentifier:cellIdentifier] autorelease];
            }  
            [[cell button] setTitle:label forState:UIControlStateNormal];
            [[cell button] addTarget:self action:@selector(searchForItem) 
                    forControlEvents:UIControlEventTouchUpInside]; 

        }
        
        
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
    switch (textField.tag) {
        case FIELD_ITEM_TITLE:
        case FIELD_ITEM_AUTOR:
            return YES;
        case FIELD_ITEM_CATEGORY:
            [self showPickerView:LIBRARY_ITEM_CATEGORY];
            break;
        case FIELD_ITEM_LANGUAGE:
            [self showPickerView:LIBRARY_ITEM_LANGUAGE];
            break;
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    m_activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *inputText = [textField text];
    FIELD_ROW_INDEX fieldIndex = textField.tag;
    if([self validateFieldValue:fieldIndex])
    {
        switch (fieldIndex) {
            case FIELD_ITEM_TITLE:
                [m_searchTerms setObject:inputText forKey:ITEM_TITLE];
                break;
            case FIELD_ITEM_AUTOR:
                [m_searchTerms setObject:inputText forKey:ITEM_AUTHOR];
                break;
            default:
                break;
        }
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
    m_pickerView = [[GenericPickerView alloc]initWithType:pickerViewType];
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
    NSNumber *index = [NSNumber numberWithInt:[m_pickerView selectedValueIndex]];
    switch (pickerType) 
    {
        case LIBRARY_ITEM_CATEGORY:
            [m_searchTerms setObject:index forKey:ITEM_CATEGORY];
            break;
        case LIBRARY_ITEM_LANGUAGE:
            [m_searchTerms setObject:index forKey:ITEM_LANGUAGE];
            
            // setObject:inputText forKey:ITEM_AUTHOR];
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
    if(m_activeField.tag == FIELD_ITEM_LANGUAGE)
    {
        [self scrollTableViewTodefaultPosition];
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    [self scrollToField:m_activeField];
}


#pragma mark - input fields validattion
-(BOOL) validateFieldValue:(FIELD_ROW_INDEX) fieldRowIndex
{    
    if(fieldRowIndex == FIELD_BUTTON)
        return YES;
    
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

#pragma mark - search method

// this need to be well refactored
-(void) searchForItem
{

    // Either the title or the author must be set
    if ([self validateFieldValue:FIELD_ITEM_TITLE] || [self validateFieldValue:FIELD_ITEM_AUTOR]) {
        
        // Retrieve search parameters.
        NSString *title  = [m_searchTerms objectForKey:ITEM_TITLE];
        NSString *author = [m_searchTerms objectForKey:ITEM_AUTHOR];
        
        // Since the title or the author can be nil, we must use the one 
        // that is not nil in the search request.
        NSString *param = title == nil ? author : title;
        param = [param  stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSNumber *lanquageIndex = [m_searchTerms objectForKey:ITEM_LANGUAGE];
        NSNumber *categoryIndex = [m_searchTerms objectForKey:ITEM_CATEGORY];
        
        // Item edition language.
        NSString *lang = [DataHelper itemLanguageCode:lanquageIndex.intValue];
        
        // Item category.
        NSString *cat = [DataHelper itemCategoryCode:categoryIndex.intValue]; 
        
        // User language
        NSString *usrLang = @"";
        
        // Set the search language to the user language.
        if([[Utilis userLanguage] isEqualToString:@"fr"])
        {
            usrLang = @"*frc";
        }
        
        // Format the request with the specified parameters.
        NSString *url = [NSString stringWithFormat:URL_ITEM_SEARCH, usrLang, param,[lang lowercaseString] ,[cat lowercaseString]];

        NSLog(@"URL REQUEST => %@", url);
        SearchWebViewController *searchWebViewController = [[SearchWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:searchWebViewController animated:YES];
        [searchWebViewController release]; 
    }
}

@end
