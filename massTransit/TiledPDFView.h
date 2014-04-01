//
//  TiledPDFView.h
//  massTransit
//
//  Created by Christina Francis on 11/10/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TiledPDFView : UIView
{
  CGPDFPageRef _pdfPage;
  CGFloat _myScale;
}

@property (assign) CGPDFPageRef pdfPage;
@property (assign) CGFloat myScale;


- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;
- (void)setPage:(CGPDFPageRef)newPage;

@end
