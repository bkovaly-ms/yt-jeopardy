//
//  Question.h
//  ytjeopardy
//
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property NSObject* questionAsked;

@property NSInteger pointValue;

@property NSString *text;

@property NSUInteger time;

@property BOOL selected;

@property BOOL answeredCorrectly;

@property NSString *category;

@property NSString *teamName;

@end
