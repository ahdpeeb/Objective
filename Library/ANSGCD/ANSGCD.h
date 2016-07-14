//
//  ANSGCD.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ANSGCDBlock)(void);
/*Funcrion takes "identifier"   *  - QOS_CLASS_USER_INTERACTIVE
                                *  - QOS_CLASS_USER_INITIATED
                                *  - QOS_CLASS_DEFAULT
                                *  - QOS_CLASS_UTILITY
                                *  - QOS_CLASS_BACKGROUND
 
    and block of code, which will be performed. */

// block asynchronously executу in backgrounds thread.
void ANSPerformAsyncQueue(long identifier, ANSGCDBlock block);

// block synchronously executу in backgrounds thread.
void ANSPerformSyncQueue(long identifier, ANSGCDBlock block);

// perform block in main thread.
void ANSPerformMainQueue(long identifier, ANSGCDBlock block);