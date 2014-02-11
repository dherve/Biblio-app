//
//  ErrorsHandler.m
//  Biblios
//

#import "ErrorDialogHandler.h"

@implementation ErrorDialogHandler
+(void) showDialogForErrorMessage:(NSString *) message
                        withTitle:(NSString *) title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    NSLog(@"ERROR MESSAGE TO SHOW ==> %@", message);
}

+(void) showDialogForErrorMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];  
}
@end
