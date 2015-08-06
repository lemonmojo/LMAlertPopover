//
//  NSAlert+LM.m
//  NSAlertPopoverDemo
//
//  Created by Felix Deimel on 06.08.15.
//  Copyright (c) 2015 Lemon Mojo. All rights reserved.
//

#import "NSAlert+LM.h"

@implementation NSAlert (LM)

- (void)setDontWarnMessage:(NSString*)message
{
    const SEL sel = @selector(_setDontWarnMessage:);
    
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:message];
    }
}

- (BOOL)dontWarnAgain
{
    const SEL sel = @selector(_dontWarnAgain);
    
    if ([self respondsToSelector:sel]) {
        return [[self performSelector:sel withObject:nil] boolValue];
    }
    
    return NO;
}

@end