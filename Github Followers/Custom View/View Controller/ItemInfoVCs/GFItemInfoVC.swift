//
//  GFItemInfoVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 11/2/21.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionBtn = GFButton()
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionBtn()
    }
    
    
    func configureBackgroundView() {
        view.layer.cornerRadius = 20
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    
    private func configureActionBtn() {
        actionBtn.addTarget(self, action: #selector(actionBtnTapped), for: .touchUpInside)
    }

    @objc func actionBtnTapped() {
        
    }
    
    func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionBtn)
         
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
}
