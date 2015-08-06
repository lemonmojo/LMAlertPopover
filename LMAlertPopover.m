//
//  LMAlertPopover.m
//  NSAlertPopoverDemo
//
//  Created by Felix Deimel on 06.08.15.
//  Copyright (c) 2015 Lemon Mojo. All rights reserved.
//

#import "LMAlertPopover.h"

@implementation LMAlertPopover

- (instancetype)initWithAlert:(NSAlert*)anAlert andCompletionBlock:(NSAlertCompletionBlock)aCompletionBlock
{
    self = [super init];
    
    if (self) {
        _alert = [anAlert retain];
        _completionBlock = [aCompletionBlock copy];
    }
    
    return self;
}

+ (void)showWithAlert:(NSAlert*)anAlert completionBlock:(NSAlertCompletionBlock)aCompletionBlock relativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge
{
    LMAlertPopover *alertPopover = [[LMAlertPopover alloc] initWithAlert:anAlert andCompletionBlock:aCompletionBlock];
    alertPopover.shouldReleaseItself = YES;
    
    [alertPopover showRelativeToRect:rect view:view preferredEdge:preferredEdge];
}

- (void)dealloc
{
    NSAlert* alert = _alert;
    
    if (alert) {
        [alert release];
        _alert = nil;
    }
    
    NSAlertCompletionBlock completionBlock = _completionBlock;
    
    if (completionBlock) {
        [completionBlock release];
        _completionBlock = nil;
    }
    
    NSPopover* popover = _popover;
    
    if (popover) {
        [popover release];
        _popover = nil;
    }
    
    [super dealloc];
}

- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge
{
    if (_isShown ||
        !_alert) {
        return;
    }
    
    NSAlert* alert = _alert;
    
    for (NSButton *button in alert.buttons) {
        button.target = self;
        button.action = @selector(dismissAlert:);
    }
    
    [alert layout];
    
    NSViewController *viewController = [[[NSViewController alloc] init] autorelease];
    viewController.view = [alert.window contentView];
    
    NSPopover* popover = _popover;
    
    if (popover) {
        [popover release];
        _popover = nil;
    }
    
    popover = [[NSPopover alloc] init];
    popover.delegate = self;
    popover.contentViewController = viewController;
    
    [popover showRelativeToRect:rect ofView:view preferredEdge:preferredEdge];
    
    _popover = popover;
    _isShown = YES;
}

- (void)dismissAlert:(NSButton*)clickedButton
{
    NSAlert* alert = _alert;
    
    NSUInteger indexOfClickedButton = [alert.buttons indexOfObject:clickedButton];
    
    NSInteger returnCode = 0;
    
    switch (indexOfClickedButton) {
        case NSAlertFirstButtonReturn:
        case NSAlertSecondButtonReturn:
        case NSAlertThirdButtonReturn:
            returnCode = indexOfClickedButton;
            break;
        default:
            returnCode = NSAlertThirdButtonReturn + indexOfClickedButton - 2;
            break;
    }
    
    NSAlertCompletionBlock completionBlock = _completionBlock;
    
    if (completionBlock) {
        completionBlock(returnCode);
    }
    
    NSPopover* popover = _popover;
    
    if (popover) {
        [popover close];
    }
}

- (void)popoverDidClose:(NSNotification*)notification
{
    NSPopover* popover = _popover;
    
    if (popover) {
        popover.delegate = nil;
        [popover release];
        _popover = nil;
    }
    
    _isShown = NO;
    
    BOOL shouldReleaseItself = _shouldReleaseItself;
    
    if (shouldReleaseItself) {
        [self release];
    }
}

@end