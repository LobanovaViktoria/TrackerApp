//
//  TrackersCollectionViewCell.swift
//  Tracker
//
//  Created by Viktoria Lobanova on 27.04.2023.
//

import UIKit

protocol TrackersCollectionViewCellDelegate: AnyObject {
    func completedTracker(id: UUID)
}

final class TrackersCollectionViewCell: UICollectionViewCell {

    public weak var delegate: TrackersCollectionViewCellDelegate?
    private var isCompletedToday: Bool = false
    private var trackerId: UUID? = nil
    private let limitNumberOfCharacters = 38
    
    private lazy var trackerView: UIView = {
        let trackerView = UIView()
        trackerView.layer.cornerRadius = 16
        trackerView.translatesAutoresizingMaskIntoConstraints = false
        return trackerView
    }()
    
    private lazy var emojiView: UIView = {
        let emojiView = UIView()
        emojiView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        emojiView.layer.cornerRadius = 12
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        return emojiView
    }()
    
    private lazy var emojiLabel: UILabel = {
        let emojiLabel = UILabel()
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        return emojiLabel
    }()
    
    private lazy var trackerNameLabel: UILabel = {
        let trackerNameLabel = UILabel()
        trackerNameLabel.font = .systemFont(ofSize: 12)
        trackerNameLabel.numberOfLines = 2
        trackerNameLabel.text = "Название трекера "
        trackerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return trackerNameLabel
    }()
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "0 дней"
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var checkButton: UIButton = {
        let checkButton = UIButton.systemButton(
            with: UIImage(systemName: "plus")!,
            target: self,
            action: #selector(didTapCheckButton)
        )
        checkButton.tintColor = .white
        checkButton.layer.cornerRadius = 17
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        return checkButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(trackerView)
        trackerView.addSubview(emojiView)
        emojiView.addSubview(emojiLabel)
        trackerView.addSubview(trackerNameLabel)
        contentView.addSubview(resultLabel)
        contentView.addSubview(checkButton)
        
       
        NSLayoutConstraint.activate([
            
            trackerView.heightAnchor.constraint(equalToConstant: 90),
            trackerView.widthAnchor.constraint(equalToConstant: 167),
            trackerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            emojiView.heightAnchor.constraint(equalToConstant: 24),
            emojiView.widthAnchor.constraint(equalToConstant: 24),
            emojiView.topAnchor.constraint(equalTo: trackerView.topAnchor, constant: 12),
            emojiView.leadingAnchor.constraint(equalTo: trackerView.leadingAnchor, constant: 12),
            
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor) ,
            emojiLabel.centerYAnchor.constraint(equalTo: emojiView.centerYAnchor),

            trackerNameLabel.topAnchor.constraint(equalTo: trackerView.topAnchor, constant: 44),
            trackerNameLabel.trailingAnchor.constraint(equalTo: trackerView.trailingAnchor, constant: -12),
            trackerNameLabel.leadingAnchor.constraint(equalTo: trackerView.leadingAnchor, constant: 12),
            trackerNameLabel.heightAnchor.constraint(equalToConstant: 34),
            
            checkButton.topAnchor.constraint(equalTo: trackerView.bottomAnchor, constant: 8),
            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            checkButton.heightAnchor.constraint(equalToConstant: 34),
            checkButton.widthAnchor.constraint(equalToConstant: 34 ),
            
            resultLabel.centerYAnchor.constraint(equalTo: checkButton.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func didTapCheckButton() {
        guard let id = trackerId else {
            print("Id not set")
            return
        }
        delegate?.completedTracker(id: id)
    }

    
    func setTrackerId(_ id: UUID) {
        trackerId = id
    }
    
    func setTrackerName(_ name: String) {
        trackerNameLabel.text = name
    }
    
    func setTrackerColor(_ color: UIColor) {
        trackerView.backgroundColor = color
    }
    
    func setTrackerEmoji(_ emoji: String) {
        emojiLabel.text = emoji
    }
    
    func setTrackerCheckButtonColor(_ color: UIColor) {
        checkButton.backgroundColor = color
    }
    
    func setIsCompletedToday(_ completed: Bool) {
        isCompletedToday = completed
        checkButton.setImage(isCompletedToday ? UIImage(systemName: "checkmark")! : UIImage(systemName: "plus")!, for: .normal)
    }
    
    func setCheckButtonIsEnabled(_ isEnabled: Bool) {
        checkButton.isEnabled = isEnabled
    }
    
    func setResultLabel(_ result: Int) {
        
        let mod10 = result % 10
        let mod100 = result % 100
        let not10To20 = mod100 < 10 || mod100 > 20
        
        var str = "\(result) "
        if result == 0 {
            str += "дней"
        } else if mod10 == 1 && not10To20 {
            str += "день"
        } else if (mod10 == 2 || mod10 == 3 || mod10 == 4) && not10To20 {
            str += "дня"
        } else {
            str += "дней"
        }
        resultLabel.text = str
    }
}

