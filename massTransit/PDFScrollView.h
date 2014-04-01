//
//  PDFScrollView.h
//  massTransit
//
//  Created by Christina Francis on 11/9/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "TiledPDFView.h"


@interface PDFScrollView : UIScrollView <UIScrollViewDelegate>
{


  CGPDFPageRef _PDFPage;
  
  // Current PDF zoom scale.
  CGFloat _PDFScale;

}

@property (assign, nonatomic) CGPDFPageRef PDFPage;
@property (assign) CGFloat PDFScale;

// A low resolution image of the PDF page that is displayed until the TiledPDFView renders its content.
@property (nonatomic, weak) UIImageView *backgroundImageView;

// The TiledPDFView that is currently front most.
@property (nonatomic, weak) TiledPDFView *tiledPDFView;

// The old TiledPDFView that we draw on top of when the zooming stops.
@property (nonatomic, weak) TiledPDFView *oldTiledPDFView;

- (void)setPDFPage:(CGPDFPageRef)PDFPage;

@end
