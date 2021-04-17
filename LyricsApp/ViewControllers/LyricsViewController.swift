//
//  LyricsViewController.swift
//  LyricsApp
//
//  Created by Javier Sapia on 15/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class LyricsViewController: UIViewController {
    
    static let TAG: String = "LyricsViewController"
    private var lyrics: Lyric?
    @IBOutlet weak private var sontTitle: UILabel!
    @IBOutlet weak private var lyricsTextView: UITextView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setViewConfigurations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideScrollBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setText()
    }
    
    /**
        Hides the ScrollBar in the TextView
     */
    private func hideScrollBar() {
        self.lyricsTextView.showsVerticalScrollIndicator = false
    }
    
    /**
        Set differents configurations for the view
     */
    private func setViewConfigurations() {
        self.modalTransitionStyle = .crossDissolve
    }

    /**
        Sets the new lyrics to be displayed
     */
    func setLyrics(lyrics: Lyric) {
        self.lyrics = lyrics
    }
    
    /**
        Configures the entire view with the Lyrics object
     */
    private func setText() {
        self.title = lyrics!.getTitle()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.sontTitle.text = "By " + lyrics!.getArtist()
        self.lyricsTextView.text = self.lyrics!.getLyrics()
    }

}
