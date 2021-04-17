//
//  ViewController.swift
//  LyricsApp
//
//  Created by Javier Sapia on 13/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak private var searchForm: SearchFormView!
    @IBOutlet weak var lastSearchView: LastSearchView!
    @IBOutlet weak var infoView: InfoView!
    @IBOutlet weak var lastSearchHeightConstraint: NSLayoutConstraint!
    
    private var lyricsViewController: LyricsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForm.delegate = self
        lastSearchView.delegate = self
        self.setViewConfiguration()
        self.instantiateViewControllers()
        setInfoView(imageName: "main.png", title: Strings.ViewController_InfoView_Title.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLastSearchView()
    }
    
    /**
        Initialize the differents VC in the storyboard
     */
    private func instantiateViewControllers() {
        self.lyricsViewController = (storyboard?.instantiateViewController(withIdentifier: LyricsViewController.TAG) as! LyricsViewController)
    }
    
    /**
       Set differents configurations for the view
    */
    private func setViewConfiguration() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Strings.ViewController_Title.rawValue
    }
    
    /**
        Sets the title and the image to be displayed in the InfoView
        - Parameters:
            - imageName: The name of the image that you want to show
            - title: The title of the message to be displayed
     */
    private func setInfoView(imageName: String, title: String) {
        infoView.setInfo(image: UIImage(named: imageName)!, title: title)
    }
    
    /**
        Show the LastSearchView if user has made a search before
     */
    private func setLastSearchView() {
        if let lastSearch = LastSearchManager.init().getLastSearch() {
            self.lastSearchView.setLyric(lyrics: lastSearch)
            self.lastSearchView.isHidden = false
        } else {
            self.lastSearchView.isHidden = true
        }
    }
    
    /**
        Handle the Lyrics VC transaction
        - Parameters: lyrics: The lyrics that wants to be shown in the LyricsViewController
     */
    private func showLyricsViewController(with lyrics: Lyric) {
        self.lyricsViewController?.setLyrics(lyrics: lyrics)
        self.navigationController?.pushViewController(self.lyricsViewController!, animated: true)
    }
    
    /**
        Dismis the keyboard when the view is clicked
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ViewController: SearchFormProtocol {
    
    /**
        Listen the request response
        - Parameters:
            - lyrics: The new lyirics to be shown in the LyricsViewController
            - error: A string with the error message
     */
    func onSearchResponse(lyric: Lyric?, error: String?) {
        if let lyrics = lyric {
            self.showLyricsViewController(with: lyrics)
        }
        else {
            self.setInfoView(imageName: "notFound.png", title: error!)
        }
    }
    
    /**
        Show a Alert with the error
     */
    func onErrorOcurred(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: LastSearchProtocol {
    
    /**
        Show the last searched lyrics
     */
    func onLastSearchClick(lyrics: Lyric) {
        self.showLyricsViewController(with: lyrics)
    }
    
}
