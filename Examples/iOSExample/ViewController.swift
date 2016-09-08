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
    return [UIColor(hex: 0x3498db), UIColor(hex: 0xe74c3c)].gradient.colorPalette(amount: 12, inColorSpace: .hsl).map { ($0.toHexString(), $0) }
  }()

    /*{
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
      ("Mix Blue", mainColor.mixed(withColor: .blue)),
      ("Mix Green", mainColor.mixed(withColor: .green)),
      ("Mix Yellow", mainColor.mixed(withColor: .yellow)),
      ("Tinted", mainColor.tinted()),
      ("Shaded", mainColor.shaded())
    ]
  }()*/

  private lazy var gradients: [(String, UIColor)] = {
    return [UIColor(hex: 0x3498db), UIColor(hex: 0xe74c3c)].gradient.colorPalette(amount: 12).map { ($0.toHexString(), $0) }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    colorCollectionView.reloadData()
  }

  func collection(inSection section: Int) -> [(String, UIColor)] {
    return section == 0 ? colors : gradients
  }

  // MARK: - UICollectionView DataSource Methods

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collection(inSection: section).count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCellIdentifier, for: indexPath) as! ColorCellView

    let (title, color) = collection(inSection: indexPath.section)[indexPath.row]

    cell.titleLabel?.text           = title
    cell.colorView?.backgroundColor = color

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
    supplementaryView.titleLabel.text = indexPath.section == 0 ? "Colors" : "Gradients"
    
    return supplementaryView
  }
}

