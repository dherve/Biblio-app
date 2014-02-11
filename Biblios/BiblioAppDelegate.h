//
//  BiblioAppDelegate.h
//  Biblios
//

#import <UIKit/UIKit.h>

@interface BiblioAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow                *m_window;
    NSMutableArray          *m_viewControllers;
    UITabBarController      *m_tabBarController;
    UINavigationController  *m_navigationController;
    UIImageView             *m_imageView;
}
@property (nonatomic, retain) UINavigationController  *navigationController;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIImageView *imageView;
@end
