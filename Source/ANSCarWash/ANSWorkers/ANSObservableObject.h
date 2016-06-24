//
//  ANSObservableObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(uint8_t, ANSState) {
    ANSWorkerFree,
    ANSWorkerBusy,
    ANSWorkIsPending
};

@interface ANSObservableObject : NSObject
@property (atomic, assign)      ANSState      state;
@property (atomic, readonly)    NSHashTable   *obserers;

- (void)addObserverObject:(id )object;
- (void)removeObserverObject:(id)object;
- (BOOL)isObservedByObject:(id)object;

//this method is intended for subclasses. Never call it directly. 
- (SEL)selectorForState:(ANSState)state;

@end
