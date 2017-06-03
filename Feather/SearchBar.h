//
//  SearchBar.h
//  Feather
//
//  Created by Renata Guttenová on 21/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchBarDelegate <NSObject>
- (void)textDidChange:(NSString *)text;
@end

@interface SearchBar : UIView
@property (nonatomic, weak) id<SearchBarDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *view;


@end
