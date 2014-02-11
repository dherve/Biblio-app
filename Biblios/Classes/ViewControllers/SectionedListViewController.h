//
//  SectionedListViewController.h
//  Biblios
//
//  Base class for view controllers that display a grouped list.
//


#import <UIKit/UIKit.h>
#import "BaseHeader.h"

#define SECTION_DATA @"section data"

@interface SectionedListViewController :  UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSString            *m_viewTitle;
    NSMutableArray      *m_sections;
    NSMutableDictionary *m_sectionData;
    BaseHeader          *m_header;
    UITableView         *m_tableView;
    UIBarButtonItem     *m_backButton;
    UIButton            *m_navBarLeftButton;
    UIButton            *m_navBarRightButton;
    NSDictionary        *m_notificationInfos;
    UILabel             *m_emptyListMessageLabel;
}

// Used to set navigation bar right button
- (void) initNavigationBarRightButton:(NSString *) title;

// Used to set navigation bar left button
- (void) initNavigationBarLeftButton:(NSString *) title;

// Use for registration to keyboard notifications.
- (void)registerForKeyboardNotifications;

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification;

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

// Show a message when the list is empty.
- (void)showMessageForEmptyList:(NSString *) message;

// Remove the message shown when the list is empy.
- (void)removeMessageForEmptyList;

@end
