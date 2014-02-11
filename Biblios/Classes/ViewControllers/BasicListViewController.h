//
//  BasicListViewController.h
//  Biblios
//
//  Base class for view controllers that display simple list.
//

#import <UIKit/UIKit.h>
#import "BaseHeader.h"
@interface BasicListViewController: UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSString            *m_viewTitle;
    NSMutableDictionary *m_data;
    NSArray             *m_dataKeys;
    BaseHeader          *m_header;
    UIBarButtonItem     *m_navBarLeftButton;
    UIBarButtonItem     *m_navBarRightButton;
    UITableView         *m_tableView;
    UILabel             *m_emptyListMessageLabel;

}

// Show a message when the list is empty.
- (void)showMessageForEmptyList:(NSString *) message;

// remove the message shown when the list is empy.
- (void)removeMessageForEmptyList;
@end
