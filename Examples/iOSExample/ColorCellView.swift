//
//  ColorCellView.swift
//  DynamicColorExample
//
//  Created by Yannick LORIOT on 02/06/15.
//  Copyright (c) 2015 Yannick LORIOT. All rights reserved.
//

import UIKit

final class ColorCellView: UICollectionViewCell {
  @IBOutlet weak var colorView: UIView?
  @IBOutlet weak var titleLabel: UILabel!

  override func layoutSubviews() {
    super.layoutSubviews()

    // iOS 10 bug: the content view layout is not called when the view is loaded
    contentView.layoutSubviews()

    if let cv = colorView {
      cv.layer.cornerRadius = cv.bounds.width / 2
    }
  }
}
