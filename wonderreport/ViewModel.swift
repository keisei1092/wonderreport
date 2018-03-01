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
import SDWebImage

class ViewModel: BaseViewModel {

	private let model = Model()

	init(
		player: YTPlayerView,
		icon: UIImageView,
		screenName: Binder<String?>,
		createdAt: Binder<String?>
	) {
		super.init()

		model.url.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.debug()
			.drive(onNext: { url in
				guard let id = url.queryParameters?["v"] else { return }
				let v: [String: Any] = ["playsinline": 1]
				player.load(withVideoId: id, playerVars: v)
				print("player load: \(id)")
			}).disposed(by: disposeBag)

		model.createdAt.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(createdAt)
			.disposed(by: disposeBag)

		model.screenName.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(screenName)
			.disposed(by: disposeBag)

		model.profileImageURL.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(onNext: { url in
				icon.image = nil
				icon.sd_setImage(with: url)
			})
			.disposed(by: disposeBag)
	}
	
}
