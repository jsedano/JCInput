//
//  JC.h
//  TestSpriteKit01
//
//  Created by Juan Carlos Sedano Salas on 30/08/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JCJoystick : SKShapeNode
{
    
    
}
-(id)initWithControlRadius:(float)controlRadious
              baseRadius:(float)baseRadius
               baseColor:(SKColor *)baseColor
          joystickRadius:(float)joystickRadius
           joystickColor:(SKColor *)joystickColor;
@property float x;
@property float y;
@end
