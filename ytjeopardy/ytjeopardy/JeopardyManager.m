//
//  JeopardyManager.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 7/31/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "JeopardyManager.h"
#import "Team.h"
#import "Question.h"
#import "QuestionRetriever.h"

/** 
 
 Rules of the state machine:
 - Team1 gets to start picking
 - Team that picks the question gets to answer it first 
 - If they fail to answer it within the alloted time, the next team gets to answer. 
 - If they fail, the team after them gets to answer. 
 - Once someone answers right, or everyone has tried once, Team2 gets to pick a question.
 
 */

@interface JeopardyManager()

@property NSMutableArray *teams;
@property int countQuestionsShown;
@property (readwrite) QuestionRetriever *qr;

#pragma mark - picking question
@property int indexOfTeamPickingQuestion;
@property Question *currentQuestion;

#pragma mark - picking answers
@property int countOfTeamsAttemptedAnswer;
@property int indexOfTeamAnswering;

@end

@implementation JeopardyManager

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static JeopardyManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[JeopardyManager alloc] init];
    });
    
    return sharedManager;
}

#pragma mark - Game Management

// Start the game. Picks one of the teams to go first.
-(void)startGameWithTeam1:(NSString *)name1 team2:(NSString *)name2 team3:(NSString *)name3 questionFileName:(NSString *)fileName
{
    self.qr = [[QuestionRetriever alloc] initWithQuestionFileName:fileName];
    
    self.teams = [NSMutableArray new];

    self.team1 = [self createTeamWithName:name1];
    [self.teams addObject:self.team1];

    self.team2 = [self createTeamWithName:name2];
    [self.teams addObject:self.team2];
    
    self.team3 = [self createTeamWithName:name3];
    [self.teams addObject:self.team3];
    
    self.countQuestionsShown = 0;
    self.indexOfTeamPickingQuestion = -1;
    [self advanceToNextPickingTeam];
}

// Returns the question for the category and assigns a team to answer it based on team state.
- (Question *)startQuestionForCategory:(NSString*)category index:(NSInteger)index
{
    // Is game over?
    if ([self checkGameOver])
    {
        return nil;
    }
    
    // Get the question.
    Question *nextQuestion = [self.qr questionForCategory:category index:index];
    if (nextQuestion.questionAsked == YES)
    {
        NSLog(@"This question has already been asked.");
        self.currentQuestion = nil;
    }
    else
    {
        nextQuestion.questionAsked = YES;
        self.currentQuestion = nextQuestion;
        self.countQuestionsShown++;
        
        // Team that selected the question gets to answer first.
        [self setNextAnsweringTeamAtIndex:self.indexOfTeamPickingQuestion];
        self.countOfTeamsAttemptedAnswer = 0;
    }
    
    return self.currentQuestion;
}

// Returns YES when it's time to move to the next question:
//  - when the question was answered correctly OR
//  - when no team answered the question correctly
// Returns NO when another team gets to answer the question.
-(BOOL)questionAnswered:(BOOL)answeredCorrectly
{
    self.countOfTeamsAttemptedAnswer++;
    
    if (answeredCorrectly)
    {
        // Good job team! You earn some points.
        Team *team = [self.teams objectAtIndex:self.indexOfTeamAnswering];
        team.score += self.currentQuestion.pointValue;
        self.currentQuestion.answeredCorrectly = YES;
        self.currentQuestion.teamName = team.name;
        
        // And the next team gets to answer.
        [self advanceToNextPickingTeam];
        return YES;
    }
    else if (self.countOfTeamsAttemptedAnswer == 3)
    {
        // All teams have had a chance to answer the question.
        // But no one got it right!
        [self advanceToNextPickingTeam];
        return YES;
    }
    else
    {
        // Next team's turn to answer.
        [self advanceToNextAnsweringTeam];
        return NO;
    }
}

-(BOOL)checkGameOver
{
    return (self.countQuestionsShown >= [self.qr getNumberOfQuestions]);
}

- (NSArray *)teamsSortedByScore
{
    NSArray *sortedArray;
    sortedArray = [self.teams sortedArrayUsingComparator:^NSComparisonResult(Team *team1, Team *team2)
           {
               NSInteger score1 = team1.score;
               NSInteger score2 = team2.score;
               return score1 < score2;
           }];
    return sortedArray;
}

#pragma mark - helpers

-(Team *)createTeamWithName:(NSString *)name
{
    Team *team = [Team new];
    team.name = name;
    team.score = 0;
    team.canChooseQuestion = NO;
    team.canAnswer = NO;
    
    return team;
}

-(void)advanceToNextPickingTeam
{
    self.indexOfTeamPickingQuestion = (self.indexOfTeamPickingQuestion + 1) % 3;
    self.currentQuestion = nil;
    
    
    for (int index = 0; index < self.teams.count; index++)
    {
        Team *team = [self.teams objectAtIndex:index];
        if (index == self.indexOfTeamPickingQuestion)
        {
            team.canChooseQuestion = YES;
        }
        else
        {
            team.canChooseQuestion = NO;
        }
    }

    [self setNextAnsweringTeamAtIndex:-1];
}

-(void)advanceToNextAnsweringTeam
{
    int index = (self.indexOfTeamAnswering + 1) % 3;
    [self setNextAnsweringTeamAtIndex:index];
}

-(void)setNextAnsweringTeamAtIndex:(int)index
{
    self.indexOfTeamAnswering = index;
    
    for (int index = 0; index < self.teams.count; index++)
    {
        Team *team = [self.teams objectAtIndex:index];
        if (index == self.indexOfTeamAnswering)
        {
            team.canAnswer = YES;
        }
        else
        {
            team.canAnswer = NO;
        }
    }
}

@end
