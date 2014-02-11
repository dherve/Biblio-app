//
//  LibraryItemsListViewController.m
//  Biblios
//

#import "LibraryItemsListViewController.h"
#import "Db.h"
#import "LibraryItem.h"
#import "LibraryItemsListViewCell.h"
#import "UIStyles.h"
#import "NewLibraryItemViewController.h"
#import "Notifications.h"
@interface LibraryItemsListViewController(PrivateApi)
    -(void) addNewItem;
@end

@implementation LibraryItemsListViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    // set the title
    m_viewTitle = NSLocalizedString(@"Borrowings", @"Borrowings list screen title");
    m_header = [[BaseHeader alloc]initWithFrame:CGRectMake(0, 0,HEADER_WIDTH,
                                                           HEADER_HEIGHT)];
    [m_header setTextContent:NSLocalizedString(@"BORROWED ITEMS", 
                                               @"Title for the list screen of borrowed items")
                     subText:NSLocalizedString(@"List of", 
                                               @"Upper subtitle for the list screen of borrowed items")];
    
    m_sections = [[NSMutableArray alloc] init];
    m_sectionData = [[NSMutableDictionary alloc] init];
     
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:
                             [[[Db sharedDB] getAllLibrariesItems] allValues]];
    
    NSArray *sorteItems;
    sorteItems = [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(LibraryItem *)a returnDate];
        NSDate *second = [(LibraryItem *)b returnDate];
        return [first compare:second];
    }];
    
    [m_sectionData setValue:sorteItems forKey:SECTION_DATA];
    [m_sections addObject:SECTION_DATA];
    
    [super loadView];
    
    m_tableView.separatorColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBarRightButton:NSLocalizedString(@"Add", @"Label for Add button")];
    [m_navBarRightButton addTarget:self action:@selector(addNewItem) forControlEvents:UIControlEventTouchUpInside];
    if([m_sectionData objectForKey:SECTION_DATA] == nil || 
       [[m_sectionData objectForKey:SECTION_DATA] count] == 0){
        [self showMessageForEmptyList:NSLocalizedString(@"NO ITEM BORROWED FOR THE MOMENT", 
                                                        @"Message shown when the item list is empty")];
    }
    else
    {
        [self removeMessageForEmptyList];
    }
    [[Db sharedDB] addDbListener:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[Db sharedDB] removeDbListener:self];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *section  = [m_sections objectAtIndex:indexPath.section];
    LibraryItem *libraryItem = [[[m_sectionData objectForKey:section]objectAtIndex:indexPath.row] retain];
    static NSString *CellIdentifier = @"LibraryItemsListViewCell";
    
     LibraryItemsListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LibraryItemsListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setEditing:YES animated:YES];
    [cell setContentData:libraryItem];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return  nil;  //[m_sections objectAtIndex:section];
}

#pragma mark - private Methods

-(void) addNewItem{

     NewLibraryItemViewController *newItemViewController = 
                            [[NewLibraryItemViewController alloc] init];

     [self.navigationController pushViewController:newItemViewController
                                          animated:YES];
     [newItemViewController release];
   
}

-(void) notifyDbUpdated
{
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:
                             [[[Db sharedDB] getAllLibrariesItems] allValues]];
    
    [m_sectionData removeAllObjects];
    [m_sectionData setValue:items forKey:SECTION_DATA];
    [m_tableView reloadData];
    if([[m_sectionData objectForKey:SECTION_DATA] count] == 0){
        [self showMessageForEmptyList:NSLocalizedString(@"NO ITEM BORROWED FOR THE MOMENT", 
                                                        @"Message shown when the item list is empty")];
    }else{
        [self removeMessageForEmptyList];
    }
}

@end
