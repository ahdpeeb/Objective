//
//  ANSObserverObjectTest.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 22.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSPurse.h"

@interface ANSObserverObjectTest : NSObject <ANSPurseObserver>
@property (nonatomic, retain) ANSPurse *purse;

@end
