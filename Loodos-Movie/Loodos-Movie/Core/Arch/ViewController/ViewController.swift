//
//  ViewController.swift
//  Loodos-Movie
//
//  Created by cemal tüysüz on 24.06.2023.
//

import Foundation

class ViewController<T: ViewModel>: BaseViewController {
    
    var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureBaseBindings() {
        viewModel.askRequestRepeat = {[weak self] shouldRepeat in
            self?.showAlert(title: "Request Failed".localized,
                            description: "Your request has been failed. Do you want to try again ?".localized,
                            possitiveButtonText: "Yes".localized,
                            negativeButtonText: "No".localized,
                            onClickedPossitveButton: {
                shouldRepeat()
            })
        }
        
        viewModel.onErrorReceived = {[weak self] error in
            self?.showAlert(title: "Request Failed".localized,
                            description: "Your request has been failed. Please, try again later.",
                            possitiveButtonText: "Close".localized)
        }
    }
}
