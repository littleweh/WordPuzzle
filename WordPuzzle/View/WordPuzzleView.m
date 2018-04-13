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
@property (assign, nonatomic) CGPoint tableOrigin;
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
    self.tableOrigin = CGPointMake((self.frame.size.width - self.tableLength) / 2,
                                   (self.frame.size.height - self.tableLength) / 2);

    self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
    NSUInteger rowNum = self.puzzleModel.count;
    [self drawTableCellWithRowNumber:rowNum];
    [self drawWords];

}

-(void) drawTableCellWithRowNumber: (NSUInteger) number {
    
    UIBezierPath *tablePath = [UIBezierPath bezierPath];
    for (int i = 0; i <= number; i++) {
        // row
        [tablePath moveToPoint:CGPointMake(self.tableOrigin.x,
                                         self.tableOrigin.y + self.tableLength * i / number)];
        [tablePath addLineToPoint:CGPointMake(self.tableOrigin.x + self.tableLength,
                                            self.tableOrigin.y + self.tableLength * i / number)];
        // column
        [tablePath moveToPoint:CGPointMake(self.tableOrigin .x + self.tableLength * i / number,
                                         self.tableOrigin.y)];
        [tablePath addLineToPoint:CGPointMake(self.tableOrigin.x + self.tableLength * i / number,
                                            self.tableOrigin.y + self.tableLength)];
        
    }
    [tablePath closePath];
    tablePath.lineWidth = 1.0;
    [tablePath stroke];

}

-(void) drawWords {
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:35],
                                 NSStrokeWidthAttributeName: @(0),
                                 NSStrokeColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 
                                 };

    for (int i = 0; i <self.puzzleModel.count; i++) {
        NSMutableArray *wordsInRow = self.puzzleModel[i];
        for (int j = 0; j <wordsInRow.count; j++) {
            NSString *myString = [[NSString alloc] initWithFormat:@"%@", self.puzzleModel[i][j]];
            NSAttributedString *word = [[NSAttributedString alloc]initWithString:myString attributes:attributes];
            [word drawInRect:CGRectMake(self.tableOrigin.x + self.tableLength * j / self.puzzleModel.count,
                                        self.tableOrigin.y + self.tableLength * i / wordsInRow.count,
                                        self.tableLength / self.puzzleModel.count,
                                        self.tableLength / wordsInRow.count)];
        }
    }
//    NSString *first = [[NSString alloc]initWithFormat:@"%@", self.puzzleModel[0][0]];
//    NSAttributedString* firstWord = [[NSAttributedString alloc] initWithString:first attributes:attributes];
//    CGRect rect = CGRectMake(self.tableOrigin.x, self.tableOrigin.y, 100, 100);
//
////    [firstWord drawAtPoint:self.tableOrigin];
//    [firstWord drawInRect:rect];
}


@end
