//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSObservableObject : NSObject
@property (atomic, assign)          NSUInteger    state;
@property (nonatomic, readonly)     NSSet         *observersSet;

- (void)addObserverObject:(id)object;
- (void)addObserverObjects:(NSArray *)objects;
- (void)removeObserverObject:(id)object;
- (void)removeObserverObjects:(NSArray *)objects;
- (BOOL)isObservedByObject:(id)object;

//this method is intended for subclasses. Never call it directly. 
- (SEL)selectorForState:(NSUInteger)state;

@end
