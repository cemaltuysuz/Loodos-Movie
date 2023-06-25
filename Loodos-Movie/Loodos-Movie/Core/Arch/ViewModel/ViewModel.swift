//
//  ViewModel.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import Foundation

class ViewModel {
    var onErrorReceived: ((NetworkErrorModel) ->Void)?
    var askRequestRepeat: ((@escaping(()-> Void)) -> Void)?
}
