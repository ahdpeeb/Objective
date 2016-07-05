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
@property (nonatomic, retain) NSHashTable *observersHashTable;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector object:(id)object;
- (SEL)selectorForState:(NSUInteger)state;

@end

@implementation ANSObservableObject

@synthesize state = _state;

@dynamic observersSet;

#pragma mark -
#pragma mark Initialization and deallocation

- (void)dealloc {
    self.observersHashTable = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.observersHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyObserversWithSelector:[self selectorForState:state] object:object];
        }
    }
}

- (void)setState:(NSUInteger)state {
    [self setState:state withObject:self];
}

- (NSUInteger)state {
    return _state;
}

- (NSSet *)observersSet {
    return self.observersHashTable.setRepresentation;
}

#pragma mark -
#pragma mark Public methods

- (void)addObserverObject:(id)object {
    @synchronized(self) {
        [self.observersHashTable addObject:object];
    }
}

- (void)addObserverObjects:(NSArray *)objects {
    @synchronized(self) {
        NSHashTable *observers = self.observersHashTable;
        for (id observer in objects) {
            [observers addObject:observer];
        }
    }
}

- (void)removeObserverObject:(id)object {
    @synchronized(self) {
        [self.observersHashTable removeObject:object];
    }
}

- (void)removeObserverObjects:(NSArray *)objects {
    @synchronized(self) {
        for (id observer in objects) {
            [self.observersHashTable removeObject:observer];
        }
    }
}

- (BOOL)isObservedByObject:(id)object {
    @synchronized(self) {
        return [self.observersHashTable containsObject:object];
    }
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfState:state withObject:nil];
}

- (void)notifyOfState:(NSUInteger)state withObject:(id)object {
    @synchronized(self) {
       SEL selector = [self selectorForState:state];
        [self notifyObserversWithSelector:selector object:object];
    }
}

#pragma mark -
#pragma mark Private methods

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithSelector:selector object:self];
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    @synchronized(self) {
        NSHashTable *observers = self.observersHashTable;
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self withObject:object];
            }
        }
    }
}

@end
