//
//  TweetEntity.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import ObjectMapper

struct TweetsEntity: Mappable {

	var statuses: [StatusEntity]?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		statuses <- map["statuses"]
	}

}

struct StatusEntity: Mappable {

	var entities: EntitiesEntity?
	var text: String?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		entities <- map["entities"]
		text <- map["text"]
	}

}

struct EntitiesEntity: Mappable {

	var urls: [AnyObject]?

	var firstExpandedURL: URL? {
		get {
			guard
				let urls = (urls?.first) as? [String: Any],
				let string = urls["expanded_url"] as? String
			else { return nil }
			return URL(string: string)
		}
	}

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		urls <- map["urls"]
	}

}
