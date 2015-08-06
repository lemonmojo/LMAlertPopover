//
//  AppDelegate.m
//  NSAlertPopoverDemo
//
//  Created by Felix Deimel on 06.08.15.
//  Copyright (c) 2015 Lemon Mojo. All rights reserved.
//

#import "AppDelegate.h"
#import "LMAlertPopover.h"
#import "NSAlert+LM.h"

@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *textFieldPressedButton;
@property (assign) IBOutlet NSButton *checkboxDoNotShowAgain;

@end

@implementation AppDelegate

- (IBAction)buttonShowAlert_action:(id)sender
{
    __block NSTextField* textFieldPressedButton = _textFieldPressedButton;
    __block NSButton* checkboxDoNotShowAgain = _checkboxDoNotShowAgain;
    
    __block NSAlert* alert = [[[NSAlert alloc] init] autorelease];
    
    alert.messageText = @"LMAlertPopover is awesome";
    alert.informativeText = @"LMAlertPopover provides a simple API for showing an NSAlert as Popover.\n\nARC is currently not supported but it should be easy to convert the project. Alternatively, if your project is using ARC, you can also just disable it for LMAlertPopover.m.";
    [alert addButtonWithTitle:@"Awesome"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert addButtonWithTitle:@"ARC Help"];
    alert.alertStyle = NSCriticalAlertStyle;
    
    alert.dontWarnMessage = @"Do not show this message again";
    
    [LMAlertPopover showWithAlert:alert completionBlock:^(NSInteger result) {
        if (result == NSAlertFirstButtonReturn) {
            textFieldPressedButton.stringValue = @"Awesome";
        } else if (result == NSAlertSecondButtonReturn) {
            textFieldPressedButton.stringValue = @"Cancel";
        } else if (result == NSAlertThirdButtonReturn) {
            textFieldPressedButton.stringValue = @"ARC Help";
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://stackoverflow.com/questions/6646052"]];
        }
        
        checkboxDoNotShowAgain.state = alert.dontWarnAgain ? NSOnState : NSOffState;
    } relativeToRect:NSZeroRect view:sender preferredEdge:NSMaxYEdge];
}

@end
