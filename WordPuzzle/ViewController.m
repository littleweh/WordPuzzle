//
//  ViewController.m
//  WordPuzzle
//
//  Created by Ada Kao on 12/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "WordPuzzleView.h"

@interface ViewController ()
@property (assign, nonatomic, readwrite) int wordBoxSize;
@property (strong, nonatomic, readwrite) NSMutableArray* words2DArray;
@property (strong, nonatomic, readwrite) WordPuzzleView *gameView;
@property (strong, nonatomic, readwrite) UITextField * myTextField;
@property (assign, nonatomic, readwrite) CGPoint wordPositionInModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.wordBoxSize = 8;
    
    NSMutableArray* numbers = [NSMutableArray arrayWithCapacity:64];
    
    // For test
    for (int i =0; i<self.wordBoxSize * self.wordBoxSize; i++) {
        numbers[i] = [[NSString alloc]initWithFormat:@"%i", i+1];
    }
    self.words2DArray = [self setWords2DArrayWithSquareLength:self.wordBoxSize Words:numbers];
    [self showWords2DArrayContent];

    self.gameView = [[WordPuzzleView alloc] initWithFrame:CGRectMake(50, 50, 200, 300)];
    [self.view addSubview:self.gameView];
    [self setupGameView];
    [self.gameView setDelegate:self];
    
    self.myTextField = [[UITextField alloc] init];
    [self.gameView addSubview:self.myTextField];
    [self setupMyTextField];
    [self.myTextField setDelegate:self];

    NSLog(@"after");
    
    [self addTapGestureRecognizerToGameView];
    
}

-(void) setupMyTextField {
    self.myTextField.textAlignment = NSTextAlignmentCenter;
    self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    self.myTextField.borderStyle = UITextBorderStyleNone;
    self.myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.myTextField.keyboardType = UIKeyboardTypeDefault;
    // ToDo: returnkey Enter
    self.myTextField.returnKeyType = UIReturnKeyDone;
    self.myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

-(void) addTapGestureRecognizerToGameView {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.gameView action:@selector(calculateTouchPointInWhichCellByHandlingGestureRecognizerBy:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [self.gameView addGestureRecognizer:tapGestureRecognizer];
}

// MARK: UITextField delegate func implementation
-(BOOL)textFieldShouldBeginEditing: (UITextField *) textField {
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor whiteColor];
    textField.textColor = [UIColor blackColor];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *) textField {
    NSLog(@"textFieldDidBeginEditing");
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"textField:shouldChangeChar...");
    if ([string isEqualToString:@"#"]) {
        return NO;
    } else {
        return YES;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.words2DArray[(NSInteger) self.wordPositionInModel.x][(NSInteger) self.wordPositionInModel.y] = textField.text;
    textField.text = nil;
    [textField setHidden:YES];
    [self.gameView setNeedsLayout];
    return YES;
}

// MARK: WordPuzzleView delegate func implementation
- (NSMutableArray *)modelForWordPuzzleView:(WordPuzzleView *)myPuzzleView {
    return self.words2DArray;
}

-(void) textFieldInOrigin: (CGPoint) cellOrigin WithCellLength: (CGFloat) cellLength AndCellModelCoordinate: (CGPoint) cellCooridnate {
    CGFloat borderWidth = 2.0;
    CGRect rect = CGRectMake(cellOrigin.x - borderWidth,
                             cellOrigin.y - borderWidth,
                             cellLength+ 2 * borderWidth,
                             cellLength + 2 * borderWidth);
    self.wordPositionInModel = cellCooridnate;
    self.myTextField.frame = rect;
    self.myTextField.placeholder = self.words2DArray[(NSInteger) cellCooridnate.x][(NSInteger) cellCooridnate.y];
    
    [self.myTextField setHidden:NO];
    [self.myTextField becomeFirstResponder];
    
}

// MARK: Model
-(NSMutableArray*) setWords2DArrayWithSquareLength: (int) boxLength Words: (NSMutableArray*) materials {
    NSMutableArray *words2DArray = [NSMutableArray array];
    NSInteger index = 0;
    for (int row = 0; row < boxLength; row++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int column =0; column < boxLength; column++) {
            [rowArray addObject:materials[index++]];
        }
        [words2DArray addObject:rowArray];
    }
    return words2DArray;
}

// MARK: UI
-(void) setupGameView {
    self.gameView.backgroundColor = [UIColor clearColor];
    self.gameView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.gameView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0
                                                                constant:0.0];

    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.gameView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.gameView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                  toItem:self.view.layoutMarginsGuide
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:10.0];

    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.gameView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                   toItem:self.view.layoutMarginsGuide
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-10.0];

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.gameView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:self.view.layoutMarginsGuide
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:10.0];

    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.gameView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                 toItem:self.view.layoutMarginsGuide
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:-10.0];

    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
    [self.view addConstraint:leading];
    [self.view addConstraint:trailing];
    [self.view addConstraint:top];
    [self.view addConstraint:bottom];

    [self.view layoutIfNeeded];

}


// MARK: FOR TEST
-(void) showWords2DArrayContent {
    for (int i = 0; i < self.words2DArray.count; i++) {
        NSMutableArray *columnArray = self.words2DArray[i];
        for (int j = 0; j < columnArray.count; j++) {
            NSLog(@"%@", self.self.words2DArray[i][j]);
        }
    }
}

@end
