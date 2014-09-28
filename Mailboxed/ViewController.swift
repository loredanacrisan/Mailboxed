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
        
        print(scrollHeight)
        
        print(feedScrollView.contentSize)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

