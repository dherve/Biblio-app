//
//  DirectionsWebViewController.h
//  Biblios
//
//  Shows the webview used to show the directions instructions to a specific library.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
#import "Address.h"
@interface DirectionsWebViewController : BasicViewController<UIWebViewDelegate>
{
    UIWebView               *m_webView;
    NSString                *m_destination;
    UIActivityIndicatorView *m_activityIndicatorView;
}
@property (nonatomic, retain) NSString *destination;

// Constructor with the library address to go to (here the destination).
-(id)initWithDestination:(Address *) destination;
@end
