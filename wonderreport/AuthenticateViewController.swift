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

			// メイン画面へ遷移
			let vc = ViewController.instantiateFromStoryboard()
			vc.modalTransitionStyle = .crossDissolve
			self?.present(vc, animated: true)
		})

		logInButton.center = view.center
		view.addSubview(logInButton)
	}
}
