//
//  RGSInfoViewController.swift
//  SummerSchool
//
//  Created by Charles Randolph on 6/4/17.
//  Copyright © 2017 RUG. All rights reserved.
//

import UIKit

class RGSInfoViewController: UIViewController, RGSControlBarDelegate {
    
    @IBOutlet weak var controlBar: RGSControlBarView!
    
    // MARK: -
    // MARK: Delegated Methods
    
    func shouldShowTitleLabel() -> (Bool, String?) {
        return (true, "General Information")
    }
    
    func shouldShowReturnButton() -> Bool {
        return true
    }
    
    func didSelectReturnButton(_ sender: UIButton) -> Void {
        print("The return button was toggled!")
    }
    
    func didSelectSettingsButton(_ sender: UIButton) {
        print("The settings button was toggled!")
    }
    
    // MARK: -
    // MARK: Class Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        controlBar.delegate = self
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
