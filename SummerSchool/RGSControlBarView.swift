//
//  RGSControlBarView.swift
//  SummerSchool
//
//  Created by Charles Randolph on 6/4/17.
//  Copyright © 2017 RUG. All rights reserved.
//

import UIKit

class RGSControlBarView: UIView {
    
    // MAIN: Variables
    
    /// The view delegate
    var delegate: RGSControlBarDelegate! {
        didSet {
            if (delegate != nil) {
                let (shouldShowTitle, titleText) = delegate.shouldShowTitleLabel()
                titleLabel.isHidden = !shouldShowTitle
                titleLabel.text = titleText
                returnButton.isHidden = !delegate.shouldShowReturnButton()
            }
        }
    }
    
    /// The content of the UIView
    var contentView: UIView!
    
    /// Computed Nib name (name of class)
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    // MAIN:-
    // MAIN: IBOutlets
    
    /// The optional return button.
    @IBOutlet weak var returnButton: UIButton!
    
    /// The mandatory settings button.
    @IBOutlet weak var settingsButton: UIButton!
    
    /// The optional title label.
    @IBOutlet weak var titleLabel: UILabel!
    
    // MAIN:-
    // MAIN: IBActions
    
    @IBAction func didSelectSettingsButton(_ sender: UIButton) {
        if (delegate != nil) {
            delegate.didSelectSettingsButton(sender)
        }
    }
    
    @IBAction func didSelectReturnButton(_ sender: UIButton) {
        if (delegate != nil) {
            delegate.didSelectReturnButton(sender)
        }
    }
    
    // MAIN:-
    // MAIN: Nib Initializer
    
    func loadViewFromNib() {
        contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    // MAIN:-
    // MAIN: Class Method Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

}
