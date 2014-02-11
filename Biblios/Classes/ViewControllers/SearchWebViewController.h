//
//  SearchResultsWebViewController.h
//  Biblios
//
//  Shows the webview used to show the results of an item search.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
@interface SearchWebViewController : BasicViewController<UIWebViewDelegate>
{
    UIWebView   *m_webView;
    NSURL       *m_urlToLoad;
    UIActivityIndicatorView *m_activityIndicatorView;
}
-(id) initWithURL:(NSString *) url;
@end
