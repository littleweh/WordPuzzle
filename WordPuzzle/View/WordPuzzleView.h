//
//  WordPuzzleView.h
//  WordPuzzle
//
//  Created by Ada Kao on 13/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordPuzzleView;

@protocol WordPuzzleViewDelegate <NSObject>
-(NSMutableArray*) modelForWordPuzzleView: (WordPuzzleView*) myPuzzleView;
-(void) textFieldInOrigin: (CGPoint) cellOrigin WithCellLength: (CGFloat) cellLength AndCellModelCoordinate: (CGPoint) cellCooridnate;
@end

@interface WordPuzzleView : UIView
@property (weak, nonatomic) id<WordPuzzleViewDelegate> delegate;
-(void) calculateTouchPointInWhichCellByHandlingGestureRecognizerBy: (UITapGestureRecognizer *) tapRecognizer;
@end
