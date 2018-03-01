//
//  TweetEntity.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import ObjectMapper

struct TweetsEntity: Mappable, CustomStringConvertible {

	var statuses: [StatusEntity]?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		statuses <- map["statuses"]
	}

	var description: String {
		get {
			return "TweetsEntity count: \(statuses?.count ?? 0)"
		}
	}

}

struct StatusEntity: Mappable {

	var entities: EntitiesEntity?
	var text: String?
	var user: UserEntity?
	var createdAt: Date?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss ZZZZZ yyyy"
		let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)

		entities <- map["entities"]
		text <- map["text"]
		user <- map["user"]
		createdAt <- (map["created_at"], dateTransform)
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

struct UserEntity: Mappable {

	var screenName: String?
	var profileImageURLString: String?

	var profileImageURL: URL? {
		get {
			guard let string = profileImageURLString else { return nil }
			return URL(string: string)
		}
	}

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		screenName <- map["screen_name"]
		profileImageURLString <- map["profile_image_url"]
		print(profileImageURLString ?? "")
	}

}
