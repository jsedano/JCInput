//
//  JCButton.h
//  TestSpriteKit01
//
//  Created by Juan Carlos Sedano Salas on 18/09/13.
//  Copyright (c) 2013 Juan Carlos Sedano Salas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JCButton : SKShapeNode
{
    
    
}
-(id)initWithButtonRadius:(float)buttonRadious
                  color:(SKColor *)color
                  pressedColor:(SKColor *)pressedColor
                  isTurbo:(BOOL)isTurbo;
-(BOOL)wasPressed;
@end
