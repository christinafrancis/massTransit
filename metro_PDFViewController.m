//
//  metro_PDFViewController.m
//  massTransit
//
//  Created by Christina Francis on 11/6/13.
//  Copyright (c) 2013 Christina Francis. All rights reserved.
//

#import "metro_PDFViewController.h"
#import "PDFScrollView.h"


@interface metro_PDFViewController ()

@end

@implementation metro_PDFViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
     Open the PDF document, extract the first page, and pass the page to the PDF scroll view.
     */
    NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:@"metrolink_system_map" withExtension:@"pdf"];
    
    CGPDFDocumentRef PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);
    
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(PDFDocument, 1);
    [(PDFScrollView *)self.view setPDFPage:PDFPage];
    
    CGPDFDocumentRelease(PDFDocument);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
