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
    if ([self.delegate respondsToSelector:@selector(modelForWordPuzzleView:)]) {
        self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
        NSUInteger rowNum = self.puzzleModel.count;
        [self drawTableCellWithRowNumber:rowNum];
        [self drawWordsWithRowNumber:rowNum];
    }

}

-(void) drawTextFieldInCellCoordinateByHandlingGestureRecognizerBy: (UITapGestureRecognizer*) tapRecognizer {

    CGPoint touchPoint = [tapRecognizer locationInView:self];

    NSInteger x = (touchPoint.x - self.tableOrigin.x ) / self.tableLength * self.puzzleModel.count;
    NSInteger y = (touchPoint.y - self.tableOrigin.y ) / self.tableLength * self.puzzleModel.count;

    NSLog(@"x: %d, y: %d ", x, y);

    CGPoint cellOrigin = CGPointMake(x * self.tableLength + self.tableOrigin.x,
                                     y * self.tableLength + self.tableOrigin.y);
    CGRect rect = CGRectMake(cellOrigin.x,
                             cellOrigin.y,
                             self.tableLength / self.puzzleModel.count,
                             self.tableLength / self.puzzleModel.count);

    self.myTextField = [[UITextField alloc]initWithFrame:rect];
    self.myTextField.backgroundColor = [UIColor yellowColor];
    self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.myTextField.placeholder = self.puzzleModel[x][y];
    self.myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.myTextField.keyboardType = UIKeyboardTypeDefault;
    self.myTextField.returnKeyType = UIReturnKeyDefault;
    self.myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NSLog(@"myTextField Frame: %@", NSStringFromCGRect(rect));
    [self addSubview:self.myTextField];
}

-(void) drawTableCellWithRowNumber: (NSUInteger) number {

    NSAssert(number != 0, @"number should not be empty");

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

-(void) drawWordsWithRowNumber: (NSUInteger) number {
    CGSize cellSize = CGSizeMake(self.tableLength / number, self.tableLength / number);
    double fontSize = cellSize.width * 0.6;
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:fontSize],
                                 NSStrokeWidthAttributeName: @(0),
                                 NSStrokeColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 
                                 };

    for (int i = 0; i < number; i++) {
        for (int j = 0; j < number; j++) {
            NSString *myString = [[NSString alloc] initWithFormat:@"%@", self.puzzleModel[i][j]];
            NSAttributedString *word = [[NSAttributedString alloc]initWithString:myString attributes:attributes];
            [word drawInRect:CGRectMake(self.tableOrigin.x + j * (self.tableLength / number),
                                        self.tableOrigin.y + i * (self.tableLength / number) + (cellSize.height - fontSize) * 0.4,
                                        cellSize.width,
                                        cellSize.height)];
        }
    }

}


@end
