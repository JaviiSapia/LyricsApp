//
//  LastSearchView.swift
//  LyricsApp
//
//  Created by Javier Sapia on 16/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class LastSearchView: UIView {

    static let TAG: String = "LastSearchView"
    private var historyManager: HistoryManager?
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var songCellView: SongCellView!
    private var lyrics: Lyric?
    weak var delegate: LastSearchProtocol?
    
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
        historyManager = HistoryManager()
        let bundle = Bundle(for: SearchFormView.self)
        bundle.loadNibNamed(LastSearchView.TAG, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.layer.cornerRadius = 15        
    }
    
    /**
        Sets a new lyiric and update the information
     - Parameters: lyrics: The new lyrics to display
     */
    func setLyric(lyrics: Lyric) {
        self.lyrics = lyrics
        self.updateData()
    }
    
    /**
        Sets the text in the SongCellView
     */
    private func updateData()  {
        self.songCellView.setInfo(title: self.lyrics!.getTitle(), artist: self.lyrics!.getArtist())
    }
            
    /**
        Detects the click in the view and communicates it with the delegate
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.onLastSearchClick(lyrics: self.lyrics!)
        }
    }    

}
