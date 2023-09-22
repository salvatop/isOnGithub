//
//  UserProfileView.swift
//  isOnGithub
//
//  Created by Salvatore Palazzo on 2023-09-22.
//

import UIKit

final class UserProfileView: UIView {

    lazy var avatar: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var bio: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var contentContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var avatarContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    var labelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    private func createSubviews() {

        
        labelsStack.addArrangedSubview(name)
        labelsStack.addArrangedSubview(bio)
     
        labelsStack.setCustomSpacing(10.0, after: name)
        labelsStack.setCustomSpacing(10.0, after: bio)
        
        avatarContainer.addArrangedSubview(avatar)
        
        contentContainer.addArrangedSubview(avatarContainer)
        contentContainer.addArrangedSubview(labelsStack)
        contentContainer.setCustomSpacing(10.0, after: avatarContainer)
        
        mainContainer.addArrangedSubview(contentContainer)
        
        addSubview(mainContainer)
        
        NSLayoutConstraint.activate([
            mainContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            mainContainer.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

