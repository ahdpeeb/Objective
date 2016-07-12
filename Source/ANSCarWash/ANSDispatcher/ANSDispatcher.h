//
//  ANSGeneralDispatcher.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.07.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSQueue.h"
#import "ANSWorker.h"

@interface ANSDispatcher : NSObject <ANSWorkerObserver>
@property (nonatomic, readonly)     ANSQueue        *processingObjects;
@property (nonatomic, readonly)     NSArray         *processors;
@property (nonatomic, readonly)     NSString        *name;

+ (ANSDispatcher *)dispatcherWithName:(NSString *)name;

- (void)processObject:(id<ANSMoneyOwner>)object;

- (void)addProcessors:(NSArray *)processors;
- (void)removeProcessors:(NSArray *)processors;

- (void)addProcessor:(id)processor;
- (void)removeProcessor:(id)processor;

@end
