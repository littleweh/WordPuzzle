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
    
    self.gameView = [[WordPuzzleView alloc] initWithFrame:CGRectMake(50, 50 , 300, 400)];
    self.gameView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.gameView];

    
}

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
