//
//  ViewController.swift
//  Canvas
//
//  Created by Taylor McLaughlin on 10/22/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var theArrowImage: UIImageView!
    @IBOutlet weak var face1: UIImageView!
    @IBOutlet weak var face2: UIImageView!
    @IBOutlet weak var face3: UIImageView!
    @IBOutlet weak var face4: UIImageView!
    @IBOutlet weak var face5: UIImageView!
    @IBOutlet weak var face6: UIImageView!
    
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    let trayDownOffset = 215.0
    var translation: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + CGFloat(trayDownOffset))
        trayOriginalCenter = trayView.center
        trayUp = trayOriginalCenter
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPan(_ sender: UIPanGestureRecognizer) {
        self.translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        if sender.state == .began {
            // When dragging begins, save where the center was (or started)
            trayOriginalCenter = trayView.center
        }
        if sender.state == .changed {
            // As I keep dragging, extract the up or down
            // translation and reset the center of the tray
            let Y = translation.y
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + Y)
        }
        if sender.state == .ended {
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.trayView.center = self.trayDown
                }) { (completed) in
                    self.theArrowImage.image = UIImage(named: "up_arrow")
                }
            } else {
                UIView.animate(withDuration: 0.1, animations: {
                    self.trayView.center = self.trayUp
                }) { (completed) in
                    self.theArrowImage.image = UIImage(named: "down_arrow")
                }
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        self.translation = sender.translation(in: view)
        if sender.state == .began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        }
        if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        if sender.state == .ended {
            
        }
    }
    
}

