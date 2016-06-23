//
//  ANSObserverObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObserverObjectTest.h"

@implementation ANSObserverObjectTest

#pragma mark -
#pragma mark initialization and deallocation 

- (void)dealloc {
    self.purse = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accsessors

- (void)setPurse:(ANSPurse *)purse {
    if (_purse != purse) {
        [_purse removeObserverObject:self];
        _purse = [purse retain];
        
        [_purse addObserverObject:self];
    }
}

#pragma mark -
#pragma mark ANSPurseObserver protocol methods

- (void)purseDidBecomeEmpty:(ANSPurse *)purse {
    NSLog(@"purs in empty %@", purse);
}
- (void)purseDidBecomeNonEmpty:(ANSPurse *)purse {
    NSLog(@"purs NOT empty%@", purse);
}

@end
