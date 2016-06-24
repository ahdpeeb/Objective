//
//  ANSObservableObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObject.h"

#import "NSObject+ANSExtension.h"

@interface ANSObservableObject ()
@property (atomic, retain) NSHashTable *obserers;

- (void)notifyObserversWithSelector:(SEL)selector;

@end

@implementation ANSObservableObject

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.obserers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.obserers = [NSHashTable object];
    }
    
    return self;
}

- (void)setState:(ANSState)state {
    if (_state != state) {
        _state = state;

        [self notifyObserversWithSelector:[self selectorForState:state]];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObserverObject:(id)object {
    [self.obserers addObject:object];
}

- (void)removeObserverObject:(id)object {
    [self.obserers removeObject:object];
}

- (BOOL)isObservedByObject:(id)object {
    return [self.obserers containsObject:object];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(ANSState)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyObserversWithSelector:(SEL)selector {
    NSHashTable *observers = self.obserers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self]; 
        }
    }
}

@end
