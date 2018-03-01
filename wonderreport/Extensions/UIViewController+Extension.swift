//
//  UIViewController+Extension.swift
//  wonderreport
//
//  Created by Keisei Saito on 2018/02/28.
//  Copyright © 2018 Keisei Saito. All rights reserved.
//

import UIKit

extension UIViewController {

	public class func instantiateFromStoryboard() -> Self {
		return self.instantiateFromStoryboard(self)
	}

	private class func instantiateFromStoryboard<T>(_ type: T.Type) -> T {
		let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		return vc as! T
	}

}
