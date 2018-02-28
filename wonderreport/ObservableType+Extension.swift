//
//  ObservableType+Extension.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {

	public func unwrap<T>() -> Observable<T> where E == T? {
		return self.filter { $0 != nil }.map { $0! }
	}

}
