//
//  NSAlert+LM.h
//  NSAlertPopoverDemo
//
//  Created by Felix Deimel on 06.08.15.
//  Copyright (c) 2015 Lemon Mojo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAlert (LM)

- (void)setDontWarnMessage:(NSString*)message;
- (BOOL)dontWarnAgain;

@end