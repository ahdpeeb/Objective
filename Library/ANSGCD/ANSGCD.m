//
//  ANSGCD.m
//  Objective-c course
//
//  Created by Nikola Andriiev on 14.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSGCD.h"

void ANSPerformAsyncQueue(long identifier, ANSGCDBlock block) {
    dispatch_async(dispatch_get_global_queue(identifier, 0), block);
}

void ANSPerformSyncQueue(long identifier, ANSGCDBlock block) {
    dispatch_sync(dispatch_get_global_queue(identifier, 0), block);
}

void ANSPerformMainQueue(long identifier, ANSGCDBlock block) {
    dispatch_sync(dispatch_get_main_queue(), block);
}

