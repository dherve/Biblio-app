//
//  DbListener.h
//  Biblios
//
//  Define the methods to be implemented by any object who interested 
//  by any update in the database.
//

#import <Foundation/Foundation.h>

@protocol DbListener <NSObject>

// Used to notify an object about an update in the database.
-(void) notifyDbUpdated;
@end
