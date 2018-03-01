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
	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var screenName: UILabel!
	@IBOutlet weak var createdAt: UILabel!
	@IBOutlet weak var tap: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        player.delegate = self

		viewModel = ViewModel(
			player: player,
			icon: icon,
			screenName: screenName.rx.text,
			createdAt: createdAt.rx.text)
    }

}

// MARK: - YTPlayerViewDelegate

extension ViewController: YTPlayerViewDelegate {

	func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
		playerView.playVideo()
	}
    
}
