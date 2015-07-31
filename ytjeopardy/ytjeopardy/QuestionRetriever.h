//
//  QuestionRetriever.h
//  ytjeopardy
//
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

/**
 
 Instructions for use:
 
 QuestionRetriever *qr = [[QuestionRetriever alloc] initWithQuestionFileName:@"QuestionData"];
 Question *question = [qr questionForCategory:@"Syntax" index:0];
 
 Remember to import this file :)
 
 */
@interface QuestionRetriever : NSObject

// The sample file I've included is called "QuestionData".
- (instancetype)initWithQuestionFileName:(NSString*)fileName;

// Call me with your category (ex: "Syntax" and question index.)
// Index 0 will give you the lowest point question for that category.
- (Question*)questionForCategory:(NSString*)category index:(NSInteger)index;

- (int)getNumberOfQuestions;

@end
