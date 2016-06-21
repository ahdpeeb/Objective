//
//  ANSWorkerDelegate.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 20.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANSWorker;

@protocol ANSWorkerDelegate <NSObject>

- (void)didFinishedWork:(ANSWorker *) worker;

@end
