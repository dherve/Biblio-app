//
//  BasicListViewController.m
//  Biblios
//

#import "BasicListViewController.h"
#import "UIStyles.h"

@implementation BasicListViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void) dealloc
{
    [m_viewTitle release];
    [m_dataKeys release];
    [m_data release];
    [m_header release];
    [m_navBarLeftButton release];
    [m_navBarRightButton release];
    [m_tableView release];
    [m_emptyListMessageLabel release];
    [super dealloc];
}
#pragma mark - View lifecycle

-(void) loadView{  
    m_tableView= [[UITableView alloc] initWithFrame:
                              [[UIScreen mainScreen] applicationFrame]
                                style:UITableViewStylePlain];
    m_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight| 
                                 UIViewAutoresizingFlexibleWidth;
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    m_tableView.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
    self.view = m_tableView;
    m_emptyListMessageLabel = [UIStyles customLabel:VIEW_LEFT_MARGINS y:APPLICATION_HEIGHT / 3 
                                              width:CUSTOM_CELL_WIDTH 
                                             height:UILABEL_DEFAULT_HEIGHT 
                                               font:CONTENT_FONT];
    m_emptyListMessageLabel.textAlignment = UITextAlignmentCenter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if(m_viewTitle != nil)
//        self.title = m_viewTitle;
    
    if(m_data != nil)
        m_dataKeys = [[NSArray alloc] initWithArray:[m_data allKeys]];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[UIImage imageNamed: @"topbar_bg.png"] 
              forBarMetrics:UIBarMetricsDefault];
    
    m_navBarLeftButton = [[UIBarButtonItem alloc] init];
    m_navBarLeftButton.title = NSLocalizedString(@"Back", @"Label for back button");
    m_navBarLeftButton.tintColor =  [UIStyles getColor:BACKGROUND_UIBAR_COLOR];
    self.navigationItem.backBarButtonItem = m_navBarLeftButton;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [m_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
