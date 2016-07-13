//
//  ANSGCDTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 11.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSDispatcher.h"

@interface ANSGCDTest : ANSDispatcher

- (instancetype)initWithType:(dispatch_queue_attr_t)attribute;

- (void)execute;

@end
