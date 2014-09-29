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
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var messageX: CGFloat!
    var state: String!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // set size of scroll view
        
        var scrollHeight = CGFloat ()
        scrollHeight = messagesImage.frame.size.height + helpImage.frame.size.height + searchImage.frame.size.height + messageImage.frame.size.height

        feedScrollView.contentSize = CGSize (width: 320, height: scrollHeight)
        
        rescheduleImage.alpha = 0
        listImage.alpha = 0
        
      
        

        

    
    
    }
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        print ("tapped list")
        rescheduleImage.alpha = 0
    }
    
    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        print ("tapped list")
        listImage.alpha = 0
        
    }
    
    
    
    
    //begin pan actions
    
    @IBAction func panMessage(panGestureRecognizer: UIPanGestureRecognizer) {

        //get velocity, location and translation
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        

  
        
        
        
        //set states and responsive movement for message, icon and backgrounds
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
            //set default state for icons

            messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
            archiveIconImage.frame.origin.x = CGFloat(20)
            laterIconImage.frame.origin.x = CGFloat(280)
            archiveIconImage.image = UIImage(named: "archive_icon")
            laterIconImage.image = UIImage(named: "later_icon")
            laterIconImage.alpha = 1
            archiveIconImage.alpha = 1
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            
            // make the message and icons move
            messageImage.frame.origin.x = translation.x
            
            
            
            
            if messageImage.frame.origin.x > 0 && messageImage.frame.origin.x < 80 {
                
                state = "peek left"
                
                
                archiveIconImage.alpha = (translation.x / 80)
                messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
                
              
                print (state)
            
            
            
            
            } else if messageImage.frame.origin.x > 80 && messageImage.frame.origin.x < 200 {
                
                
                state = "archive"
                print (state)
                
                archiveIconImage.frame.origin.x =  20 + translation.x - 80
                messageView.backgroundColor = UIColor(red:0.4, green:0.69, blue:0.36, alpha:1.0)
                archiveIconImage.image = UIImage(named: "archive_icon")
                
            
            
            } else if messageImage.frame.origin.x > 200 {
                
                
                state = "delete"
                print (state)
                
                archiveIconImage.frame.origin.x =  20 + translation.x - 80
                messageView.backgroundColor = UIColor(red:0.89, green:0.16, blue:0.23, alpha:1.0)
                archiveIconImage.image = UIImage(named: "delete_icon")
                

                
            } else if messageImage.center.x < 160 &&  messageImage.center.x > 80 {
            
            
                state = "peek right"
                print (state)
                
                
                messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
                laterIconImage.image = UIImage(named: "later_icon")
                laterIconImage.alpha = -(translation.x / 80)

            

            
            } else if messageImage.center.x < 80 &&  messageImage.center.x > -40 {
                
                
                state = "later"
                print (state)
                
                
                messageView.backgroundColor = UIColor(red:1.0, green:0.84, blue:0.09, alpha:1.0)
                laterIconImage.image = UIImage(named: "later_icon")
                laterIconImage.frame.origin.x = 280 + 80 + translation.x
                
                print (laterIconImage.frame.origin.x)
                
                
            } else if messageImage.center.x < -40 {
                
                
                state = "todo"
                print (state)
                
                
                messageView.backgroundColor = UIColor(red:0.59, green:0.49, blue:0.4, alpha:1.0)
                laterIconImage.image = UIImage(named: "list_icon")
                laterIconImage.frame.origin.x = 280 + 80 + translation.x
                
                print (laterIconImage.frame.origin.x)
                
                
            }
            
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            
            
            if state == "peek left" || state == "peek right" {
                
                print("bouncback")
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = 0
                    }, completion: nil)
            
            
            } else if state == "archive" || state == "delete" {
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                () -> Void in
                self.messageImage.frame.origin.x = 350
                self.archiveIconImage.frame.origin.x = 350
                }, completion: {
                (value: Bool) in
                
                print("reset")
                    
                UIView.animateWithDuration(0.4, animations: {
                    self.messageImage.frame.origin.y -= 86
                    }, completion: {
                        (value: Bool) in
                        self.messageImage.frame.origin.y += 86
                        self.messageImage.frame.origin.x = 0
                        
                })
            
            })
                
            } else if state == "later" {
                print("later")
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = -350
                    self.laterIconImage.frame.origin.x = -350
                    }, completion: {
                        
                       
                        
                        (value: Bool) in
                         print("reset")
                        
                
                        
                UIView.animateWithDuration(0.4, animations: {
                    self.messageImage.frame.origin.y -= 86
                    }, completion: {
                        (value: Bool) in
                        self.messageImage.frame.origin.y += 86
                        self.messageImage.frame.origin.x = 0
                        self.rescheduleImage.alpha = 1
                        
                })

        })
                
            } else if state == "todo" {
                print("todo")
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = -350
                    self.laterIconImage.frame.origin.x = -350
                    }, completion: {
                        
                        
                        
                        (value: Bool) in
                        print("reset")
                        
                        
                        
                        UIView.animateWithDuration(0.4, animations: {
                            self.messageImage.frame.origin.y -= 86
                            }, completion: {
                                (value: Bool) in
                                self.messageImage.frame.origin.y += 86
                                self.messageImage.frame.origin.x = 0
                                self.listImage.alpha = 1
                                
                        })
                        
                })
                
            }

            
            
            

            
        
        
        
        
        
        
        

            
        }
        
            
            
            
        

    
        
        
        
        
        
            
            
            
            

    
    
            
        
            
//            //check to see if it's moving left or right
//            archiveIconImage.alpha = (messageImage.center.x - 160) / 60
//            laterIconImage.alpha = -(messageImage.center.x - 160) / 60

            

            
            
       
        
    
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

