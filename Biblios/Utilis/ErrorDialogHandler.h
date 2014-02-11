//
//  ErrorsHandler.h
//  Biblios
//
//  Show dialog windows for error messages.
//

#import <Foundation/Foundation.h>

@interface ErrorDialogHandler : NSObject
    /**
     * Show a dialog error message.
     * @param : message the error message to show.
     */
    +(void) showDialogForErrorMessage:(NSString *) message;

    /**
     * Show a dialog error message with a custom title
     * @param : message the error message to show.
     * @param : title   the title of the dialog to be shown.
     */
    +(void) showDialogForErrorMessage:(NSString *) message
                            withTitle:(NSString *) title;
@end
