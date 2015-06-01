//
//  ViewController.swift
//  DynamicColorExample
//
//  Created by Yannick LORIOT on 01/06/15.
//  Copyright (c) 2015 Yannick LORIOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var normalColorView: UIView!
  @IBOutlet weak var transformedColorView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    normalColorView.backgroundColor      = UIColor.redColor()
    transformedColorView.backgroundColor = UIColor.redColor().darkenColor(0.2)
  }
}

