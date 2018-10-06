//
//  ScrollView.swift
//  UIScrollView_p1_v3
//
//  Created by macbook pro  on 8/25/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a photo
        //add photo to scrollView
        photo = UIImageView(image: UIImage(named: "dark.jpg"))
        let scrollViewSize = scrollView.frame.size
        let photoBounds = photo.bounds
        
        photo.frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)
        photo.contentMode = .ScaleAspectFit
        scrollView.contentSize = CGSizeMake(photoBounds.width, photoBounds.height)
        self.scrollView.addSubview(photo)
        
        //zoom
        photo.userInteractionEnabled = true
        photo.multipleTouchEnabled = true
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        
        //single tap, zoom in
        let tap = UITapGestureRecognizer(target: self, action: Selector("zoomIn:"))
        tap.numberOfTapsRequired = 1
        photo.addGestureRecognizer(tap)
        
        //double tap, zoom out
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector("zoomOut:"))
        doubleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(doubleTap)
        photo.addGestureRecognizer(doubleTap)
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    //func zoom
    func zoom(scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        scrollView.zoomToRect(zoomRect, animated: true)
    }
    
    //func zoom in
    func zoomIn(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photo)
        zoom(scrollView.zoomScale * 1.5, center: position)
    }
    
    //func zoom out
    func zoomOut(gesture: UITapGestureRecognizer) {
        let position = gesture.locationInView(photo)
        zoom(scrollView.zoomScale * -1.5, center: position)
    }
    
    //func zoom by slider
    @IBAction func sliderAction(sender: UISlider) {
        let scale = CGFloat(sender.value - 0.5) * 2 + 1
        zoom(scale, center: photo.center)
    }
    
}
