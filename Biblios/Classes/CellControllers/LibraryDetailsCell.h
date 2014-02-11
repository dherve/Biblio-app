//
//  LibraryDetailsCell.h
//  Biblios
//
//  Custom cell used by the tableview (in the address section) 
//  of the library details viewcontroller. 
//

#import <UIKit/UIKit.h>

@interface LibraryDetailsCell : UITableViewCell
{
    UIView  *m_iconView;
    
    //
    UILabel *m_firstLineTextLabel;
    UILabel *m_secondLineTextLabel;
}

/**
 * Set the text of the labels.
 * @param : firstLineText   the text to set for the first label.
 * @param : secondLineText  the text to set for the second label.
 */
-(void) setTextLines:(NSString *) firstLineText secondLineText:(NSString *) secondText;

/**
 * Set the icon of this cell.
 * @param : iconImage the image icon to set.
 */
-(void) setIconImage:(UIImage  *) iconImage;
@end
