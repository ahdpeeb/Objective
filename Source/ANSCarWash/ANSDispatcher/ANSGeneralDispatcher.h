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

@interface ANSGeneralDispatcher : NSObject <ANSWorkerObserver>
@property (nonatomic, readonly)     ANSQueue  *processingObjects;
@property (nonatomic, readonly)     NSArray   *processors;


@end
