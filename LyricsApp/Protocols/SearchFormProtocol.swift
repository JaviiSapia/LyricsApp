//
//  SearchFormProtocol.swift
//  LyricsApp
//
//  Created by Javier Sapia on 14/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import Foundation
protocol SearchFormProtocol: AnyObject {
    func onSearchResponse(lyric: Lyric?, error: String?) -> Void
    func onErrorOcurred(title: String, message: String)
}
