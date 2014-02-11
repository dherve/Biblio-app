//
//  BiblioAppDelegate.m
//  Biblios
//

#import "BiblioAppDelegate.h"
#import "LibrariesListViewController.h"
#import "LibraryItemsListViewController.h"
#import "SearchViewController.h"
#import "AboutVIewController.h"
#import "UIStyles.h"
@interface BiblioAppDelegate(PrivateAPI)
    // Initialize the UI of the application (the tabbed navigation bar and 
    // the viewcontrollers corresponding to each tabitem.
    -(void) initUI;
@end

@implementation BiblioAppDelegate
@synthesize window = m_window;
@synthesize tabBarController = m_tabBarController;
@synthesize navigationController = m_navigationController;
@synthesize imageView = m_imageView;

- (void)dealloc
{
    [m_viewControllers release];
    [m_tabBarController release];
    [m_window release];
    [m_imageView release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
    // load data here

    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - UITabBarController Delegate methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // Load the image specific to the selected tab.
    NSUInteger index=[[tabBarController viewControllers] indexOfObject:viewController];
    switch (index) {
        case 0:
            self.tabBarController.tabBar.selectionIndicatorImage = 
                            [UIImage imageNamed:@"libraries_selected_img.png"];
            break;
        case 1:
            self.tabBarController.tabBar.selectionIndicatorImage = 
                            [UIImage imageNamed:@"borrowings_selected_img.png"];
            break;
        case 2:
            self.tabBarController.tabBar.selectionIndicatorImage = 
                            [UIImage imageNamed:@"search_selected_img.png"];
            break;
        case 3:
            self.tabBarController.tabBar.selectionIndicatorImage = 
                            [UIImage imageNamed:@"about_selected_img.png"];
            break;

            break;
        default:
            break;
    }
    return YES;    
}

#pragma mark - private methods
-(void)initUI
{
    
    m_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    m_tabBarController = [[UITabBarController alloc] init];
    m_viewControllers = [[NSMutableArray alloc] init];
    
    // Creation of the viewcontrollers for each tab
    UINavigationController *localNavigationController;
    
    LibrariesListViewController *librariesViewController = [[LibrariesListViewController alloc] init];
    localNavigationController = [[UINavigationController alloc] 
                                 initWithRootViewController:librariesViewController];
    [LibrariesListViewController release];
    [m_viewControllers addObject:localNavigationController];
    [localNavigationController release];
    
    LibraryItemsListViewController *librariesItemsViewController = [[LibraryItemsListViewController alloc] init];
    localNavigationController = [[UINavigationController alloc] 
                                 initWithRootViewController:librariesItemsViewController];
    [librariesItemsViewController release];
    [m_viewControllers addObject:localNavigationController];
    [localNavigationController release];
    
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    localNavigationController = [[UINavigationController alloc] 
                                 initWithRootViewController:searchViewController];
    [searchViewController release];
    [m_viewControllers addObject:localNavigationController];
    [localNavigationController release];    
    
    
    AboutVIewController *aboutViewController =  [[AboutVIewController alloc] init];
    localNavigationController = [[UINavigationController alloc] 
                                 initWithRootViewController:aboutViewController];
    [aboutViewController release];
    [m_viewControllers addObject:localNavigationController];
    [localNavigationController release];

    
    m_tabBarController.viewControllers = m_viewControllers;
    m_tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_no_selection.png"];
    self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"libraries_selected_img.png"];
    
    self.tabBarController.delegate=self;
    self.tabBarController.selectedIndex=0;

    
    [self.window addSubview:m_tabBarController.view];
    [self.window makeKeyAndVisible];
    
}

@end
