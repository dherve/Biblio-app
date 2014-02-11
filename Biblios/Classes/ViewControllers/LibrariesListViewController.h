//
//  LibrariesListViewController.h
//  Biblios
//
//  Show the list of libraries, when the application is launch this is the view
//  shown/selected.
//

#import <UIKit/UIKit.h>
#import "BasicListViewController.h"
@interface LibrariesListViewController :BasicListViewController
{
    UIActivityIndicatorView *m_activityIndicatorView;
}
-(id) init;
@end
