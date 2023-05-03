//
//  MainTabController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Life Cycle
    
    private var user: User? {
        didSet {
            guard let user else {return}
            configVC(with: user)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    override func viewDidLayoutSubviews() {
        changeHeightOfTabBar()
    }
    
    //MARK: - API
    
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    //MARK: - Helpers

    func changeHeightOfTabBar() {
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 90
            tabFrame.origin.y = view.frame.size.height - 70
            tabBar.frame = tabFrame
        }
    }
    
    func configVC(with user: User) {
        let layout = UICollectionViewFlowLayout()
        let profile = ProfileController(user: user)
        let vc1 = UINavigationController(rootViewController: FeedController(collectionViewLayout: layout))
        let vc2 = UINavigationController(rootViewController: SearchController())
        let vc3 = UINavigationController(rootViewController: ImageSelectorController())
        let vc4 = UINavigationController(rootViewController: NotificationController())
        let vc5 = UINavigationController(rootViewController: profile)
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "home_unselected"), selectedImage: UIImage(named: "home_selected"))
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "search_unselected"), selectedImage: UIImage(named: "search_selected"))
        vc3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "plus_unselected"), selectedImage: UIImage(named: "plus_unselected"))
        vc4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "like_unselected"), selectedImage: UIImage(named: "like_selected"))
        vc5.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile_unselected"), selectedImage: UIImage(named: "profile_selected"))
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemGray5
    }

}

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true)

    }
    
    
}
