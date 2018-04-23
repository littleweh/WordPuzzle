//
//  WordPuzzleView.h
//  WordPuzzle
//
//  Created by Ada Kao on 13/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASWordPuzzleView;

@protocol ASWordPuzzleViewDelegate <NSObject>
-(NSMutableArray*) modelForWordPuzzleView: (ASWordPuzzleView*) myPuzzleView;
-(void) wordPuzzleViewWillReturnTextFieldPositionWithOrigin: (CGPoint) cellOrigin cellLength: (CGFloat) cellLength cellModelCoordinate: (CGPoint) cellCooridnate;
@end

@interface ASWordPuzzleView : UIView
@property (weak, nonatomic) id<ASWordPuzzleViewDelegate> delegate;
-(void) calculateTouchPointInWhichCellByHandlingGestureRecognizerBy: (UITapGestureRecognizer *) tapRecognizer;
@end
