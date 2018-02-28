//
//  ViewController.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/27.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit
import YouTubeiOSPlayerHelper

class ViewController: BaseViewController {

    @IBOutlet weak var player: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player.delegate = self
        let v: [String: Any] = ["playsinline": 1]
        player.load(withVideoId: "jrgO_9ey53M", playerVars: v)
    }

}

// MARK: - YTPlayerViewDelegate

extension ViewController: YTPlayerViewDelegate {

	func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
		playerView.playVideo()
	}
    
}
