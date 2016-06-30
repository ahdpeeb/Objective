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
@property (nonatomic, retain) NSHashTable *hashTableObservers;

- (void)notifyObserversWithSelector:(SEL)selector;

@end

@implementation ANSObservableObject
@synthesize state = _state;
@dynamic observersSet;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.hashTableObservers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.hashTableObservers = [[NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory] autorelease];
    
    return self;
}

- (void)setState:(NSUInteger)state {
    if (_state != state) {
        _state = state;

        [self notifyObserversWithSelector:[self selectorForState:state]];
    }
}

- (NSUInteger)state {
    return _state;
}

#pragma mark -
#pragma mark Accessors 

- (NSSet *)getObserversSet {
    return [[self.hashTableObservers copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addObserverObject:(id)object {
    @synchronized(self) {
        [self.hashTableObservers addObject:object];
    }
}

- (void)removeObserverObject:(id)object {
    @synchronized(self) {
        [self.hashTableObservers removeObject:object];
    }
}

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
        return [self.hashTableObservers containsObject:object];
    }
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {    
    return NULL;
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:selector object:self];
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    NSHashTable *observers = self.hashTableObservers;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:object];
        }
    }
}

@end
