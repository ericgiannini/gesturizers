//
//  ViewController.swift
//  gesturizers
//
//  Created by Eric Giannini on 4/17/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var gestureView: UIView = {
        
        let gestureView = UIView()
        gestureView.frame = CGRect(x: 40, y: 40, width: 200, height: 80)
        gestureView.backgroundColor = .blue
        gestureView.isUserInteractionEnabled = true
        
        return gestureView
    }()
    
    lazy private var panRecognizer: UIGestureRecognizer = {
        
        let panRecognizer: UIGestureRecognizer = UIPanGestureRecognizer(target: self, action:#selector(didTapPanGesture))
        panRecognizer.delegate = self
        return panRecognizer
    }()
    
    lazy private var pinchRecognizer: UIGestureRecognizer = {
        
        let pinchRecognizer: UIGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchGesture))
        pinchRecognizer.delegate = self
        return pinchRecognizer
    }()
    
    lazy private var rotateRecognizer: UIGestureRecognizer = {
        
        let rotateRecognizer: UIGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotateGesture))
        rotateRecognizer.delegate = self
        return rotateRecognizer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        [panRecognizer, pinchRecognizer, rotateRecognizer].forEach(gestureView.addGestureRecognizer)
        
        view.addSubview(gestureView)
    
        
    }
    
    
    func didTapPanGesture(panRecognizer: UIPanGestureRecognizer) {
        
        // `translationInView` is a method that let's us manipulate the x, y coordinates of the draggableView
        
        let draggableTranslation = panRecognizer.translation(in: self.view)
        
        
        /* optional binding to ensure that draggableView is not nil; if not nil, program draggableView to shift its x, y coordinates by adding its center to the center moved
         
         */
        
        if let draggableView = panRecognizer.view {
            print("Center: \(view.center))")
            print("Transform: \(view.transform)")
            draggableView.center = CGPoint(x: draggableView.center.x + draggableTranslation.x, y: draggableView.center.y + draggableTranslation.y)
        }
        print("Dragging : \(gestureView.center)")
        
        // after having programmed the draggableView, set the "draggability" to the recognizer
        
        panRecognizer.setTranslation( CGPoint.zero, in: gestureView)
    }
    
    func didPinchGesture(pinchRecognizer : UIPinchGestureRecognizer) {
        
        /*
         
         Ensure view is set to the pinchRecognizer's view with optional binding; if not nil, set view's transform property to result of the scaledBy(:) method, which transforms the x & y coordinates to the pinched view (i.e., % of scale).
         
         */
        
        if let view = pinchRecognizer.view {
            print("Center: \(view.center))")
            print("Transform: \(view.transform)")
            
            view.transform = view.transform.scaledBy(x: pinchRecognizer.scale, y: pinchRecognizer.scale)
            print("Pinch : \(pinchRecognizer.scale)")
            
            // reset the scale
            pinchRecognizer.scale = 1
        }
    }
    
    
    func didRotateGesture(rotateRecognizer: UIRotationGestureRecognizer) {
        
        /*
         
         Process identical to pinch; ensure view is set to the rotateRecognizer's view with optional binding; if not nil, set view's transform property to result of the rotate(by:) method, which transforms rotation to the rotated view (i.e., % of rotation).


         */
        
        if let view = rotateRecognizer.view {
            let rotation: CGFloat = rotateRecognizer.rotation
            
            view.transform = view.transform.rotated(by: rotation)
            
            print("Rotation : \(rotateRecognizer.rotation)")
            
            // reset the rotation
            rotateRecognizer.rotation = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : UIGestureRecognizerDelegate {
    // required delegate method for gestures without any customization
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

