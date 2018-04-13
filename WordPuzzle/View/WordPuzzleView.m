//
//  WordPuzzleView.m
//  WordPuzzle
//
//  Created by Ada Kao on 13/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "WordPuzzleView.h"

@interface WordPuzzleView()
@property (assign, nonatomic) CGFloat tableLength;
@property (strong, nonatomic) NSMutableArray *puzzleModel;
@end

@implementation WordPuzzleView


- (void)drawRect:(CGRect)rect {
    self.tableLength = MIN(self.frame.size.width, self.frame.size.height);
    self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
    NSUInteger rowNum = self.puzzleModel.count;
    [self drawTableCellWithRowNumber:rowNum];
    
    
    
}

-(void) drawTableCellWithRowNumber: (NSUInteger) number {
    for (int i = 0; i <= number; i++) {
        UIBezierPath *rowPath = [UIBezierPath bezierPath];
        [rowPath moveToPoint:CGPointMake(0, self.tableLength / number)];
        [rowPath addLineToPoint:CGPointMake(self.tableLength, self.tableLength / number)];
        [rowPath closePath];
        rowPath.lineWidth = 2.0;
        [rowPath stroke];
    }
}


@end
