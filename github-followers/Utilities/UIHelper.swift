//
//  UIHelper.swift
//  github-followers
//
//  Created by Mark Battistella on 7/10/21.
//

import UIKit

enum UIHelper {
	
	static func createColumnFlowLayout(in view: UIView, columns: Int) -> UICollectionViewFlowLayout {
		// math
		let width = view.bounds.width
		let spacing: CGFloat = 12
		let columnSpaces: CGFloat = CGFloat(columns + 1)
		let availableWidth = (width - (spacing * columnSpaces))
		let itemWidth = availableWidth / 3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		
		return flowLayout
	}
}
