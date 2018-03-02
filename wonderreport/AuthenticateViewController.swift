//
//  AuthenticateViewController.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit
import TwitterKit

class AuthenticateViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Twitterのセッションが存在すれば読み込む
		guard !TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() else {
			proceedToNextVC()
			return
		}

		let logInButton = TWTRLogInButton(logInCompletion: { [weak self] session, error in
			guard let session = session else {
				if let error = error {
					print("error: \(error.localizedDescription)");
				} else {
					print("error")
				}
				return
			}

			print("signed in as \(session.userName)")

			// Twitterのセッションを保存
			TWTRTwitter.sharedInstance().sessionStore.save(session, completion: { _, _ in
				print("session saved!")
			})

			self?.proceedToNextVC()
		})

		logInButton.center = view.center
		view.addSubview(logInButton)
	}

	/// メイン画面へ遷移
	func proceedToNextVC() {
		let vc = ViewController.instantiateFromStoryboard()
		vc.modalTransitionStyle = .crossDissolve
		present(vc, animated: true)
	}

}
