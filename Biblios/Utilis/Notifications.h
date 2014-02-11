//
//  Notifications.h
//  Biblios
//
//  Holds the differents types of notifications.
//

#import <Foundation/Foundation.h>

@interface Notifications : NSObject
    // Notification types
    extern NSString * const REQUEST_COMPLETED_NOTIFICATION;
    extern NSString * const REQUEST_FAILED_NOTIFICATION;
    extern NSString * const REQUEST_DATA_AVAILABLE_NOTIFICATION;
    extern NSString * const REQUEST_DATA_UNAVAILABLE_NOTIFICATION;

    extern NSString * const LOCATION_DATA_AVAILABLE_NOTIFICATION;
    extern NSString * const LOCATION_DATA_UNAVAILABLE_NOTIFICATION;
    
    extern NSString * const START_MONITORING_LOCATION_NOTIFICATION;
    extern NSString * const STOP_MONITORING_LOCATION_NOTIFICATION;
    extern NSString * const USER_LOCATION_AVAILABLE_NOTIFICATION;

    extern NSString * const LIBRARY_LIST_LOADING_COMPLETED;
    extern NSString * const LIBRARY_LIST_LOADING_FAILED;

    // Notification message key
    extern NSString * const NOTIFICATION_DATA_KEY;
    extern NSString * const NOTIFICATION_KEY_REQUEST_URL;
    extern NSString * const NOTIFICATION_KEY_REQUEST_TYPE;
    extern NSString * const NOTIFICATION_KEY_REQUEST_FAILURE_REASON;



+(NSDictionary *) notificationUserInfo:(id) data;
@end
