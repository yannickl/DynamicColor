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
  @IBOutlet weak var titleLabel: UILabel?

  override func layoutSubviews() {
    super.layoutSubviews()

    if let _colorView = colorView {
      _colorView.layer.cornerRadius = _colorView.bounds.width / 2
    }
  }
}
