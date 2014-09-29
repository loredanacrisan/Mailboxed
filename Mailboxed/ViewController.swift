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
    
    var state: String!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // set size of scroll view
        
        var scrollHeight = CGFloat ()
        scrollHeight = messagesImage.frame.size.height + helpImage.frame.size.height + searchImage.frame.size.height + messageImage.frame.size.height

        feedScrollView.contentSize = CGSize (width: 320, height: scrollHeight)
        
        
          // set the overlay views to transparent
        
        rescheduleImage.alpha = 0
        listImage.alpha = 0

        

    
    }
    
    
  
    
    
    //begin pan actions
    
    @IBAction func panMessage(panGestureRecognizer: UIPanGestureRecognizer) {

        //get velocity, location and translation
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        

  
        
        
        //set default states
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            
            
        //set default state for icons
            laterIconImage.alpha = 0
            laterIconImage.frame.origin.x = CGFloat(280)
            laterIconImage.image = UIImage(named: "later_icon")

            archiveIconImage.image = UIImage(named: "archive_icon")
            archiveIconImage.alpha = 0
            archiveIconImage.frame.origin.x = CGFloat(20)
           
            

        //set default bg color
            messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
            
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            
            // make the message follow user
            messageImage.frame.origin.x = translation.x
            
            
            
            // set states based on how far the user moves
            
            
            
            // set no-action range on the left
            if messageImage.frame.origin.x > 0 && messageImage.frame.origin.x < 80 {
                
                state = "peek left"
                print (state)
                
            // reveal icon and change bg color
                archiveIconImage.alpha = (translation.x / 80)
                messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
                

            
            
            // set archive range
            
            } else if messageImage.frame.origin.x > 80 && messageImage.frame.origin.x < 200 {
                
                
                state = "archive"
                print (state)
                
                
                // set icon image, move it with the message view
                archiveIconImage.frame.origin.x =  20 + translation.x - 80
                archiveIconImage.image = UIImage(named: "archive_icon")
                
                // set message view bg color
                messageView.backgroundColor = UIColor(red:0.4, green:0.69, blue:0.36, alpha:1.0)
                
                
                
                
            // set delete range
            
            } else if messageImage.frame.origin.x > 200 {
                
                
                state = "delete"
                print (state)
                
                // set icon image, move it with the message view
                archiveIconImage.frame.origin.x =  20 + translation.x - 80
                archiveIconImage.image = UIImage(named: "delete_icon")
                
                // set message view bg color
                messageView.backgroundColor = UIColor(red:0.89, green:0.16, blue:0.23, alpha:1.0)
                

                
                
                
                
            // set no-action range on the right
                
            } else if messageImage.center.x < 160 &&  messageImage.center.x > 80 {
            
            
                state = "peek right"
                print (state)
                
                
                
                // set icon image, move it with the message view
                laterIconImage.image = UIImage(named: "later_icon")
                laterIconImage.alpha = -(translation.x / 80)
                

                
                // set message view bg color
                messageView.backgroundColor = UIColor(white:0.87, alpha:1.0)
                
                

                
                
            
            // set view later range
            
            } else if messageImage.center.x < 80 &&  messageImage.center.x > -40 {
                
                
                state = "later"
                print (state)
                

                // set icon image, move it with the message view
                laterIconImage.image = UIImage(named: "later_icon")
                laterIconImage.frame.origin.x = 280 + 80 + translation.x


                
                // set message view bg color
                messageView.backgroundColor = UIColor(red:1.0, green:0.84, blue:0.09, alpha:1.0)

                
                
                
                
                
                
            // set view later range

            } else if messageImage.center.x < -40 {
                
                
                state = "todo"
                print (state)
                
  
                // set icon image, move it with the message view
                laterIconImage.image = UIImage(named: "list_icon")
                laterIconImage.frame.origin.x = 280 + 80 + translation.x
                
                
                // set message view bg color
                messageView.backgroundColor = UIColor(red:0.59, green:0.49, blue:0.4, alpha:1.0)

                
            }
       
        // end of pan changed actions
            
            
            
            
            
            
        
        // begin pan ended actions
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            
    
        // bounce back for peek states
            if state == "peek left" || state == "peek right" {
                
                print("bounceback")
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = 0
                    }, completion: nil)
            
        
                
                
        // dismiss message right for archive and delete states
            
            } else if state == "archive" || state == "delete" {
                
                print("reset")
                
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                () -> Void in
                self.messageImage.frame.origin.x = 350
                self.archiveIconImage.frame.origin.x = 350
                }, completion: {
                (value: Bool) in
                
                // restore view for future interactions
                    
                UIView.animateWithDuration(0.4, animations: {
                    self.messagesImage.frame.origin.y -= 86
                    }, completion: {
                        (value: Bool) in
                        self.messageImage.frame.origin.x = 0
                        self.messagesImage.frame.origin.y += 86
                        
                        
                })
            
            })
                
                
                
                
        // dismiss message left for later state

                
            } else if state == "later" {
                print("later")
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = -350
                    self.laterIconImage.frame.origin.x = -350
                    }, completion: {
                        
                        
                        (value: Bool) in
                         print("reset")
        
        
        
        // show reschedule overlay and reset view on completion
                
                        
                UIView.animateWithDuration(0.4, animations: {
                    
                    self.messagesImage.frame.origin.y -= 86
                    self.rescheduleImage.alpha = 1
                    
                    }, completion: {
                        (value: Bool) in
                        self.messagesImage.frame.origin.y += 86
                        self.messageImage.frame.origin.x = 0
                        
                        
                })

        })
                
                
                
                
        // dismiss message left for todo state
              
                
            } else if state == "todo" {
                print("todo")
                
                UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                    () -> Void in
                    self.messageImage.frame.origin.x = -350
                    self.laterIconImage.frame.origin.x = -350
                    }, completion: {
                        
        
            
        // show reschedule overlay and reset view on completion
                
                        
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
            
            
            // end of todo state


            
        }
        
        
        // end of Pan Ended actions
        
    
        
    
    }
    
    // end of onPan actions
    
    
    
    
    
    
    // user taps on rechedule overlay
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        print ("tapped list")
        UIView.animateWithDuration(0.2, animations: {
            self.rescheduleImage.alpha = 0
            self.messagesImage.frame.origin.y -= 86
            },
            
            completion: {
                (value: Bool) in
                self.messagesImage.frame.origin.y += 86
                self.messageImage.frame.origin.x = 0
                
        })
        
    }
    
    
    
    
    // user taps on todo overlay
    
    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        print ("tapped list")
        UIView.animateWithDuration(0.2, animations: {
            self.listImage.alpha = 0
            self.messagesImage.frame.origin.y -= 86
            },
            
            completion: {
                (value: Bool) in
                self.messagesImage.frame.origin.y += 86
                self.messageImage.frame.origin.x = 0
                
        })
        
        
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

