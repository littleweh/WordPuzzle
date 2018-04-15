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
@property (assign, nonatomic) NSInteger rowNumber;
@property (assign, nonatomic) CGFloat cellLength;
@property (strong, nonatomic) NSMutableArray *puzzleModel;
@property (assign, nonatomic) double fontSizeFromCellSize;
@end

@implementation WordPuzzleView

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat padding = 2.0;
    self.fontSizeFromCellSize = 0.6;

    self.tableLength = MIN(self.frame.size.width, self.frame.size.height) - padding;
    self.tableOrigin = CGPointMake((self.frame.size.width - self.tableLength) / 2,
                                   (self.frame.size.height - self.tableLength) / 2);
    if ([self.delegate respondsToSelector:@selector(modelForWordPuzzleView:)]) {
        self.puzzleModel = [self.delegate modelForWordPuzzleView:self];
        self.rowNumber = self.puzzleModel.count;
        self.cellLength = self.tableLength / self.rowNumber;
        [self drawTableCell];
        [self drawWords];
    }

}

-(void) drawTextFieldInCellCoordinateByHandlingGestureRecognizerBy: (UITapGestureRecognizer*) tapRecognizer {

    CGPoint touchPoint = [tapRecognizer locationInView:self];

    NSInteger x = (touchPoint.x - self.tableOrigin.x ) / self.cellLength;
    NSInteger y = (touchPoint.y - self.tableOrigin.y ) / self.cellLength;

    NSLog(@"x: %d, y: %d ", x, y);
    if ( x >=0 && x <self.rowNumber && y >=0 && y <self.rowNumber) {
        CGPoint cellOrigin = CGPointMake(x * self.cellLength + self.tableOrigin.x,
                                         y * self.cellLength + self.tableOrigin.y);
        CGRect rect = CGRectMake(cellOrigin.x,
                                 cellOrigin.y,
                                 self.cellLength,
                                 self.cellLength);

        double fontSize = self.cellLength * self.fontSizeFromCellSize;

        self.myTextField = [[UITextField alloc]initWithFrame:rect];
        self.myTextField.backgroundColor = [UIColor yellowColor];
        self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.myTextField.keyboardType = UIKeyboardTypeDefault;
        self.myTextField.returnKeyType = UIReturnKeyDefault;
        self.myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.myTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.myTextField.placeholder = self.puzzleModel[y][x];
        self.myTextField.font = [UIFont fontWithName:@"Helvetica" size:fontSize-2];
        NSLog(@"myTextField Frame: %@", NSStringFromCGRect(rect));
        [self addSubview:self.myTextField];
    }


}

-(void) drawTableCell {
    UIBezierPath *tablePath = [UIBezierPath bezierPath];
    for (int i = 0; i <= self.rowNumber; i++) {
        // row
        [tablePath moveToPoint:CGPointMake(self.tableOrigin.x,
                                         self.tableOrigin.y + i * self.cellLength)];
        [tablePath addLineToPoint:CGPointMake(self.tableOrigin.x + self.tableLength,
                                            self.tableOrigin.y + i * self.cellLength)];
        // column
        [tablePath moveToPoint:CGPointMake(self.tableOrigin.x + i * self.cellLength,
                                         self.tableOrigin.y)];
        [tablePath addLineToPoint:CGPointMake(self.tableOrigin.x + i * self.cellLength,
                                            self.tableOrigin.y + self.tableLength)];
        
    }
    [tablePath closePath];
    tablePath.lineWidth = 1.0;
    [tablePath stroke];

}

-(void) drawWords {
    double fontSize = self.cellLength * self.fontSizeFromCellSize;
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:fontSize],
                                 NSStrokeWidthAttributeName: @(0),
                                 NSStrokeColorAttributeName: [UIColor blackColor],
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 
                                 };

    for (int i = 0; i < self.rowNumber; i++) {
        for (int j = 0; j < self.rowNumber; j++) {
            NSString *myString = [[NSString alloc] initWithFormat:@"%@", self.puzzleModel[i][j]];
            NSAttributedString *word = [[NSAttributedString alloc]initWithString:myString attributes:attributes];
            [word drawInRect:CGRectMake(self.tableOrigin.x + j * self.cellLength,
                                        self.tableOrigin.y + i * self.cellLength + (self.cellLength - fontSize) * 0.4,
                                        self.cellLength,
                                        self.cellLength)];
        }
    }

}


@end
