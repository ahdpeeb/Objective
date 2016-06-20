//
//  ANSWorkerDelegate.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 20.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ANSWorkerDelegate <NSObject>

- (void)workerGotMoney:(id)worker;

@end
