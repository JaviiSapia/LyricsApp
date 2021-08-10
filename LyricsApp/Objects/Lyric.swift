//
//  Lyric.swift
//  LyricsApp
//
//  Created by Javier Sapia on 14/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import Foundation
public class Lyric {
    
    private var artist: String
    private var title: String
    private var lyrics:String
    
    init(artist: String, title: String, lyrics: String) {
        self.artist = artist
        self.title = title
        self.lyrics = lyrics
    }

    func getArtist() -> String {
        return self.artist
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getLyrics() -> String {
        return self.lyrics
    }
    
}
