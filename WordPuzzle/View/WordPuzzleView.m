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

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGFloat padding = 2.0;
    self.tableLength = MIN(self.frame.size.width, self.frame.size.height) - padding;
    self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
    NSUInteger rowNum = self.puzzleModel.count;
//    [self drawTableCellWithRowNumber:rowNum];
    [self drawTableCellWithRowNumber:8 AndPadding:padding / 2];

}

-(void) drawTableCellWithRowNumber: (NSUInteger) number AndPadding: (CGFloat) padding  {
    CGPoint tableOrigin = CGPointMake((self.frame.size.width - self.tableLength) / 2, (self.frame.size.height - self.tableLength) / 2);

    UIBezierPath *rowPath = [UIBezierPath bezierPath];
    for (int i = 0; i <= number; i++) {
        [rowPath moveToPoint:CGPointMake(tableOrigin.x, tableOrigin.y + self.tableLength * i / number)];
        [rowPath addLineToPoint:CGPointMake(tableOrigin.x + self.tableLength, tableOrigin.y + self.tableLength * i / number)];
        [rowPath moveToPoint:CGPointMake(tableOrigin .x + self.tableLength * i / number, tableOrigin.y)];
        [rowPath addLineToPoint:CGPointMake(tableOrigin.x + self.tableLength * i / number, tableOrigin.y + self.tableLength)];
    }
    [rowPath closePath];
    rowPath.lineWidth = 1.0;
    [rowPath stroke];


}


@end
