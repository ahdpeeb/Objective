//
//  ANSQueue.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 17.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSQueue : NSObject
@property (nonatomic, readonly) NSUInteger count;

- (void)enqueue:(id)object;
- (id)dequeue;

@end
