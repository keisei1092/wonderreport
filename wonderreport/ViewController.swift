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

	private var viewModel: ViewModel?

    @IBOutlet weak var player: YTPlayerView!
	@IBOutlet weak var text: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        player.delegate = self

		viewModel = ViewModel(player: player, text: text.rx.text)
    }

}

// MARK: - YTPlayerViewDelegate

extension ViewController: YTPlayerViewDelegate {

	func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
		playerView.playVideo()
	}
    
}
