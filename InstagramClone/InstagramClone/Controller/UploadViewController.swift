//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Burak Erden on 5.05.2023.
//

import UIKit

protocol UploadViewControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(controller: UploadViewController)
}

class UploadViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: UploadViewControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter caption.."
        tv.autocorrectionType = .no
        tv.delegate = self
        return tv
    }()
    
    private let lineView: UIView = {
       let lv = UIView()
        lv.backgroundColor = .lightGray
        return lv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/100"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        view.addSubview(photoImageView)
        photoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.setDimensions(height: 180, width: 180)
        
        view.addSubview(captionTextView)
        captionTextView.centerX(inView: view, topAnchor: photoImageView.bottomAnchor, paddingTop: 16)
        captionTextView.setDimensions(height: 100, width: view.bounds.width - 24)
        
        view.addSubview(lineView)
        lineView.anchor(top: captionTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 1)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor, paddingBottom: 6, paddingRight: 12)
    }
    
    //MARK: - Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapDone() {
        guard let selectedImage else {return}
        guard let currentUser else {return}
        showLoader(true)        //indicator
        
        PostService.uploadPost(caption: captionTextView.text, image: selectedImage, user: currentUser) { error in
            self.showLoader(false)      //indicator

            if let error = error {
                print("DEBUG: Failed to upload post \(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadingPost(controller: self)
        }
        
    }
}

extension UploadViewController: UITextViewDelegate {
    
        func textViewDidChange(_ textView: UITextView) {
            characterCountLabel.text = "\(textView.text.count)/100"
        }
    
    // How to set limit to textView
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText = textView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
            return updatedText.count <= 100
        }
}
