//
//  ANSGCD.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Accessories

//new type for dispatch_queue_t.
typedef dispatch_queue_t ANSQSGCQueue;

//block signature for execution
typedef void(^ANSGCDBlock)(void);

//signature to dispatch_async/ dispatch_async functions
typedef void (*ANSDispatch)(ANSQSGCQueue queue, ANSGCDBlock block);

//Identifier of queue prioryty
typedef enum {
    ANSPriorityHigh,            //  *  - DISPATCH_QUEUE_PRIORITY_HIGH:
    ANSPriorityDefault,         //  *  - DISPATCH_QUEUE_PRIORITY_DEFAULT:
    ANSPriorityLow,             //  *  - DISPATCH_QUEUE_PRIORITY_LOW:
    ANSPriorityBackground       //  *  - DISPATCH_QUEUE_PRIORITY_BACKGROUND:
} ANSPrioriryType;

#pragma mark -
#pragma mark Public functions

/*Funcrions take ANSPrioriryType - "identifier of queue prioryty"
 and block of code, which will be performed. Default type - ANSPriorityDefault*/

// Block asynchronously executу in backgrounds thread.
// It must be called from background thread.
void ANSPerformInAsyncQueue(ANSPrioriryType type, ANSGCDBlock block);

// Block synchronously executу in backgrounds thread.
// It must be called from background thread.
void ANSPerformInSyncQueue(ANSPrioriryType type, ANSGCDBlock block);

//  Perform block in main thread.
//  Functios must take ONLY "dispatch_async", "dispatch_async".
void ANSPerformOnMainQueue(ANSDispatch function, ANSGCDBlock block);

