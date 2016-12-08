//
//  AboutPageViewController.swift
//  SocketChat
//
//  Created by Anthony Colas on 11/23/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {
    

    
    @IBOutlet weak var bulletLabel: UITextView!
    @IBOutlet weak var textView1: UITextView!
    
    @IBOutlet weak var textView2: UITextView!
    
    @IBOutlet weak var textView3: UITextView!
    override func viewDidLoad() {
        self.navigationController!.navigationBar.topItem!.title = "";

        let attributedString1 = "SOCKET.IO"
        let linkString1 = NSMutableAttributedString(string: attributedString1)
        linkString1.addAttribute(NSLinkAttributeName, value: "http://socket.io/", range: NSMakeRange(0, attributedString1.characters.count))
        
        textView1.attributedText = linkString1
        textView1.userInteractionEnabled = true

        
        let attributedString2 = "ROSbridge"
        let linkString2 = NSMutableAttributedString(string: attributedString2)
        linkString2.addAttribute(NSLinkAttributeName, value: "http://wiki.ros.org/rosbridge", range: NSMakeRange(0, attributedString2.characters.count))
        
        textView2.attributedText = linkString2
        textView2.userInteractionEnabled = true
        
        
        let attributedString3 = "ROS"
        let linkString3 = NSMutableAttributedString(string: attributedString3)

        linkString3.addAttribute(NSLinkAttributeName, value: "http://www.ros.org/", range: NSMakeRange(0, attributedString3.characters.count))
        
        textView3.attributedText = linkString3
        textView3.userInteractionEnabled = true
        
        
        super.viewDidLoad()
        
        
        
        var i = 0
        var fullString = ""
        
        while i < 3
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint)\n\n"
            
            fullString = fullString + formattedString
            i++
        }
        
        bulletLabel.text = fullString
        // Do any additional setup after loading the view.
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
