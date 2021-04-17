//
//  SongCellView.swift
//  LyricsApp
//
//  Created by Javier Sapia on 16/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class SongCellView: UIView {

    static let TAG: String = "SongCellView"
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var songTitle: UILabel!
    @IBOutlet weak private var artist: UILabel!
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /**
        Associates the view with the controller
    */
    private func commonInit() {
        let bundle = Bundle(for: SearchFormView.self)
        bundle.loadNibNamed(SongCellView.TAG, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /**
        Sets the title and the artist on the labels
        - Parameters:
                - title: The title of the song
                - artist: The owner of the song
     */
    func setInfo(title: String, artist: String) {
        self.songTitle.text = title
        self.artist.text = artist
    }

}
