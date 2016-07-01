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

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        if (_state != state) {
            _state = state;
            
            [self notifyObserversWithSelector:[self selectorForState:state]];
        }
    }
}

- (NSUInteger)state {
    return _state;
}

#pragma mark -
#pragma mark Accessors 

- (NSSet *)getObserversSet {
    return [[self.observersHashTable.setRepresentation copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addObserverObject:(id)object {
    @synchronized(self) {
        [self.observersHashTable addObject:object];
    }
}

- (void)addObserverObjects:(NSArray *)objects {
    @synchronized(self) {
        for (id observer in objects) {
            [self.observersHashTable addObject:observer];
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

#pragma mark -
#pragma mark Private

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
                [observer performSelector:selector withObject:object];
            }
        }
    }
}

@end
