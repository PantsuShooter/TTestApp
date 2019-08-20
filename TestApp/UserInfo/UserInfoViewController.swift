//
//  UserInfoViewController.swift
//  TestApp
//
//  Created by Цындрин Антон on 19.08.2019.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol UserInfoViewControllerDelegate {
    func logoutButtonPressed()
}

class UserInfoViewController: UIViewController {
    
    // MARK: - Variables
    public var delegate:UserInfoViewControllerDelegate?
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userInfoLabel: UILabel!
    
    private var nemeText = ""
    private var imgLink = ""

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = nemeText
        userImageView.layer.cornerRadius = userImageView.frame.height / 2.0
        userImageView.layer.masksToBounds = true
        userImageView.sd_setImage(with: URL(string: imgLink), placeholderImage: UIImage(named: "User_Icon"))
        navigationItem.title = "Info"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - setup's
    public func setupInfoView(model:UserModel) {
       nemeText = model.userName
       imgLink = model.userImageUrl
    }
    
    // MARK: - UserInfoViewControllerDelegate
    @IBAction func logoutButtonAction(_ sender: Any) {
        delegate?.logoutButtonPressed()
    }
    
}
