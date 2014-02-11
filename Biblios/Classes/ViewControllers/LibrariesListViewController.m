//
//  LibrariesListViewController.m
//  Biblios
//

#import "LibrariesListViewController.h"
#import "Db.h"
#import "LibraryDetailsViewController.h"
#import "UIStyles.h"
#import "LibrariesListViewCell.h"
#import "Notifications.h"
#import "AppInitializer.h"
#import "ErrorDialogHandler.h"
@interface LibrariesListViewController(PrivateAPI)
    -(void) handleDataLoadingSuccessNotification;
    -(void) handleDataLoadingFailureNotification;
@end

@implementation LibrariesListViewController
-(id) init
{
    self = [super init];
    if(self){
        m_activityIndicatorView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                    UIActivityIndicatorViewStyleGray] retain];
        m_activityIndicatorView.center = CGPointMake(APPLICATION_WIDTH/2, APPLICATION_HEIGHT/3);
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // set the title
    m_viewTitle = NSLocalizedString(@"Libraries", @"Libraries list screen title");
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register to the deafautl center so when can be notified when the data
    // has been loaded successfully or not.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDataLoadingSuccessNotification) 
                                                 name:LIBRARY_LIST_LOADING_COMPLETED 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDataLoadingFailureNotification) 
                                                 name:LIBRARY_LIST_LOADING_FAILED 
                                               object:nil];
    // Load data, if not done yet.
    if(m_data == nil)
    {
        [self.view addSubview:m_activityIndicatorView];
        [m_activityIndicatorView startAnimating];
        [AppInitializer loadAppData];  
    }
}


- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc
{
    [m_activityIndicatorView release];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LibrariesListViewCell";    
    LibrariesListViewCell *cell = (LibrariesListViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LibrariesListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *key = [m_dataKeys objectAtIndex:indexPath.row];
    Library  *library = [m_data objectForKey:key];
    [cell setContentData:library];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [m_dataKeys objectAtIndex:indexPath.row];
    Library  *library = [m_data objectForKey:key];
    LibraryDetailsViewController *libraryDetailViewController = [[LibraryDetailsViewController alloc] initWithLibrary:library];
    [self.navigationController pushViewController:libraryDetailViewController animated:YES];
    [libraryDetailViewController release];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

#pragma mark - data loadind methods delegate
-(void) handleDataLoadingSuccessNotification
{
    // Set the data containers
    m_data = [[NSMutableDictionary alloc]initWithDictionary: [[Db sharedDB] getAllLibraries]];
    m_dataKeys = [[NSArray alloc] initWithArray:[m_data allKeys]];
    
    // Remove the activity indicator and the message for empyt list
    [m_activityIndicatorView removeFromSuperview];
    [self removeMessageForEmptyList];
    
    // 
    [m_tableView reloadData];
}

-(void) handleDataLoadingFailureNotification
{
    [m_activityIndicatorView removeFromSuperview];
    [ErrorDialogHandler showDialogForErrorMessage:@"FAILED TO LOAD LIBRARY DATA"];
    [self showMessageForEmptyList:NSLocalizedString(@"NO LIBRARIES FOUND", @"Message shown when the list of libraries is empty")];
}

@end
