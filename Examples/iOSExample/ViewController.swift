//
//  ViewController.swift
//  DynamicColorExample
//
//  Created by Yannick LORIOT on 01/06/15.
//  Copyright (c) 2015 Yannick LORIOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
  private let ColorCellIdentifier = "ColorCell"

  @IBOutlet weak var colorCollectionView: UICollectionView!

  private lazy var colors: [(String, UIColor)] = {
    let mainColor = UIColor(hexString: "#c0392b")

    return [
      ("Original", mainColor),
      ("Lighter", mainColor.lighter()),
      ("Darkered", mainColor.darkened()),
      ("Saturated", mainColor.saturated()),
      ("Desaturated", mainColor.desaturated()),
      ("Grayscaled", mainColor.grayscaled()),
      ("Adjusted", mainColor.adjustedHue(amount: 45)),
      ("Complemented", mainColor.complemented()),
      ("Inverted", mainColor.inverted()),
      ("Mix Blue", mainColor.mixed(color: .blue)),
      ("Mix Green", mainColor.mixed(color: .green)),
      ("Mix Yellow", mainColor.mixed(color: .yellow)),
      ("Tinted", mainColor.tinted()),
      ("Shaded", mainColor.shaded())
    ]
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    colorCollectionView.reloadData()
  }

  // MARK: - UICollectionView DataSource Methods

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCellIdentifier, for: indexPath) as! ColorCellView

    let (title, color) = colors[(indexPath as NSIndexPath).row]

    cell.titleLabel?.text           = title
    cell.colorView?.backgroundColor = color

    return cell
  }
}

