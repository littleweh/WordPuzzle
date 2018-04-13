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
    CGFloat padding = 2.0;
    self.tableLength = MIN(self.frame.size.width, self.frame.size.height) - padding;
    self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
    NSUInteger rowNum = self.puzzleModel.count;
//    [self drawTableCellWithRowNumber:rowNum];
    [self drawTableCellWithRowNumber:8 AndPadding:padding / 2];

}

-(void) drawTableCellWithRowNumber: (NSUInteger) number AndPadding: (CGFloat) padding  {
    UIBezierPath *rowPath = [UIBezierPath bezierPath];
    for (int i = 0; i <= number; i++) {
        [rowPath moveToPoint:CGPointMake(0, self.tableLength * i / number + padding)];
        [rowPath addLineToPoint:CGPointMake(self.tableLength, self.tableLength * i / number + padding)];
        [rowPath moveToPoint:CGPointMake(self.tableLength * i / number + padding, 0)];
        [rowPath addLineToPoint:CGPointMake(self.tableLength * i / number  + padding, self.tableLength)];
    }
    [rowPath closePath];
    rowPath.lineWidth = 1.0;
    [rowPath stroke];


}


@end
