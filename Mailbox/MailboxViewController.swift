//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Karan Khurana on 6/6/16.
//  Copyright © 2016 Karan Khurana. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var deleteView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var listFullView: UIImageView!
    @IBOutlet weak var laterFullView: UIImageView!
    
    
    var messageOriginalCenter: CGPoint!
    var messageOriginalRight: CGPoint!
    var feedOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = feedView.image!.size
        // Do any additional setup after loading the view.
        messageOriginalRight = messageView.center
        feedOriginalCenter = feedView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y <= -50 {
            UIView.animateWithDuration(0.3) {
                self.feedView.center.y = self.feedOriginalCenter.y
            }
        }
    }
    
    @IBAction func onTapLaterFull(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.3) {
            print ("touched later")
            self.laterFullView.alpha = 0
            self.feedView.center.y -= 86
        }
    }
    
    
    @IBAction func onTapListFull(sender: UITapGestureRecognizer) {

        UIView.animateWithDuration(0.3) {
            print ("touched list")
            self.listFullView.alpha = 0
            self.feedView.center.y -= 86
            
        }
    }
    
    
    
    
    @IBAction func onSwipeMessage(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(backgroundView)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageView.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            print ("\(messageView.center.x, messageView.frame.origin.x)")
            
            if messageView.frame.origin.x < -60 && messageView.frame.origin.x > -260 {
                backgroundView.backgroundColor = UIColor.yellowColor()
                laterView.center.x = messageView.frame.origin.x + messageView.frame.width + 20
                laterView.alpha = 1
                listView.alpha = 0
            } else if messageView.frame.origin.x < -260 {
                backgroundView.backgroundColor = UIColor.brownColor()
                listView.center.x = messageView.frame.origin.x + messageView.frame.width + 20
                laterView.alpha = 0
                listView.alpha = 1
            } else if messageView.frame.origin.x  > 60 && messageView.frame.origin.x < 260 {
                backgroundView.backgroundColor = UIColor.greenColor()
                archiveView.center.x = messageView.frame.origin.x - 20
                archiveView.alpha = 1
                deleteView.alpha = 0
            } else if messageView.frame.origin.x > 260 {
                backgroundView.backgroundColor = UIColor.redColor()
                deleteView.center.x = messageView.frame.origin.x - 20
                deleteView.alpha = 1
                archiveView.alpha = 0
            } else {
                backgroundView.backgroundColor = UIColor.grayColor()
                laterView.alpha = 0
                listView.alpha = 0
                archiveView.alpha = 0
                deleteView.alpha = 0
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.x < 0 && messageView.center.x * 2 < messageView.frame.width - 120 && messageView.center.x * 2 > messageView.frame.width - 520 {
                UIView.animateWithDuration(0.3) {
                    self.laterView.alpha = 0
                    self.listView.alpha = 0
                    self.archiveView.alpha = 0
                    self.deleteView.alpha = 0
                    self.laterFullView.alpha = 1.0
                }
            } else if velocity.x < 0 && messageView.center.x * 2 < messageView.frame.width - 520 {
                UIView.animateWithDuration(0.3) {
                    self.laterView.alpha = 0
                    self.listView.alpha = 0
                    self.archiveView.alpha = 0
                    self.deleteView.alpha = 0
                    self.listFullView.alpha = 1.0
                    
                }
                
            } else if messageView.center.x  > (messageView.frame.width / 2) + 60 {
                UIView.animateWithDuration(0.3) {
                    self.laterView.alpha = 0
                    self.listView.alpha = 0
                    self.archiveView.alpha = 0
                    self.deleteView.alpha = 0
                    self.feedView.center.y -= 86
                }
            }  else {
                backgroundView.backgroundColor = UIColor.grayColor()
                laterView.alpha = 0
                listView.alpha = 0
                archiveView.alpha = 0
                deleteView.alpha = 0
            }
            

            
            UIView.animateWithDuration(0.2, animations: {
                self.messageView.center = CGPoint(x: self.messageOriginalCenter.x, y: self.messageOriginalCenter.y)
            })
            
        }
        
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
