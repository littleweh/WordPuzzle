//
//  WordPuzzleView.h
//  WordPuzzle
//
//  Created by Ada Kao on 13/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordPuzzleView;

@protocol WordPuzzleViewDelegate
-(NSMutableArray*) modelForWordPuzzleView: (WordPuzzleView*) myPuzzleView;
@end

@interface WordPuzzleView : UIView
@property (weak, nonatomic) id<WordPuzzleViewDelegate> delegate;
@end
