//
//  Tweet.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import ObjectMapper

struct Tweets: Mappable, CustomStringConvertible {

	var statuses: [Status]?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		statuses <- map["statuses"]
	}

	var description: String {
		get {
			return "Tweets count: \(statuses?.count ?? 0)"
		}
	}

}

struct Status: Mappable {

	var entities: Entities?
	var text: String?
	var user: User?
	var retweetedStatus: RetweetedStatus?
	var createdAt: Date?

	var isRT: Bool {
		get { return retweetedStatus != nil }
	}

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss ZZZZZ yyyy"
		let dateTransform = DateFormatterTransform(dateFormatter: dateFormatter)

		entities <- map["entities"]
		text <- map["text"]
		user <- map["user"]
		retweetedStatus <- map["retweeted_status"]
		createdAt <- (map["created_at"], dateTransform)
	}

}

struct RetweetedStatus: Mappable {

	var id: UInt64?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		id <- map["id"]
	}

}

struct Entities: Mappable {

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

struct User: Mappable {

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
