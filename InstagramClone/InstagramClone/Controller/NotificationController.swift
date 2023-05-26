//
//  NotificationController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {

    //MARK: - Properties
    
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNotifications()
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

    //MARK: - API
    
    func fetchNotifications () {
        NotificationService.fetchNotification { notifications in
            self.notifications = notifications
        }
    }
    
//    func checkIfUserIsFollowed() {
//        notifications.forEach { <#Notification#> in
//            <#code#>
//        }
//    }
    
    //MARK: - Actions

    //MARK: - UITalbeViewDataSource
    
}

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

//MARK: - UITalbeViewDataSource

extension NotificationController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - NotificationCellDelegate

extension NotificationController: NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow uid: String) {
        print("DEBUG: FOLLOW")
    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        print("DEBUG: UNFOLLOW")
    }
    
    func cell(_ cell: NotificationCell, wantsToViewPost postId: String) {
        print("DEBUG: WANTS TO VIEW POST")

    }
    
    
}
