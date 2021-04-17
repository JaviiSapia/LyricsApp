//
//  InfoViewController.swift
//  LyricsApp
//
//  Created by Javier Sapia on 14/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class InfoView: UIView {
    static let TAG: String = "InfoView"
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak private var info: UILabel!
    
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /**
        Associates the view with the controller and sets visual configurations
    */
    private func commonInit() {
        let bundle = Bundle(for: SearchFormView.self)
        bundle.loadNibNamed(InfoView.TAG, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.layer.cornerRadius = 15
    }
    
    /**
        Set a new image a description
        - Parameters:
            - image: The UIImage that will be displayed
            - title: The message to show
     */
    func setInfo(image: UIImage, title: String) {
        self.image.image = image
        self.info.text = title
    }

}
