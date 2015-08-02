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
@property NSMutableArray *categories;
@property NSMutableDictionary *allQuestions;

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
        [self loadAllQuestions];
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
    
    NSArray *questionsInCategory = self.allQuestions[category];
    
    if (!questionsInCategory || questionsInCategory.count == 0)
    {
        NSLog(@"No questions exist for the category: %@", category);
        return nil;
    }
    
    // should probably check array bounds, but i'll let you YTs figure out why the app crashes if you don't pass proper bounds ;)
    return questionsInCategory[index];
}

- (int)getNumberOfQuestions
{
    return self.numberOfQuestions;
}

#pragma mark - helpers
- (void) loadAllQuestions
{
    NSArray *allKeys = [self.questions allKeys];
    self.categories = [NSMutableArray new];
    self.allQuestions = [NSMutableDictionary new];
    
    for (NSString *category in allKeys)
    {
        // Add to category list
        [self.categories addObject:category];
        
        // Add questions in this category to allQuestions.
        NSArray *questions = [self loadQuestionsIncategory:category];
        [self.allQuestions setValue:questions forKey:category];
        
        self.numberOfQuestions += (int)questions.count;
    }
}

- (NSArray *) loadQuestionsIncategory:(NSString *)category
{
    NSMutableArray *questionInCategory = [NSMutableArray new];
    
    NSArray *questionsInDict = self.questions[category][@"Questions"];
    for (NSDictionary *questionDict in questionsInDict)
    {
        if (questionDict)
        {
            Question *question = [Question new];
            question.category = category;
            question.text = questionDict[QUESTION_TEXT];
            question.time = [questionDict[QUESTION_TIME] integerValue];
            question.pointValue = [questionDict[QUESTION_POINTVALUE] integerValue];
            [questionInCategory addObject:question];
        }
    }
    
    return questionInCategory;
}

@end
