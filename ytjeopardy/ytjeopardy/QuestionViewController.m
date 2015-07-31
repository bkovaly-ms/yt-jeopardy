//
//  QuetionViewController.m
//  ytjeopardy
//
//  Created by Yarelly Janet Gomez on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *rightAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *wrongAnswerButton;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *pointValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamName;

@end

@implementation QuestionViewController
- (IBAction)rightAnswerButton:(id)sender {
    
}
- (IBAction)wrongAnswerButton:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //adds border to button to make it easier for the user to identify it as a button as opposed to a label
    self.rightAnswerButton.backgroundColor=[UIColor whiteColor];
    self.rightAnswerButton.layer.cornerRadius = 10;
    
    self.wrongAnswerButton.backgroundColor=[UIColor whiteColor];
    self.wrongAnswerButton.layer.cornerRadius = 10;
    
    //string displays category for jeopardy
<<<<<<< Updated upstream
   // self.category.text =self.question.category;
=======
    self.category.text =[NSString stringWithFormat:@"Debug%@",self.question.category ];
>>>>>>> Stashed changes
    
    //this string displays how many points to go hand in hand with the category string on the top of the screen
    self.pointValueLabel.text = [NSString stringWithFormat:@"100 Points%ld", self.question.pointValue];
    
    //this string displays the label that identifies what team is currently nswering the question
    self.teamName.text=[NSString stringWithFormat:@"Team %@",self.question.teamName];
    
    //this label is going to show the user how much time they have left
    self.timer.text=[NSString stringWithFormat:@"Time left: %ld", self.question.time];

}








@end
