//
//  LMAlertPopover.h
//  NSAlertPopoverDemo
//
//  Created by Felix Deimel on 06.08.15.
//  Copyright (c) 2015 Lemon Mojo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void (^NSAlertCompletionBlock)(NSInteger result);

@interface LMAlertPopover : NSObject<NSPopoverDelegate> {
    NSAlert* _alert;
    NSAlertCompletionBlock _completionBlock;
    NSPopover* _popover;
}

- (instancetype)initWithAlert:(NSAlert*)anAlert andCompletionBlock:(NSAlertCompletionBlock)aCompletionBlock;
+ (void)showWithAlert:(NSAlert*)anAlert completionBlock:(NSAlertCompletionBlock)aCompletionBlock relativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge;

@property (nonatomic, readonly) BOOL isShown;
@property (nonatomic, assign) BOOL shouldReleaseItself;

- (void)showRelativeToRect:(NSRect)rect view:(NSView*)view preferredEdge:(NSRectEdge)preferredEdge;

@end