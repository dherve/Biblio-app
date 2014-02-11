//
//  LibraryItemsListViewCell.h
//  Biblios
//
//  Custom cell used by the tableview of the items list viewcontroller.
//

#import <UIKit/UIKit.h>
#import "LibraryItem.h"
@interface LibraryItemsListViewCell : UITableViewCell
{
    UILabel     *m_titleLabel;
    UILabel     *m_dateLabel;
    UILabel     *m_libraryNameLabel;
    UIButton    *m_deleteButton;
    UIView      *m_separator;
    NSNumber    *m_itemId;
}

/**
 * Set the text for the labels of this cell.
 * @param : libraryItem the libraryItem object from which to retrieve the text.
 */
-(void) setContentData:(LibraryItem *) libraryItem;
@end
