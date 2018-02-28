//
//  ViewModel.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import YouTubeiOSPlayerHelper

class ViewModel: BaseViewModel {

	private let model = Model()

	init(
		player: YTPlayerView,
		text: Binder<String?>
	) {
		super.init()

		model.url.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(onNext: { url in
				guard let id = url.queryParameters?["v"] else { return }
				let v: [String: Any] = ["playsinline": 1]
				player.load(withVideoId: id, playerVars: v)
				print("player load: \(id)")
			}).disposed(by: disposeBag)

		model.text.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(text)
			.disposed(by: disposeBag)
	}
	
}
