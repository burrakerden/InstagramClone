//
//  CommentsController.swift
//  InstagramClone
//
//  Created by Burak Erden on 11.05.2023.
//

import UIKit

class CommentsController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let reuseIdentifier = "CommentCell"
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        title = "Comments"
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    //MARK: - Actions
    
}

//MARK: - UICollectionViewDataSource

extension CommentsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.backgroundColor = .systemRed
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension CommentsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 12)
    }
}
