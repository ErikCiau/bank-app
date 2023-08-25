//
//  ViewController.swift
//  Bankapp
//
//  Created by Erik Ciau on 22/08/23.
//
import UIKit
class ViewController: UIViewController {
    func setTitle() -> String? { nil }
    func setContraints() -> [NSLayoutConstraint]? { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = setTitle()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let constraints = setContraints() {
            NSLayoutConstraint.activate(constraints)
        }
    }
}
