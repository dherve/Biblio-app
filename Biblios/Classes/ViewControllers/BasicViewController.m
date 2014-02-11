//
//  BasicViewController.m
//  Biblios
//

#import "BasicViewController.h"
#import "UIStyles.h"
@implementation BasicViewController
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
    [m_viewTitle release];
    [m_header release];
    [m_view release];
    [super dealloc];
}
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    m_view= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    m_view.backgroundColor = [UIStyles getColor:BACKGROUND_LIGHT_COLOR];
    self.view = m_view;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //m_viewTitle = @"BIBLIO MONTREAL";
    if(m_viewTitle != nil)
        self.title = m_viewTitle;

    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[UIImage imageNamed: @"topbar_bg.png"] 
              forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
