//
//  QuestionRetriever.m
//  ytjeopardy
//
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "QuestionRetriever.h"

#define QUESTION_TEXT @"text"
#define QUESTION_TIME @"time"
#define QUESTION_POINTVALUE @"pointValue"

@interface QuestionRetriever ()

@property NSDictionary *questions;
@property int numberOfQuestions;

@end

@implementation QuestionRetriever

- (instancetype)initWithQuestionFileName:(NSString*)fileName
{
    NSDictionary *plistQuestions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]];
    
    if (!plistQuestions)
    {
        NSLog(@"The question file you requested does not exist (%@)", fileName);
        return nil;
    }
    
    if (self = [super init])
    {
        self.questions = plistQuestions;
        self.numberOfQuestions = [self calculateNumberOfQuestions];
    }
    
    return self;
}

- (Question*)questionForCategory:(NSString*)category index:(NSInteger)index
{
    if (!category)
    {
        NSLog(@"Pass in a category, silly.");
        return nil;
    }
    
    NSArray *questionsInCategory = self.questions[category][@"Questions"];
    
    if (!questionsInCategory)
    {
        NSLog(@"No questions exist for the category: %@", category);
        return nil;
    }
    
    // should probably check array bounds, but i'll let you YTs figure out why the app crashes if you don't pass proper bounds ;)
    NSDictionary *questionDict = questionsInCategory[index];
    
    if (questionDict)
    {
        Question *question = [Question new];
        question.category = category;
        question.text = questionDict[QUESTION_TEXT];
        question.time = [questionDict[QUESTION_TIME] integerValue];
        question.pointValue = [questionDict[QUESTION_POINTVALUE] integerValue];
        return question;
    }
    else
    {
        return nil;
    }
}

- (int)getNumberOfQuestions
{
    return self.numberOfQuestions;
}

#pragma mark - helpers
- (int) calculateNumberOfQuestions
{
    int count = 0;
    
    for (NSString *category in [self.questions allKeys])
    {
        NSArray *questionsInCategory = self.questions[category][@"Questions"];
        count += questionsInCategory.count;
    }
    
    return count;
}

@end
