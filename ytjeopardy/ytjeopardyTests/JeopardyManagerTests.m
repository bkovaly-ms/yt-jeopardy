//
//  JeopardyManagerTests.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 7/31/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Team.h"
#import "Question.h"
#import "JeopardyManager.h"

@interface JeopardyManagerTests : XCTestCase

@end

@implementation JeopardyManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJeopardyManager {
    // yeah, i know, uncool to write one long test function.
    
    BOOL result;
    
    JeopardyManager *jm = [JeopardyManager sharedInstance];
    XCTAssert(jm.team1 == nil, "jm.team1 should be nil");
    XCTAssert(jm.team2 == nil, "jm.team2 should be nil");
    XCTAssert(jm.team3 == nil, "jm.team3 should be nil");
    
    [jm startGameWithTeam1:@"team1" team2:@"team2" team3:@"team3" questionFileName:@"QuestionData"];
    XCTAssert(jm.team1 != nil, "jm.team1 should be set");
    XCTAssert(jm.team2 != nil, "jm.team2 should be set");
    XCTAssert(jm.team3 != nil, "jm.team3 should be set");
    
    XCTAssert([jm.team1.name isEqualToString:@"team1"], "team1 name");
    XCTAssert([jm.team2.name isEqualToString:@"team2"], "team2 name");
    XCTAssert([jm.team3.name isEqualToString:@"team3"], "team3 name");
    
    XCTAssert(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssertFalse(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");

    ////////////////////////////////////////////////////////////////////////////
    // Question1 (no one gets right)
    ////////////////////////////////////////////////////////////////////////////
    Question *question = [jm startQuestionForCategory:@"Syntax" index:0];
    XCTAssertNotNil(question, "question is not nil");
    
    // Team1 gets to answer.
    XCTAssert(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    
    // After first wrong answer, team2 gets to answer.
    result = [jm questionAnswered:NO];
    XCTAssertFalse(result, "Result after first wrong answer");
    XCTAssert(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssertFalse(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssert(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    
    // After second wrong answer, team3 gets to answer.
    result = [jm questionAnswered:NO];
    XCTAssertFalse(result, "Result after second wrong answer");
    XCTAssert(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssertFalse(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssert(jm.team3.canAnswer, "team3.canAnswer");
    
    // After third wrong answer, new question should start. scores should all be 0.
    result = [jm questionAnswered:NO];
    XCTAssert(result, "Result after third wrong answer");
    XCTAssertFalse(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssert(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    XCTAssert(jm.team1.score == 0, "team1.score");
    XCTAssert(jm.team2.score == 0, "team2.score");
    XCTAssert(jm.team3.score == 0, "team3.score");
    
    XCTAssertFalse([jm checkGameOver], "checkGameOver");
    
    ////////////////////////////////////////////////////////////////////////////
    // Question2 (last team gets right)
    ////////////////////////////////////////////////////////////////////////////

    // New question by team2.
    Question *question2 = [jm startQuestionForCategory:@"Syntax" index:1];
    XCTAssertNotNil(question2, "question is not nil");
    
    // Team2 gets to answer.
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssert(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    
    // After first wrong answer, team3 gets to answer.
    result = [jm questionAnswered:NO];
    XCTAssertFalse(result, "Result after first wrong answer");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssert(jm.team3.canAnswer, "team3.canAnswer");
    
    // After second wrong answer, team1 gets to answer.
    result = [jm questionAnswered:NO];
    XCTAssertFalse(result, "Result after second wrong answer");
    XCTAssert(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    
    // Third answer is correct, new question should start. score for team 1 should change.
    result = [jm questionAnswered:YES];
    XCTAssert(result, "Result after third right answer");
    XCTAssertFalse(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssertFalse(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssert(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    XCTAssert(jm.team1.score == question2.pointValue, "team1.score");
    XCTAssert(jm.team2.score == 0, "team2.score");
    XCTAssert(jm.team3.score == 0, "team3.score");
    
    XCTAssertFalse([jm checkGameOver], "checkGameOver");
    
    ////////////////////////////////////////////////////////////////////////////
    // Question3 (Team3 gets right)
    ////////////////////////////////////////////////////////////////////////////
    
    // New question by team2.
    Question *question3 = [jm startQuestionForCategory:@"Write It" index:0];
    XCTAssertNotNil(question3, "question is not nil");
    
    // Team3 gets to answer.
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssert(jm.team3.canAnswer, "team3.canAnswer");
    
    // Team3 answers right
    // Team 1 gets to go next. Team3's score is updated.
    result = [jm questionAnswered:YES];
    XCTAssert(result, "Result after first right answer");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    XCTAssert(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssertFalse(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssert(jm.team1.score == question2.pointValue, "team1.score");
    XCTAssert(jm.team2.score == 0, "team2.score");
    XCTAssert(jm.team3.score == question3.pointValue, "team3.score");
    
    XCTAssertFalse([jm checkGameOver], "checkGameOver");
    
    ////////////////////////////////////////////////////////////////////////////
    // Question4 (Team1 gets right)
    ////////////////////////////////////////////////////////////////////////////
    
    // New question by team2.
    Question *question4 = [jm startQuestionForCategory:@"Write It" index:1];
    XCTAssertNotNil(question4, "question is not nil");
    
    // Team1 gets to answer.
    XCTAssert(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    
    // Team1 answers right
    // Team 2 gets to go next. Team1's score is updated.
    result = [jm questionAnswered:YES];
    XCTAssert(result, "Result after first right answer");
    XCTAssertFalse(jm.team1.canAnswer, "team1.canAnswer");
    XCTAssertFalse(jm.team2.canAnswer, "team2.canAnswer");
    XCTAssertFalse(jm.team3.canAnswer, "team3.canAnswer");
    XCTAssertFalse(jm.team1.canChooseQuestion, "team1.canChooseQuestion");
    XCTAssert(jm.team2.canChooseQuestion, "team2.canChooseQuestion");
    XCTAssertFalse(jm.team3.canChooseQuestion, "team3.canChooseQuestion");
    XCTAssert(jm.team1.score == question2.pointValue + question4.pointValue, "team1.score");
    XCTAssert(jm.team2.score == 0, "team2.score");
    XCTAssert(jm.team3.score == question3.pointValue, "team3.score");
    
    XCTAssertFalse([jm checkGameOver], "checkGameOver");
}

@end