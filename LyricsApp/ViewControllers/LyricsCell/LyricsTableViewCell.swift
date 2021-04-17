//
//  LyricsTableViewCell.swift
//  LyricsApp
//
//  Created by Javier Sapia on 15/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class LyricsTableViewCell: UITableViewCell {

    @IBOutlet weak private var lyrics: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLyrics(lyrics: String) {
        self.lyrics.text = lyrics
    }

}
