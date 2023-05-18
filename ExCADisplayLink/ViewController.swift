//
//  ViewController.swift
//  ExCADisplayLink
//
//  Created by 김종권 on 2023/05/18.
//

import UIKit

class ViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var displayLink: CADisplayLink?
    private var dispatchWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func tap() {
        startDisplayLink()
    }
    
private func startDisplayLink() {
    stopDisplayLink()
    displayLink = CADisplayLink(target: self, selector: #selector(update))
    displayLink?.preferredFramesPerSecond = 10
    displayLink?.add(to: .main, forMode: .default)
    
    let workItem = DispatchWorkItem(block: { [weak self] in
        self?.stopDisplayLink()
    })
    dispatchWorkItem = workItem
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: workItem)
}

@objc private func update() {
    print("frame", view.frame)
}

private func stopDisplayLink() {
    displayLink?.invalidate()
    displayLink = nil
    dispatchWorkItem?.cancel()
}
}
