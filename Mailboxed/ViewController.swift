//
//  ViewController.swift
//  Mailboxed
//
//  Created by Loredana Crisan on 9/27/14.
//  Copyright (c) 2014 Loredana Crisan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var messagesImage: UIImageView!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // set size of scroll view
        
        var scrollHeight = CGFloat ()
        scrollHeight = messagesImage.frame.size.height + helpImage.frame.size.height + searchImage.frame.size.height + messageImage.frame.size.height

        feedScrollView.contentSize = CGSize (width: 320, height: scrollHeight)
        

        

    
    
    }
    @IBAction func panMessage(panGestureRecognizer: UIPanGestureRecognizer) {

        //get velocity, location and translation
        
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        //start settings the animations
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            
            // make the message move
            messageImage.frame.origin.x = translation.x
            println("Gesture changed at: \(point)")
            
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
        
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

