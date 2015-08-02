//
//  QuestionsCollectionViewController.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 8/1/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "QuestionsCollectionViewController.h"
#import "QuestionsCollectionViewCell.h"
#import "JeopardyManager.h"
#import "QuestionRetriever.h"
#import "Question.h"
#import "QuestionViewController.h"

#define _RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COUNT_OF_CATEGORIES 4
#define QUESTIONS_IN_CATEGORIES 5

@interface QuestionsCollectionViewController ()

@property UIColor *categoryBackgroundColor;
@property UIColor *categoryTextColor;
@property UIColor *questionBackgroundColor;
@property UIColor *questionTextColor;
@property UIColor *answeredQuestionTextColor;
@property NSArray *questions;
@property NSArray *categories;

@end

@implementation QuestionsCollectionViewController

static NSString * const reuseIdentifier = @"JeopardyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // Don't do this, else it will override what's in the storyboard
    // [self.collectionView registerClass:[QuestionsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self setupColors];
    [self initBoard];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initBoard
{
    static BOOL isBoardInitialized = NO;
    
    if (self.jm && !isBoardInitialized)
    {
        self.categories = [self setupCategories];
        self.questions = [self setupQuestions];
        isBoardInitialized = YES;
    }
}

- (NSArray *) setupCategories
{
    NSMutableArray *categories = [NSMutableArray arrayWithCapacity:COUNT_OF_CATEGORIES];
    categories[0] = @"Syntax";
    categories[1] = @"Debugging";
    categories[2] = @"Language";
    categories[3] = @"Write It";
    return categories;
}

- (void) setupColors
{
    self.categoryBackgroundColor = _RGB(45, 52, 230, 1.0);
    self.questionBackgroundColor = _RGB(31, 36, 163, 1.0);
    self.categoryTextColor = _RGB(255, 255, 0, 1.0);
    self.questionTextColor =  _RGB(255, 255, 0, 1.0);
    
}

- (NSArray *) setupQuestions
{
    NSMutableArray *questions = [NSMutableArray arrayWithCapacity:self.categories.count];
    QuestionRetriever *qr = self.jm.qr;
    
    for (int i = 0; i < self.categories.count; i++)
    {
        NSMutableArray *questionsInCategory = [NSMutableArray arrayWithCapacity:QUESTIONS_IN_CATEGORIES];
        for (int j = 0; j < QUESTIONS_IN_CATEGORIES; j++)
        {
            questionsInCategory[j] = [qr questionForCategory:self.categories[i] index:j];
        }
        
        questions[i] = questionsInCategory;
    }
    
    return questions;
}

- (Question *) questionAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *questionsForCategory = self.questions[indexPath.row];
    Question *question = questionsForCategory[indexPath.section - 1];
    return question;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return QUESTIONS_IN_CATEGORIES + 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return COUNT_OF_CATEGORIES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return [self getCellForCategory:indexPath forCollectionView:collectionView];
    }
    else
    {
        return [self getCellForQuestion:indexPath forCollectionView:collectionView];
    }
}

- (UICollectionViewCell *) getCellForCategory:(NSIndexPath *)indexPath forCollectionView:(UICollectionView *)collectionView
{
    QuestionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.categoryBackgroundColor;
    cell.displayLabel.text = [self.categories[indexPath.row] uppercaseString];
    cell.displayLabel.textColor = [UIColor yellowColor];
    [cell.displayLabel setFont:[UIFont systemFontOfSize:18.0]];
    return cell;
}

- (UICollectionViewCell *) getCellForQuestion:(NSIndexPath *)indexPath forCollectionView:(UICollectionView *)collectionView
{
    QuestionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.questionBackgroundColor;
    int points = (int)indexPath.section * 100;
    cell.displayLabel.text = [NSString stringWithFormat:@"$%d", points];
    [cell.displayLabel setFont:[UIFont systemFontOfSize:40.0 weight:10]];
    
    if ([self questionAtIndexPath:indexPath].questionAsked)
    {
        cell.displayLabel.textColor = [UIColor grayColor];
    }
    else
    {
        cell.displayLabel.textColor = [UIColor yellowColor];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int frameWidth = self.view.frame.size.width;
    int frameHeight = self.view.frame.size.height;
    return CGSizeMake(frameWidth/COUNT_OF_CATEGORIES - 20, frameHeight/(QUESTIONS_IN_CATEGORIES + 1) - 20);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);   //t,l,b,r
}

#pragma mark <UICollectionViewDelegate>

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        return NO;
    }
    else
    {
        Question *question = [self questionAtIndexPath:indexPath];
        if (question.questionAsked)
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Question *question = [self.jm startQuestionForCategory:self.categories[indexPath.row] index:(indexPath.section - 1)];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    QuestionViewController *destination = [[UIStoryboard storyboardWithName:@"Question" bundle:nil] instantiateInitialViewController];
    destination.question = question;
    [self presentViewController:destination animated:YES completion:nil];
}

@end
