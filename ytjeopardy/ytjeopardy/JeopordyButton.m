//
//  JeopordyButton.m
//  ytjeopardy
//
//  Created by Robert Pena on 7/28/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "JeopordyButton.h"

@implementation JeopordyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
        [self setTitleColor:[UIColor clearColor] forState:UIControlStateDisabled];
        
    }
    return self;
}




@end
