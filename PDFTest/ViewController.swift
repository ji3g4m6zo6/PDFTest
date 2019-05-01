//
//  ViewController.swift
//  PDFTest
//
//  Created by Jia on 2019/5/1.
//  Copyright © 2019 Jia. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController, PDFViewDelegate {
    @IBOutlet var pdfView: PDFView!
    var savedDestinationPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerObserver), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.document = pdfDocument
            }
        }
    }
    
    @objc func timerObserver() {
//        print(pdfView.currentDestination!.point)
//        print(pdfView.scaleFactor)
//        print(pdfView.currentPage!)
//        print(pdfView.documentView!.bounds)
    }
    
    @IBAction func setDirectionPoint(_ sender: Any) {
        let pageRect = pdfView.document!.page(at: 0)!.pageRef!.getBoxRect(CGPDFBox.mediaBox)
        pdfView.go(to: PDFDestination(page: pdfView.document!.page(at: 0)!, at: CGPoint(x: savedDestinationPoint.x, y: pageRect.size.height - (self.view.frame.size.height - pdfView.frame.size.height - 21) + savedDestinationPoint.y)))
    }
    
    @IBAction func getDirectionPoint(_ sender: Any) {
        savedDestinationPoint = pdfView.currentDestination!.point
    }
}

