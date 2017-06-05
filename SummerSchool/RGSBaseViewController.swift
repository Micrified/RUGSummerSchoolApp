//
//  RGSBaseViewController.swift
//  SummerSchool
//
//  Created by Charles Randolph on 6/5/17.
//  Copyright © 2017 RUG. All rights reserved.
//

import UIKit

class RGSBaseViewController: UIViewController, RGSControlBarDelegate {
    
    // MARK: - Variables
    
    
    // MARK: - Outlets
    @IBOutlet weak var controlBar: RGSControlBarView!
    
    // MARK: - Actions
    
    
    // MARK: - Methods
    
    /// Sets the title for the control bar.
    /// - Returns: Void.
    func setControlBarTitle(_ title: String!) -> Void {
        if (title != nil && controlBar != nil) {
            controlBar.titleLabel.text = title
        }
    }
    
    // MARK: - RGSControlBar Protocol Methods
    
    /// Handler for display of title label: Defaults to false
    func shouldShowTitleLabel() -> (Bool, String?) {
        return (false, nil)
    }
    
    /// Handler for display of return button: Defaults to false
    func shouldShowReturnButton() -> Bool {
        return false
    }
    
    /// Handler for settings button: Default switches to settings screen
    func didSelectSettingsButton(_ sender: UIButton) {
        print("You tapped settings!")
    }
    
    /// Handler for return button: No action by default.
    func didSelectReturnButton(_ sender: UIButton) {
        print("You tapped return!")
    }
    
    // MARK: - Class Method Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBar.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
