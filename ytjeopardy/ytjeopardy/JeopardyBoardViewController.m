//
//  JeopardyBoardViewController.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 8/2/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "JeopardyBoardViewController.h"
#import "JeopardyManager.h"
#import "QuestionsCollectionViewController.h"

#import "Team.h"

@interface JeopardyBoardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *team1NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *team3NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team3ScoreLabel;

@property JeopardyManager *jm;
@end

@implementation JeopardyBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jm = [JeopardyManager sharedInstance];
    
    self.team1NameLabel.text = self.jm.team1.name;
    self.team2NameLabel.text = self.jm.team2.name;
    self.team3NameLabel.text = self.jm.team3.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.team1ScoreLabel.text = [NSString stringWithFormat:@"%ld", self.jm.team1.score];
    self.team2ScoreLabel.text = [NSString stringWithFormat:@"%ld", self.jm.team2.score];
    self.team3ScoreLabel.text = [NSString stringWithFormat:@"%ld", self.jm.team3.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (self.jm == nil)
    {
        self.jm = [JeopardyManager sharedInstance];
    }
    
    if ([segue.identifier isEqualToString:@"QuestionBoardSegue"])
    {
        QuestionsCollectionViewController *destination = segue.destinationViewController;
        destination.jm = self.jm;
    }
}

@end
