//
//  LaunchViewController.swift
//  LDITest
//
//  Created by Sergei Demianenko on 22.01.2023.
//

import Foundation
import UIKit

final class LaunchViewController: UIViewController {
    
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var progressLoader: UIProgressView! {
        didSet {
            progressLoader.setProgress(0, animated: true)
        }
    }
    
    fileprivate var progressBarTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.setupLoader()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupLoader() {
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self,
                                                     selector: #selector(loading),
                                                     userInfo: nil, repeats: true)
        progressLoader.progressTintColor = UIColor.init(red: 100, green: 220, blue: 207)
        progressLoader.progressViewStyle = .bar
    }
    
    @objc private func loading() {
        progressLoader.progress += 0.1
        progressLoader.setProgress(progressLoader.progress, animated: true)
        if progressLoader.progress == 1.0 {
            progressBarTimer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.performSegue(withIdentifier: "goToGame", sender: nil)
            }
        }
    }

}

