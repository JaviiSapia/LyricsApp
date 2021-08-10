//
//  SearchForm.swift
//  LyricsApp
//
//  Created by Javier Sapia on 13/04/2021.
//  Copyright © 2021 Javier Sapia. All rights reserved.
//

import UIKit

class SearchFormView: UIView {

    static let TAG: String = "SearchFormView"
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak private var artist: UITextField!
    @IBOutlet weak private var songTitle: UITextField!
    @IBOutlet weak private var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: SearchFormProtocol?
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /**
        Associates the view with the controller
    */
    private func commonInit() {
        let bundle = Bundle(for: SearchFormView.self)
        bundle.loadNibNamed(SearchFormView.TAG, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        containerView.endEditing(true)
        setViewStyles()
    }
    
    /**
        Set a style to the different views
        Is just to get order in the code
     */
    private func setViewStyles() {
        self.setRoundedStyle(view: self.searchButton)
    }
    
    /**
        Round the vertices of a view
        - Parameters  view:  The view to round
    */
    private func setRoundedStyle(view: UIView) {
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
    }
    
    /**
        Checks if the inputs are empty
        - Returns: False if inputs have text, True if they are empty
     */
    private func isFormEmpty() -> Bool {
        return artist.text?.isEmpty ?? true && songTitle.text?.isEmpty ?? true
    }
    
    /**
        Send the new lyrics to the MainViewController
        - Parameters
            - lyrics: The new lyrics to send
            - error: An error message to be displayed
    */
    private func fetchLyric() {
        if let delegate = self.delegate {
            LyricRequest(artist: self.artist.text!, title: self.songTitle.text!).get { lyric in
                self.showProgress(show: false)
                self.activityIndicator.isHidden = true
                self.addToHistory(lyrics: lyric)
                delegate.onSearchResponse(lyric: lyric, error: nil)
            } onError: { errorMessage in
                self.showProgress(show: false)
                self.activityIndicator.isHidden = true
                delegate.onSearchResponse(lyric: nil, error: errorMessage)
            }
        }
    }
    
    /**
        Save the new lyric in the device
        - Parameters: lyrics: The lyric to be saved
     */
    private func addToHistory(lyrics: Lyric) {
        HistoryManager.init().add(lyric: lyrics)
        LastSearchManager.init().add(lyrics: lyrics)
    }
    
    /**
        Listen to the searchButton clicks
     */
    @IBAction func onSearchClickListener(_ sender: Any) {
        containerView.endEditing(true)
        if(self.isFormEmpty()) {
            showError(message: Strings.SearchFormView_Error_Inputs.rawValue)
            return
        }
        if(!isDeviceConnectedToInternet()) {
            showError(message: Strings.SearchFormView_Error_Internet.rawValue)
            return
        }
        
        showProgress(show: true)
        self.fetchLyric()
    }
    
    /**
        Show a ActivityProgress to notifiy the user that the request being processed
        It also disables the "Go" button to avoid a new request
        - Parameters: show: True if you want to show the activity indicator, false if you want to hide it
     */
    private func showProgress(show: Bool) {
        self.activityIndicator.isHidden = !show
        self.searchButton.isEnabled = !show
    }
    
    /**
        Checks if device has connection to internet
        - Returns: True if the device has internet, false if not
     */
    private func isDeviceConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    /**
        Send a error message to the delegate
        - Parameters: message: The error message
     */
    private func showError(message: String) {
        delegate?.onErrorOcurred(title: Strings.SearchFormView_Error_Title.rawValue, message: message)
    }
    
}
