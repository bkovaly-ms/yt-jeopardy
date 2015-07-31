//
//  JeopordyButton.h
//  ytjeopardy
//
//  Created by Robert Pena on 7/28/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface JeopordyButton : UIButton

@property Question *quest;

@property NSInteger questionValue;

@property NSString *categoryString;

@end
