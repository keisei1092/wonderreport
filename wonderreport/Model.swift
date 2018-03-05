//
//  Model.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import RxSwift

class Model: BaseModel {

	private var tweets: Tweets?
	private var i = 0

	let url = Variable<URL?>(nil)
	let screenName = Variable<String?>(nil)
	let createdAt = Variable<String?>(nil)
	let profileImageURL = Variable<URL?>(nil)

	override init() {
		super.init()

		// Twitterで #wonderreport と検索して、結果の配列をViewModelに渡す
		let client = TWTRAPIClient()
		let statusesSearchEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
		let params: [String: Any] = ["q": "#wonderreport -RT"]
		var clientError: NSError?
		let request = client.urlRequest(withMethod: "GET",
										urlString: statusesSearchEndpoint,
										parameters: params,
										error: &clientError)
		// TODO: - 後でRepositoryに移す
		client.sendTwitterRequest(request, completion: { [weak self] res, data, error in
			guard error == nil else {
				print("Error: \(error!)")
				return
			}

			guard let jsonString = String(data: data!, encoding: .utf8) else {
				print("error: can't obtain data string")
				return
			}

			let tweets = Tweets(JSONString: jsonString)
			print(tweets ?? "")

			self?.tweets = tweets
			self?.load()
		})
	}

	/// 次の動画を再生、最後まで来たら最初に戻る
	func forward() {
		guard let c = tweets?.statuses?.count else { return }
		if i == c - 1 { i = 0 } else { i += 1 }
		load()
	}

	private func load() {
		let url = tweets?.statuses?[i].entities?.firstExpandedURL
		self.url.value = url

		let screenName = tweets?.statuses?[i].user?.screenName
		self.screenName.value = screenName

		if let createdAt = tweets?.statuses?[i].createdAt {
			self.createdAt.value = Date().offset(from: createdAt)
		}

		let profileImageURL = tweets?.statuses?[i].user?.profileImageURL
		self.profileImageURL.value =  profileImageURL
	}

}
