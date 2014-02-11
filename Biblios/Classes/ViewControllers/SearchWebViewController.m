//
//  SearchResultsWebViewController.m
//  Biblios
//

#import "SearchWebViewController.h"
#import "UIStyles.h"
#import "Utilis.h"
#import "ErrorDialogHandler.h"
@implementation SearchWebViewController


-(id) initWithURL:(NSString *) url
{
    self = [super init];
    if(self){
        m_urlToLoad = [NSURL URLWithString:url];
        
        // Set the frame for the view
        m_webView = [[UIWebView alloc] init];
        [m_webView setDelegate:self];
        m_webView.scalesPageToFit = YES;
        m_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                                   UIActivityIndicatorViewStyleGray];
        m_activityIndicatorView.center = CGPointMake(APPLICATION_WIDTH/2, APPLICATION_HEIGHT/2);
        
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
//    if(m_urlToLoad != nil)
//        [m_urlToLoad release];
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
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:m_urlToLoad];
    
    //Load the request in the UIWebView.
   [m_webView loadRequest:requestObj];
    
    // request user location
    [m_activityIndicatorView startAnimating];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

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
                        NSLocalizedString(@"Unable to load search results", nil)];  
}


@end
