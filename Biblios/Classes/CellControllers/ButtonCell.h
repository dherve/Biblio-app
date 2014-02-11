//
//  ButtonCell.h
//  Biblios
//
//  Custom cell used to display a button in a tableview.
//

#import <UIKit/UIKit.h>

@interface ButtonCell : UITableViewCell
{
    UIButton *m_button;
}
@property (nonatomic, retain) UIButton *button;
@end
