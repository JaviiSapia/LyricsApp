//
//  HistoryManager.swift
//  LyricsApp
//
//  Created by Javier Sapia on 15/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class HistoryManager: DBManager {
        
    private var DBLyrics: [Lyrics] = [Lyrics]()
    
    override init() {
        super.init()
        updateData()
    }
    
    /**
        Get the list of lyrics in the device
        - Returns: An array of Lyric objects
     */
    func get() -> [Lyric] {
        var lyricsArray: [Lyric] = [Lyric]()
        DBLyrics.forEach { (fetchLyric) in
            lyricsArray.append(toLyric(data: fetchLyric))
        }
        return lyricsArray
    }
    
    /**
       Get a specific lyric in the list
       - Parameters: index: The index of the lyric in the array
       - Returns: The lyric
    */
    func get(at index: Int) -> Lyric {
        return toLyric(data: DBLyrics[index])
    }
    
    /**
        Saves a new lyric in the device
        - Parameters: lyric: The lyric to be saved
     */
    func add(lyric: Lyric) {
        let tempDbLyrics = Lyrics(context: context)
        tempDbLyrics.artist = lyric.getArtist()
        tempDbLyrics.title = lyric.getTitle()
        tempDbLyrics.lyrics = lyric.getLyrics()
        save()
        updateData()
    }
    
    /**
        Remove a specific lyric from the memory
     */
    func remove(index: Int) {
        remove(lyric: DBLyrics[index])
        updateData()
    }
    
    /**
        Updates the list of lyrics
     */
    func updateData() {
        self.DBLyrics = super.fetch(fetchRequest: Lyrics.fetchRequest()) as! [Lyrics]
    }
    
    /**
        Creates a new Lyric object from Lyrics (NSManagedObject)
        - Parameters: The Lyrics object to be converted
        - Returns: A new Lyric
     */
    private func toLyric(data: Lyrics) -> Lyric {
        return Lyric(artist: data.artist!, title: data.title!, lyrics: data.lyrics!)
    }
    
}
