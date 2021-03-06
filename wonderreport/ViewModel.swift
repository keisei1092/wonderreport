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

	let playerDidEnd = PublishSubject<Void>()

	init(
		player: YTPlayerView,
		icon: UIImageView,
		screenName: Binder<String?>,
		createdAt: Binder<String?>,
		tap: UIButton
	) {
		super.init()

		// URLを受け取った時に再生する
		model.url.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(onNext: { url in
				// URLには youtu.be/xxxx と (www.)youtube.com/watch?v=xxxx のタイプがある
				guard
					let id = url.host == "youtube.com" || url.host == "www.youtube.com"
						   ? url.queryParameters?["v"]
						   : url.host == "youtu.be" ? url.lastPathComponent
					       : nil
				else {
					print("invalid URL pattern: \(url)")
					AppDelegate.shared?.showToast(message: "不正なURLです")
					return
				}
				let v: [String: Any] = ["playsinline": 1]
				player.load(withVideoId: id, playerVars: v)
				print("player load: \(id)")
			}).disposed(by: disposeBag)

		// 投稿日ラベル
		model.createdAt.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(createdAt)
			.disposed(by: disposeBag)

		// スクリーンネームラベル
		model.screenName.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(screenName)
			.disposed(by: disposeBag)

		// アイコン
		model.profileImageURL.asObservable().unwrap()
			.asDriver(onErrorDriveWith: Driver.empty())
			.drive(onNext: { url in
				icon.image = nil
				icon.sd_setImage(with: url)
			})
			.disposed(by: disposeBag)

		// 画面タップで次へ
		tap.rx.tap
			.throttle(2, scheduler: MainScheduler.instance)
			.subscribe(onNext: { [weak self] in self?.model.forward() })
			.disposed(by: disposeBag)

		// YouTube動画の再生が終わったら次へ
		playerDidEnd.asObserver()
			.subscribe({ [weak self] _ in self?.model.forward() })
			.disposed(by: disposeBag)

	}
	
}
