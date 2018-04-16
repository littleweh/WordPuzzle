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
//-(void) showTextField: (WordPuzzleView*) myPuzzleView gestureRecognizer: (UITapGestureRecognizer*) recognizer;
@end

@interface WordPuzzleView : UIView
@property (weak, nonatomic) id<WordPuzzleViewDelegate> delegate;
@property (strong, nonatomic) UITextField* myTextField;
-(void) drawTextFieldInCellCoordinateByHandlingGestureRecognizerBy: (UITapGestureRecognizer*) tapRecognizer;
@end
