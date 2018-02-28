//
//  Model.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation

class Model: BaseModel {

	override init() {
		super.init()

		// Twitterで #wonderreport と検索して、結果の配列をViewModelに渡す
		let client = TWTRAPIClient()
		let statusesSearchEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
		let params: [String: Any] = [:]
		var clientError: NSError?
		let request = client.urlRequest(withMethod: "GET",
										urlString: statusesSearchEndpoint,
										parameters: params,
										error: &clientError)
		client.sendTwitterRequest(request) { res, data, error in
			guard error != nil else {
				print("Error: \(error!)")
				return
			}

			do {
				let json = try JSONSerialization.jsonObject(with: data!, options: [])
				print("json: \(json)")
			} catch let jsonError as NSError {
				print("json error: \(jsonError.localizedDescription)")
			}
		}
	}

}
