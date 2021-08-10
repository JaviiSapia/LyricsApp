//
//  LyricRequest.swift
//  LyricsApp
//
//  Created by Javier Sapia on 10/08/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import Foundation

class LyricRequest {
    
    private var url = URL(string: "https://api.lyrics.ovh/v1/")!
    private let artist: String
    private let title: String
    
    init(artist: String, title: String) {
        self.artist = artist
        self.title = title
    }
    
    /**
        Handles the request of the new lyrics
        - Parameters
            - artist: The name of the artist
            - title: The name of the song
     */
    func get(onRespose: @escaping (Lyric) -> (), onError: @escaping (String) -> ()) {
        
        // Cofigures the URLSession for handle internet disconection
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        
        let task = URLSession(configuration: config).dataTask(with: setUrlWithPaths(artist: artist, title: title)) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let lyric = json["lyrics"] {
                                onRespose(Lyric.init(artist: self.artist, title: self.title, lyrics: lyric as! String))
                            }
                            if let error = json["error"] {
                                onError(error as! String)
                            }
                        }
                    } catch let error as NSError {
                        onError(error.localizedDescription)
                    }
                }
                else {
                    onError(error?.localizedDescription ?? "Unknown error")
                }
            }
        }
        task.resume()
    }
    
    /**
        Creates a new URL from the input values
        - Parameters
            - artist: The name of the artist
            - title: The name of the song
        - Returns: A new URLRequest with the custom URL
    */
    private func setUrlWithPaths(artist: String, title: String) -> URLRequest {
        return URLRequest(url: self.url.appendingPathComponent(artist)
        .appendingPathComponent(title))
    }
    
}
