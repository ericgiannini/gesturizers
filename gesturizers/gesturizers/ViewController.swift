//
//  ViewController.swift
//  gesturizers
//
//  Created by Eric Giannini on 4/17/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy private var leftGestureView: UIView = {
        
        let leftGestureView = UIView()
        leftGestureView.frame = CGRect(x: 40, y: 40, width: 200, height: 80)
        leftGestureView.backgroundColor = .blue
        leftGestureView.isUserInteractionEnabled = true
        
        return leftGestureView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let panRecognizer: UIGestureRecognizer = UIPanGestureRecognizer(target: self, action:#selector(didTapPanGesture))
        let pinchRecognizer: UIGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchGesture))
        let rotateRecognizer: UIGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotateGesture))
        
        //        let imageView = UIImageView()
        //        imageView.image = UIImage(named:"Tennis-Ball")
        //        draggableView.addSubview(imageView)
        
        leftGestureView.addGestureRecognizer(panRecognizer)
        leftGestureView.addGestureRecognizer(pinchRecognizer)
        leftGestureView.addGestureRecognizer(rotateRecognizer)
        
        panRecognizer.delegate = self
        pinchRecognizer.delegate = self
        rotateRecognizer.delegate = self
        
        view.addSubview(leftGestureView)
        
        /*
         
         [panRecognizer, pinchRecognizer, rotateRecognizer].forEach {draggableView.addGestureRecognizer($0)}
         
         [panRecognizer, pinchRecognizer, rotateRecognizer].forEach {$0.delegate = self}
         
         */
        
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
        print("Dragging : \(leftGestureView.center)")
        
        // after having programmed the draggableView, set the "draggability" to the recognizer
        
        panRecognizer.setTranslation( CGPoint.zero, in: leftGestureView)
    }
    
    func didPinchGesture(pinchRecognizer : UIPinchGestureRecognizer) {
        if let view = pinchRecognizer.view {
            print("Center: \(view.center))")
            print("Transform: \(view.transform)")
            
            view.transform = view.transform.scaledBy(x: pinchRecognizer.scale, y: pinchRecognizer.scale)
            print("Pinch : \(pinchRecognizer.scale)")
            pinchRecognizer.scale = 1
        }
    }
    
    
    func didRotateGesture(rotateRecognizer: UIRotationGestureRecognizer) {
        if let view = rotateRecognizer.view {
            let rotation: CGFloat = rotateRecognizer.rotation
            view.transform = view.transform.rotated(by: rotation)
            print("Rotation : \(rotateRecognizer.rotation)")
            rotateRecognizer.rotation = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

