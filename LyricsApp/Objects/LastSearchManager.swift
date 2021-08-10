//
//  LastSearchManager.swift
//  LyricsApp
//
//  Created by Javier Sapia on 16/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import Foundation
class LastSearchManager: DBManager {
    
    private var lastSearchElement: LastSearchLyrics?
    
    override init() {
        super.init()
        updateData()
    }
    
    /**
        The last search made by the user
        - Returns: A Lyric object if exist a last search, a nil if not
     */
    func getLastSearch() -> Lyric? {
        if let lastSearch = lastSearchElement {
            return Lyric(artist: lastSearch.artist!, title: lastSearch.title!, lyrics: lastSearch.lyrics!)
        } else {
            return nil
        }
    }
    
    /**
       Saves the last search  lyric in the device
       - Parameters: lyric: The lyric to be saved
    */
    func add(lyrics: Lyric) {
        if lastSearchElement == nil {
            self.lastSearchElement = LastSearchLyrics(context: context)
        }
        self.lastSearchElement!.artist = lyrics.getArtist()
        self.lastSearchElement!.title = lyrics.getTitle()
        self.lastSearchElement!.lyrics = lyrics.getLyrics()
        save()
        self.updateData()
    }
    
    /**
        Get the last search lyrics saved in the device
        - Returns: A LastSearchLyrics object if user has made a search before, nil if not
     */
    private func getLastSearchFromDB() -> LastSearchLyrics? {
        let lastSearchArray = fetch(fetchRequest: LastSearchLyrics.fetchRequest()) as! [LastSearchLyrics]
        if lastSearchArray.count == 0 {
            return nil
        } else {
            return lastSearchArray[0]
        }
    }
    
    /**
       Updates the last search object
    */
    private func updateData() {
        self.lastSearchElement = getLastSearchFromDB()
    }
    
}
