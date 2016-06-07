//
//  ANSAdminRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ANSAccountant.h"
#import "ANSBoss.h"

@interface ANSAdminRoom : NSObject
@property (nonatomic, readonly) ANSAccountant   *accountant;
@property (nonatomic, readonly) ANSBoss         *boss;

+ (ANSAdminRoom *)create;

- (ANSAccountant *)addAccountant;
- (void)removeAccountant;

- (ANSBoss *)addBoss;
- (void)removeBoss;

@end
