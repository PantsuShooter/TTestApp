//
//  UserLoginViewController.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/11/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit

protocol UserLoginViewControllerDelegate {
    func selected(socialNetwork:String, atIndex:Int)
}

class UserLoginViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    public var delegate:UserLoginViewControllerDelegate?
   
    public enum SocialNetworkTypes : Int{
        case Facebook
        case Instagram
        case Vk
        func name () -> String {
            switch self {
                case .Facebook: return "facebook"
                case .Instagram: return "instagram"
                case .Vk : return "vk"
            }
        }
    }
    
    private struct Constants {
        static let CellIdentifier = "serviceCell"
        static let NibName = UINib(nibName: "LoginViaServiceCell", bundle:nil)
    }
    
    private var typesArray = [String]()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        view.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.6)
        setupLoginView()
    }
    
    // MARK: - setup's
    private func setupLoginView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collectionFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        let loginCollection = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        loginCollection.delegate = self
        loginCollection.dataSource = self
        loginCollection.register(Constants.NibName, forCellWithReuseIdentifier: Constants.CellIdentifier)
        loginCollection.backgroundColor = .clear
        loginCollection.showsVerticalScrollIndicator = false
        loginCollection.showsHorizontalScrollIndicator = false

        view.addSubview(loginCollection)
        
        typesArray.append(SocialNetworkTypes.Facebook.name())
        typesArray.append(SocialNetworkTypes.Instagram.name())
        typesArray.append(SocialNetworkTypes.Vk.name())
    }
    
    // MARK: - DataSource
    // MARK: - UITableViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typesArray.count
    }
    
    // MARK: - Delegate
    // MARK: - UISearchBarDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier, for: indexPath) as? ServiceTableViewCell else { return UICollectionViewCell()}
        
        let imageName = typesArray[indexPath.row]
        
        cell.setImage(image: UIImage(named: imageName)!)
        
        return cell
    }
    
    // MARK: - UserLoginViewControllerDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let socialNetworkName = SocialNetworkTypes.init(rawValue: indexPath.row)?.name() else {return}
        delegate?.selected(socialNetwork: socialNetworkName, atIndex: indexPath.row)
    }
}
