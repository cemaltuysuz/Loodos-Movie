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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
