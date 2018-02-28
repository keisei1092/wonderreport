//
//  URL+Extension.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation

extension URL {

	public var queryParameters: [String: String]? {
		guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
			return nil
		}

		var parameters = [String: String]()
		for item in queryItems {
			parameters[item.name] = item.value
		}

		return parameters
	}

}

