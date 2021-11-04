//
//  SearchVC.swift
//  Github Followers
//
//  Created by Abdirizak Hassan on 10/23/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextFeild = GFTextFeild()
    let callToActionBtn = GFButton(backgroundColor: .systemGreen, title: "Get Fallowers")
    var logoImageViewTopcConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { return !usernameTextFeild.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallActionBtn()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextFeild.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap  = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please Enter a username. weneed to know who to look for 😁", buttonTitle: "ok")
            return
        }
        
        usernameTextFeild.resignFirstResponder()
        let followersListVC = FolloweListVC(username: usernameTextFeild.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopcConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(topConstraintConstant) )
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextFeild)
        usernameTextFeild.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextFeild.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextFeild.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    func configureCallActionBtn() {
        view.addSubview(callToActionBtn)
        callToActionBtn.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
