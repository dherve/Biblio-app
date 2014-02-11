//
//  DirectionsWebViewController.m
//  Biblios
//

#import "DirectionsWebViewController.h"
#import "UIStyles.h"
#import "Notifications.h"
#import "LocationHandler.h"
#import "ErrorDialogHandler.h"
#import "Utilis.h"
@interface DirectionsWebViewController(PrivateAPI)
-(void) showDirections;
@end

@implementation DirectionsWebViewController
@synthesize destination = m_destination;
-(id)initWithDestination:(Address *) destination
{    self = [super init];
    if(self){
        self.destination =  [destination description];
        m_webView = [[UIWebView alloc] init];
        [m_webView setDelegate:self];
        m_webView.scalesPageToFit = YES;
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

-(void) dealloc
{
    [m_webView release];
    [m_destination release];
    [m_activityIndicatorView release];
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.view = m_webView;
    [m_webView addSubview:m_activityIndicatorView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[LocationHandler instance] requestUserLocation];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showDirections) 
                                                 name:USER_LOCATION_AVAILABLE_NOTIFICATION 
                                               object:nil];
    [m_activityIndicatorView startAnimating];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - private methods
-(void) showDirections
{
    NSString *location = [[LocationHandler instance] userCoordinatesAsString];
    NSString *origin = [m_destination stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:GOOGLE_MAPS_URL, location, origin]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [m_webView loadRequest:request];
}


#pragma mark - UIWebView delegates methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [m_activityIndicatorView stopAnimating];
    [m_activityIndicatorView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [m_activityIndicatorView stopAnimating];
    [m_activityIndicatorView removeFromSuperview];
    [ErrorDialogHandler showDialogForErrorMessage:
                        NSLocalizedString(@"Unable to load directions", nil)];
}


@end
