//
//  MainViewController.swift
//  LDITest
//
//  Created by Sergei Demianenko on 21.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var scoresView: UIView!
    @IBOutlet private weak var scoresAmountView: UIView!
    @IBOutlet private weak var scoresAmountLabel: UILabel!
    
    @IBOutlet private weak var gamesSectionView: UIView!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var allGamesButton: UIButton!
    @IBOutlet private weak var leftSliderImageView: UIImageView!
    @IBOutlet private weak var rightSliderImageView: UIImageView!
    
    @IBOutlet private weak var popularGameView: UIView!
    @IBOutlet private weak var allGamesView: UIView!
    @IBOutlet private weak var allGamesStackView: UIStackView!
    @IBOutlet private weak var leftGameView: UIView!
    @IBOutlet private weak var leftGameImageView: UIImageView!
    @IBOutlet private weak var rightGameView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupUI() {
        scoresView.roundCorners(corners: .allCorners, radius: 3)
        gamesSectionView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
        leftSliderImageView.isHidden = true
        leftGameImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 9)
    }
    
    
    @IBAction func changeScreenAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: setupButtons(isLeft: true)
        case 1: setupButtons(isLeft: false)
        default: setupButtons(isLeft: true)
        }
    }
    
    fileprivate func setupButtons(isLeft: Bool) {
        let grayColor = UIColor.init(red: 113, green: 112, blue: 118)
        leftSliderImageView.isHidden = !isLeft
        rightSliderImageView.isHidden = isLeft
        allGamesStackView.isHidden = isLeft
        switch isLeft {
        case true:
            popularButton.setTitleColor(.white, for: .normal)
            popularButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            allGamesButton.setTitleColor(grayColor, for: .normal)
            allGamesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        case false:
            popularButton.setTitleColor(grayColor, for: .normal)
            popularButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            allGamesButton.setTitleColor(.white, for: .normal)
            allGamesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
}

