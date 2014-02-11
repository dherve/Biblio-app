//
//  SectionedListViewController.m
//  Biblios
//

#import "SectionedListViewController.h"
#import "UIStyles.h"

@implementation SectionedListViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
    [m_viewTitle release];
    [m_sections release];
    [m_sectionData release];
    [m_header release];  
    [m_backButton release];
    [m_navBarLeftButton release];
    [m_navBarRightButton release];
    [m_tableView release];
    [m_notificationInfos release];
    [m_emptyListMessageLabel release];
    [super dealloc];
}

#pragma mark - View lifecycle

-(void) loadView{  
    
    // Main tableview to display data
    m_tableView = [[UITableView alloc] initWithFrame:
                    CGRectMake(CELL_PADDING_LEFT, 0, TABLEVIEW_DEFAULT_WIDTH, 
                               TABLEVIEW_DEFAULT_HEIGHT)
                    style:UITableViewStyleGrouped];
    
    // Set the background.
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    view.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
    
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    m_tableView.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
    [m_tableView reloadData];
    
    if(m_header != nil)
    {
        m_tableView.tableHeaderView = m_header;
    }
   // self.view = tableView;
    [view addSubview:m_tableView];
    self.view = view;
    
    m_emptyListMessageLabel = [UIStyles customLabel:VIEW_LEFT_MARGINS y:APPLICATION_HEIGHT / 3 
                                              width:CUSTOM_CELL_WIDTH 
                                             height:UILABEL_DEFAULT_HEIGHT 
                                               font:CONTENT_FONT];
    m_emptyListMessageLabel.textAlignment = UITextAlignmentCenter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[UIImage imageNamed: IMG_NAVIGATION_BAR_BG] 
              forBarMetrics:UIBarMetricsDefault];

    // Set navigation bar buttons
    m_backButton = [[UIBarButtonItem alloc] init];
    m_backButton.title = NSLocalizedString(@"Back", @"Label for back button");
    m_backButton.tintColor =  [UIStyles getColor:BACKGROUND_UIBAR_COLOR];
    self.navigationItem.backBarButtonItem = m_backButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[m_sectionData objectForKey:[m_sections objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark navigation bar methods
// Used to set navigation bar right button
- (void) initNavigationBarRightButton:(NSString *) title
{
    CGFloat x = APPLICATION_WIDTH - UIBUTTON_DEFAULT_WIDTH - (VIEW_RIGHT_MARGINS/4);
    CGFloat y = VIEW_TOP_MARGINS /2;
    m_navBarRightButton = [UIStyles defaultCustomButton:x y:y 
                                                  width:UIBUTTON_DEFAULT_WIDTH 
                                                 height:UIBUTTON_DEFAULT_HEGIHT];
    
    [m_navBarRightButton setTitle: title forState:UIControlStateNormal];    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:m_navBarRightButton];
}

// Used to set navigation bar left button
- (void) initNavigationBarLeftButton:(NSString *) title
{    
    CGFloat x = VIEW_RIGHT_MARGINS/4;
    CGFloat y = VIEW_TOP_MARGINS /2;
    m_navBarLeftButton = [UIStyles defaultCustomButton:x y:y 
                                                  width:UIBUTTON_DEFAULT_WIDTH 
                                                 height:UIBUTTON_DEFAULT_HEGIHT];
    [m_navBarLeftButton setTitle: title forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:m_navBarLeftButton];
    self.navigationItem.hidesBackButton = TRUE;
}

#pragma mark - keyboard registration method
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // No implementation, it is up to subclasses registered for keyboard
    // notifications to provide custom implementations.
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // No implementation, it is up to subclasses registered for keyboard
    // notifications to provide custom implementations.
}

#pragma mark - empty list message handling methods
- (void)showMessageForEmptyList:(NSString *) message
{
    [m_emptyListMessageLabel setText:message];
    [m_tableView addSubview:m_emptyListMessageLabel];
}

- (void)removeMessageForEmptyList
{
    if(!m_emptyListMessageLabel.isHidden)
        [m_emptyListMessageLabel removeFromSuperview];
}
@end
