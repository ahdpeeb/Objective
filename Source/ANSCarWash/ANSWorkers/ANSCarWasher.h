//
//  ANSCarWasher.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 07.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import "ANSWorker.h"

#import "ANSCar.h"
#import "ANSAccountant.h"

@interface ANSCarWasher : ANSWorker

- (void)washCar:(ANSCar *)car;

@end
