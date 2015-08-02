//
//  JeopardyManager.h
//  ytjeopardy
//
//  Created by Poonam Hattangady on 7/31/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "Question.h"
#import "QuestionRetriever.h"

@interface JeopardyManager : NSObject

@property Team *team1;
@property Team *team2;
@property Team *team3;
@property (readonly) QuestionRetriever *qr;

#pragma mark - Game Management 

// Start the game. Picks one of the teams to go first.
-(void)startGameWithTeam1:(NSString *)name1 team2:(NSString *)name2 team3:(NSString *)name3 questionFileName:(NSString *)fileName;

// Returns the question for the category and assigns a team to answer it based on team state.
- (Question *)startQuestionForCategory:(NSString*)category index:(NSInteger)index;

// Returns YES when it's time to move to the next question:
//  - when the question was answered correctly OR
//  - when no team answered the question correctly
// Returns NO when another team gets to answer the question.
-(BOOL)questionAnswered:(BOOL)answeredCorrectly;

-(BOOL)checkGameOver;

// Returns the teams sorted by score with the winner at index 0.
- (NSArray *)teamsSortedByScore;

#pragma mark - Singleton

+ (instancetype)sharedInstance;

@end
