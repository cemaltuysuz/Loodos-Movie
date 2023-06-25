//
//  BaseViewController.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

extension BaseViewController {
    func showAlert(
        title: String,
        description: String,
        possitiveButtonText: String,
        negativeButtonText: String? = nil,
        
        onClickedPossitveButton: (() -> Void)? = nil,
        onClickedNegativeButton: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            
            let possitiveAction = UIAlertAction(title: possitiveButtonText, style: .default) { _ in
                onClickedPossitveButton?()
            }
            
            alert.addAction(possitiveAction)
            if let negativeButtonText = negativeButtonText {
                let negativeAction = UIAlertAction(title: negativeButtonText, style: .cancel) { _ in
                    onClickedNegativeButton?()
                }
                alert.addAction(negativeAction)
            }
            
            alert.view.tintColor = .colorPrimary
            self.present(alert, animated: true)
        }
    }
}
