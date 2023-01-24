//
//  GameViewController.swift
//  LDITest
//
//  Created by Sergei Demianenko on 24.01.2023.
//

import Foundation
import UIKit

var currentGameModel: SlotsModel? = nil

final class GameViewController: UIViewController {
    
    @IBOutlet private weak var pickersView: UIPickerView!
    @IBOutlet private weak var scoresView: UIView!
    @IBOutlet private weak var scoresAmountLabel: UILabel!
    @IBOutlet private weak var pushLabel: UILabel!
    @IBOutlet private weak var stepperElement: GMStepper!
    @IBOutlet private weak var spinView: UIView!
    @IBOutlet private weak var spinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentGame = currentGameModel
        setupUI()
    }
    
    var currentGame: SlotsModel?
    fileprivate var currentBank: Int = ScoresModel.shared.getScore()
    
    fileprivate func setupUI() {
        pickersView.dataSource = self
        pickersView.delegate = self
        pickersView.isUserInteractionEnabled = false
        
        spinView.roundCorners(corners: .topLeft, radius: 100)
        
        scoresView.roundCorners(corners: .allCorners, radius: 3)
        scoresView.layerGradient(startPoint: .centerLeft, endPoint: .centerRight,
                                 colorArray: [UIColor(red: 0.953, green: 0.651, blue: 0.306, alpha: 1).cgColor, UIColor(red: 0.929, green: 0.471, blue: 0.247, alpha: 1).cgColor], type: .axial)
        spinButton.setImage(UIImage(named: "ic_spin_button"), for: .normal)
        scoresAmountLabel.text = String(currentBank)
        stepperElement.maximumValue = Double(currentBank / 2)
    }
    
    
    @IBAction private func spinAction(_ sender: UIButton) {
        let beforeRotatingBank = currentBank
        if currentBank > 0 {
            var slotLine: [Int] = []
            for i in 0..<(currentGame?.countLines ?? 1) {
                pickersView.selectRow((currentGame?.randomSlot())!, inComponent: i, animated: true)
                slotLine.append(Int(pickersView.selectedRow(inComponent: i)))
            }
            currentBank = (currentGame?.equalInLine(lineArray: slotLine, currentBank: currentBank, currentBet: stepperElement.value))!
            scoresAmountLabel.text = String(currentBank)
        }
        let afterRotatingBank = currentBank
        if currentBank <= 0 {
            scoresAmountLabel.text = "Game Over"}
        else {
            pushLabel.text = currentGame?.infoLabelText(before: beforeRotatingBank, after: afterRotatingBank)
            stepperElement.maximumValue = Double(currentBank)
        }
        ScoresModel.shared.setScores(value: currentBank)
    }
    
    @IBAction private func backAction(_ sender: UIButton) {
//        self.navigationController?.popToRootViewController(animated: true)
//        self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "goBack", sender: nil)
    }
}


// MARK: - Overrides extension

extension GameViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeRight
        } else {
            return .landscapeRight
        }
    }
}


// MARK: - Picker protocols extension

extension GameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return currentGame?.countLines ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (currentGame?.pickerImageLine().count ?? 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return (pickersView.bounds.height / CGFloat((currentGame?.slotImageArray.count) ?? 1)) * 2
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (pickersView.bounds.width / CGFloat((currentGame?.slotImageArray.count) ?? 1)) * 1.5
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView()
        let width = (pickersView.bounds.width / CGFloat((currentGame?.slotImageArray.count ?? 1))) * 2
        let height = (pickersView.bounds.height / CGFloat((currentGame?.slotImageArray.count ?? 1))) * 2
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        myImageView.image = UIImage(named: (currentGame?.pickerImageLine()[row]) ?? "")?.withRenderingMode(.alwaysOriginal)
        myImageView.contentMode = .scaleAspectFit
        myView.addSubview(myImageView)
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let position = (currentGame?.slotImageArray.count ?? 1) / 2 + row
        pickersView.selectRow(position, inComponent: 0, animated: false)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row % 10)
    }
    
}
