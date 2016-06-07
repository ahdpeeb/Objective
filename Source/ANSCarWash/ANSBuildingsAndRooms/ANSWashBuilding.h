//
//  ANSWashBuilding.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 05.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSWashBox.h"

@interface ANSWashBuilding : NSObject

@property (nonatomic, readonly) NSArray *boxes;

- (void)addBox:(ANSWashBox *)box;
- (void)removeBox:(ANSWashBox *)box;
- (ANSWashBox* )freeBox;

@end
