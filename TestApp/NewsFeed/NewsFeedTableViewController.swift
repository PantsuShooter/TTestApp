//
//   NewsFeedTableViewController.swift
//  TestApp
//
//  Created by DeveloperMBP on 8/10/19.
//  Copyright © 2019 DeveloperMBP. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Presentr
import FacebookLogin
import FacebookCore
import FacebookShare
import FBSDKCoreKit
import SDWebImage

class NewsFeedTableViewController: UITableViewController, UserLoginViewControllerDelegate, UserInfoViewControllerDelegate, UISearchResultsUpdating {

    // MARK: - Variables
    private var selectedModel:NewsModel?
    private var newsArray = [NewsModel]()
    private var storedSearchText = ""
    private let fbLoginManager = LoginManager()
    private let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet private weak var userButton: UIButton!

    private struct Constants {
        static let CellIdentifier = "newsCell"
        static let UserProfileImageSize:CGFloat = 33.0
        struct Segue {
            static let ToWebView = "toWebView"
            static let ToUserInfo = "toUserInfo"
        }
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        updateUserImg()
        setupSearchController()
        
        newsArray = Array(NewsManager.shared.getNews())
        debugPrint("NewsFeedTableViewController viewDidLoad")
    }
        
    // MARK: - setup's
    private func fbSetup() {
        fbLoginManager.loginBehavior = .browser
        fbLoginManager.defaultAudience = .everyone
    }
    
    private func setupNavBar() {
        navigationItem.title = "Feed"
        navigationController?.navigationItem.largeTitleDisplayMode = .never
             UINavigationBar.appearance().largeTitleTextAttributes =
                 [NSAttributedString.Key.foregroundColor: UIColor.green]
             navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchController() {
        searchController.searchBar.showsCancelButton = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
    }
        
    // MARK: - Action's
    @IBAction private func userItemAction(_ sender: Any) {
        if AccessToken.current != nil, UDManager.shared.getUser() != nil {
            showUserInfo()
        } else {
            showSocialNetworkTab()
        }
    }
    
    @IBAction private func searchItemAction(_ sender: Any) {
        
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
        } else {
            navigationItem.searchController?.removeFromParent()
            navigationItem.searchController = nil
            navigationController?.view.setNeedsLayout()
            newsArray = Array(NewsManager.shared.getNews())
            tableView.reloadData()        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint("NewsFeedTableViewController prepare for segue :\(segue.identifier!)")
        if segue.identifier == Constants.Segue.ToWebView {
            if let viewController = segue.destination as? NewsWebPageViewController {
                guard let modelToUse = selectedModel, let link = modelToUse.url else {return}
                viewController.urlToOpen(url: URL(string: link)!)
            }
        } else if segue.identifier == Constants.Segue.ToUserInfo {
            if let viewController = segue.destination as? UserInfoViewController {
                guard let user = UDManager.shared.getUser() else {return}
                viewController.setupInfoView(model: user)
                viewController.delegate = self
            }
        }
    }
    
    // MARK: - DataSource
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count//NewsManager.shared.getNews().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath) as? NewsFeedTableViewCell else { return UITableViewCell()}
        let news = newsArray[indexPath.row]
        cell.setuCell(news: news)
        return cell
    }
                
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        selectedModel = newsArray[indexPath.row]
        if (selectedModel?.url) != nil {
            performSegue(withIdentifier: Constants.Segue.ToWebView, sender: self)
        }
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        newsArray = Array(NewsManager.shared.getSortedResult(string: searchController.searchBar.text!))
        tableView.reloadData()
    }
    
    // MARK: - UserLoginViewControllerDelegate
    func selected(socialNetwork: String, atIndex: Int) {
        debugPrint(socialNetwork)
        dismiss(animated: true) {
            if socialNetwork == UserLoginViewController.SocialNetworkTypes.Facebook.name() {
                self.fbLogin()
            } else {
               
                let message = "Sorry \(socialNetwork) is not supported =("

                let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UserInfoViewControllerDelegate
    func logoutButtonPressed() {
        self.navigationController?.popViewController(animated: true)
        self.fbLoginManager.logOut()
        UDManager.shared.removeUser()
        updateUserImg()
    }

    // MARK: - Private
    private func fbLogin(){
        self.fbLoginManager.logIn(permissions: [.publicProfile], viewController: nil, completion:
            { (loginResult) in
            debugPrint(loginResult)
                switch loginResult {
                case .failed(let error):
                    debugPrint("FACEBOOK LOGIN FAILED: \(error)")
                case .cancelled:
                    debugPrint("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    debugPrint("Logged in!")
                    debugPrint("GRANTED PERMISSIONS: \(grantedPermissions)")
                    debugPrint("DECLINED PERMISSIONS: \(declinedPermissions)")
                    debugPrint("ACCESS TOKEN \(accessToken)")
                    RequestManager.shared.getUresInfo { (userModel) in
                        debugPrint(userModel)
                        UDManager.shared.storUser(userModel: userModel)
                        self.updateUserImg()
                    }
                }
        })
    }
    
    private func showSocialNetworkTab() {
        let presenter: Presentr = {
            let width = ModalSize.full
            let height = ModalSize.fluid(percentage: 0.11)
            let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y:view.frame.height -  (view.frame.height / 9) ))
            let customType = PresentationType.custom(width: width, height: height, center: center)
            let customPresenter = Presentr(presentationType: customType)
            customPresenter.roundCorners = true
            customPresenter.dismissOnSwipe = true
            customPresenter.dismissOnSwipeDirection = .bottom
            return customPresenter
        }()
        
        let controller = UserLoginViewController()
        controller.delegate = self
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
    }
    
    private func showUserInfo() {
        performSegue(withIdentifier: Constants.Segue.ToUserInfo, sender: self)
    }
    
    private func updateUserImg() {
        self.userButton.imageView?.layer.cornerRadius = Constants.UserProfileImageSize / 2.0
        if let imgLink = UDManager.shared.getUser()?.userImageUrl {
            SDWebImageDownloader.shared.downloadImage(with: URL(string: imgLink)) { (img, data, error, bool) in
                if let sImg = img {
    
                    let rsImg = sImg.imageFromImage(resizeTo: CGSize(width: Constants.UserProfileImageSize, height: Constants.UserProfileImageSize))
                    self.userButton.setImage(rsImg, for: .normal)
                }
            }
        } else {
            let img = UIImage(named: "User_Icon")
            let rsImg = img?.imageFromImage(resizeTo: CGSize(width: Constants.UserProfileImageSize, height: Constants.UserProfileImageSize))
            self.userButton.setImage(rsImg, for: .normal)
        }
    }
}
