//
//  ANSAdminRoom.h
//  Objective-c course
//
//  Created by Nikola Andriiev on 06.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSAccountant.h"
#import "ANSDirector.h"


@interface ANSAdminRoom : NSObject

@property (nonatomic, retain) ANSAccountant *accountant; //remove to another room
@property (nonatomic, retain) ANSDirector *direcrot; //remove to another room

@end
