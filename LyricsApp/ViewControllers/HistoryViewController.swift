//
//  HistoryViewController.swift
//  LyricsApp
//
//  Created by Javier Sapia on 15/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    private let historyManager: HistoryManager = HistoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.showsVerticalScrollIndicator = false
        setViewConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.historyManager.updateData()
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
        }
    }
    
    /**
        Set differents configurations for the view
     */
    private func setViewConfigurations() {
        self.title = Strings.HistoryViewController_Title.rawValue
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    
    /**
        The count of lyrics saved in the device will be the number of rows to display
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyManager.get().count
    }
    
    /**
        Inflates a HistoryTableViewCell with the data that comes from the history
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.TAG, for: indexPath) as! HistoryTableViewCell
        if historyManager.get().count != 0 {
            cell.songCellView.setInfo(title: historyManager.get(at: indexPath.row).getTitle(), artist: historyManager.get(at: indexPath.row).getArtist())
        }
        return cell
    }
    
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lyricsViewController: LyricsViewController = (storyboard?.instantiateViewController(withIdentifier: LyricsViewController.TAG)) as! LyricsViewController
        lyricsViewController.setLyrics(lyrics: historyManager.get()[indexPath.row])
        self.navigationController?.pushViewController(lyricsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.historyManager.remove(index: indexPath.row)
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
}
