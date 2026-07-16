//
//  DummyViewController.swift
//  Pods
//
//  Created by Neelam Soni on 15/07/26.
//

class DummyViewController: UIViewController {
    override func loadView() {
        let v = UIView()
        v.backgroundColor = .clear // Transparent content area
        self.view = v
    }
}
