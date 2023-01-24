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
    
    fileprivate var gameModel = [
        SlotsModel(name: "slot1", backgroungImage: "ic_back_1",
                slotImageArray: ["SP1_0", "SP1_1", "SP1_2", "SP1_3", "SP1_4", "SP1_5", "SP1_6", "SP1_7", "SP1_8"], logoImage: "SP1_8", countLines: 5),
        SlotsModel(name: "slot2", backgroungImage: "ic_back_2",
                  slotImageArray: ["SP2_0", "SP2_1", "SP2_2", "SP2_3", "SP2_4", "SP2_5", "SP2_6", "SP2_7", "SP2_8"], logoImage: "SP2_8", countLines: 5),
        SlotsModel(name: "slot3", backgroungImage: "ic_back_3",
                  slotImageArray: ["SP3_0", "SP3_1", "SP3_2", "SP3_3", "SP3_4", "SP3_5", "SP3_6", "SP3_7", "SP3_8"], logoImage: "SP3_8", countLines: 5)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        scoresAmountView.roundCorners(corners: .allCorners, radius: 4)
        gamesSectionView.roundCorners(corners: [.topLeft, .topRight], radius: 40)
        leftSliderImageView.isHidden = true
        leftGameImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 9)
        scoresAmountLabel.text = ScoresModel.shared.getScore().description
    }
    
    @IBAction func changeScreenAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: setupButtons(isLeft: true)
        case 1: setupButtons(isLeft: false)
        default: setupButtons(isLeft: false)
        }
    }
    
    @IBAction func toGameAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: currentGameModel = gameModel[0]
        case 1: currentGameModel = gameModel[1]
        case 2: currentGameModel = gameModel[2]
        default: break
        }
        self.performSegue(withIdentifier: "startGame", sender: nil)
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


// MARK: - Overrides extension

extension MainViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}
