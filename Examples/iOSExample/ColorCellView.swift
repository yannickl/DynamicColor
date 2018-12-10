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

  func layoutColorView() {
    if let cv = colorView {
      cv.layer.cornerRadius = cv.bounds.width / 2
    }
  }
}
