//
//  LibrariesListViewCell.h
//  Biblios
//
//  Custom cell used by the tableview of the librayry list viewcontroller.
//

#import <UIKit/UIKit.h>
#import "Library.h"
@interface LibrariesListViewCell : UITableViewCell
{
    NSString *m_name;
    NSNumber *m_libraryID;
    UIView  *m_iconView;
    
    // Library to display additional text for the library.
    UILabel *m_subTextLabel;
    
    // Library to display the library name.
    UILabel *m_libraryNameLabel;
}

/**
 * Set the text for the labels of this cell.
 * @param : library the library object from which to retrieve the text.
 */
-(void) setContentData:(Library *) library;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *libraryID;
@end
