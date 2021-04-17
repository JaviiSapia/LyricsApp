//
//  HistoryTableViewCell.swift
//  LyricsApp
//
//  Created by Javier Sapia on 15/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    static let TAG: String = "HistoryTableViewCell"
    @IBOutlet weak var songCellView: SongCellView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

}
