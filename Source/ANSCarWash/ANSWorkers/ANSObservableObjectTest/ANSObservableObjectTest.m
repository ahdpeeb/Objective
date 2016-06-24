//
//  ANSObservableObjectTest.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSObservableObjectTest.h"

#import "NSObject+ANSExtension.h"

@interface ANSObservableObjectTest ()
@property (nonatomic, retain) NSMutableSet *mutableObserers;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;

@end

@implementation ANSObservableObjectTest

@dynamic obserers;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.mutableObserers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableObserers = [NSMutableSet object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accsessors

- (NSSet *)obserers {
    return [[self.mutableObserers copy] autorelease];
}

- (void)setState:(ANSState)state {
    if (_state != state) {
        _state = state;

        [self notifyOfStateChangeWithSelector:[self selectorForState:state]];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObserverObject:(id)object {
    [self.mutableObserers addObject:object];
}

- (void)removeObserverObject:(id)object {
    [self.mutableObserers removeObject:object];
}

- (BOOL)isObservedByObject:(id)object {
    return [self.mutableObserers containsObject:object];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(ANSState)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    NSMutableSet *observers = self.mutableObserers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self]; 
        }
    }
}

@end
