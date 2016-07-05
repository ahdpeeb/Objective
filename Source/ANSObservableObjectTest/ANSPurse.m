//
//  ANSPurse.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSPurse.h"

@implementation ANSPurse

#pragma mark -
#pragma mark Accsessors

- (void)setMoney:(NSUInteger)money {
    if (_money != money) {
        _money = money;
        
        self.state = (0 == money) ? ANSPurseEmpty : ANSPurseNonEmpty;
    }
}

#pragma mark -
#pragma mark Overloaded methods

- (SEL)selectorForState:(ANSState)state {
    switch (state) {
        case ANSPurseEmpty:
            return @selector(purseDidBecomeEmpty:);
            break;
            
        case ANSPurseNonEmpty:
            return @selector(purseDidBecomeNonEmpty:);
            break;
            
        default:
            return NULL;
            break;
    }
}

@end
