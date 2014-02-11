//
//  BusinessHoursCell.h
//  Biblios
//
//  Custom cell used by the tableview (in the business section) 
//  of the library details viewcontroller.
//

#import <UIKit/UIKit.h>

@interface BusinessHoursCell : UITableViewCell
{
    // Label to display the day.
    UILabel *m_dayLabel;
    
    // Label to display the hours.
    UILabel *m_hoursLabel;
}

/**
 * Set the text for the day and hours labels.
 * @param : day     the text to set for the day label.
 * @param : hours   the text to set for the hours label.
 */
-(void) setTime:(NSString *) day openHours:(NSString *) hours;
@end
