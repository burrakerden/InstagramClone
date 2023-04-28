//
//  ProfileController.swift
//  InstagramClone
//
//  Created by Burak Erden on 7.04.2023.
//

import UIKit

let cellIdentifier = "profileCell"
let headerdentifier = "profileHeader"

class ProfileController: UICollectionViewController {
    
    //MARK: - Properties


    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        view.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerdentifier)
    }
    
    //MARK: - Actions


}
