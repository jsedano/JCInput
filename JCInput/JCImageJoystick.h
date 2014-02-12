//
//  JCImageJoystick.h
//  JCInput
//
//  Created by Juan Carlos Sedano Salas on 11/02/14.
//  Copyright (c) 2014 Juan Carlos Sedano Salas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JCImageJoystick : SKSpriteNode

-(id)initWithJoystickImage:(NSString *)joystickImage
                baseImage:(NSString *)baseImage;
@property float x;
@property float y;

@end


