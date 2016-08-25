//
//  FeedVC.swift
//  AppBeta
//
//  Created by Khoi Nguyen on 8/24/16.
//  Copyright © 2016 Khoi Nguyen. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboardWhenTapGesture()

        // Do any additional setup after loading the view.
    }
    func HideKeyboardWhenTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
