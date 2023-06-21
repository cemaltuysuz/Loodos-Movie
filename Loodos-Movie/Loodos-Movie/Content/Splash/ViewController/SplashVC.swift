//
//  SplashVC.swift
//  Loodos-Movie
//
//  Created by Cemal Tuysuz on 19.06.2023.
//

import UIKit
import Lottie
import SnapKit

class SplashVC: ViewController<SplashVM> {
    
    private lazy var contentVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12.0
        return stackView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.font(.cabinSemiBold, size: 38.0)
        label.textColor = .colorPrimary
        label.textAlignment = .center
        return label
    }()
    
    private lazy var reConnectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reconnect".localized, for: .normal)
        button.addTarget(self, action: #selector(self.onClickedConnectButton), for: .touchUpInside)
        button.backgroundColor = .colorPrimary
        button.isHidden = true
        return button
    }()
    
    private lazy var animContainerView: UIView = {
        return UIView.makeClearContentView
    }()
    
    private lazy var splashLoadingAnim: LottieAnimationView = {
        let view = LottieAnimationView(name: "ThreeBallLoading")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        configureRCValues()
        setupBindings()
        viewModel.enterFlow()
    }
    
    func configureUI() {
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64.0)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
        }
        
        view.addSubview(contentVStackView)
        contentVStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.center.equalToSuperview()
        }
        
        contentVStackView.addArrangedSubview(animContainerView)
        animContainerView.snp.makeConstraints { make in
            make.height.equalTo(70.0)
        }
        
        animContainerView.addSubview(splashLoadingAnim)
        splashLoadingAnim.snp.makeConstraints { make in
            make.size.equalTo(animContainerView.snp.height).multipliedBy(0.8)
            make.center.equalToSuperview()
        }
        
        contentVStackView.addArrangedSubview(reConnectButton)
        reConnectButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
        }
    }
    
    func configureRCValues() {
        if let splashTitleText = RCValues.sharedInstance.getValue(from: Constants.RCValues.splashTitle).stringValue {
            infoLabel.text = splashTitleText
            infoLabel.isHidden = false
        }
    }
    
    func setupBindings() {
        viewModel.onStateChanged = { [weak self] state in
            
            switch state {
                
            case .monitoringStarted:
                DispatchQueue.main.async {
                    self?.reConnectButton.isHidden = true
                    self?.splashLoadingAnim.changeVisibilityWithAnimation(isHidden: false)
                    self?.splashLoadingAnim.play()
                }
                break
                
            case .noInternetConnection:
                DispatchQueue.main.async {
                    self?.splashLoadingAnim.changeVisibilityWithAnimation(isHidden: true)
                    self?.reConnectButton.changeVisibilityWithAnimation(isHidden: false)
                    self?.splashLoadingAnim.stop()
                }
                break
                
            case .continueMoviesPage:
                let vm = MoviesVM()
                let vc = MoviesVC(viewModel: vm)
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
                break
            }
        }
    }
}

@objc
extension SplashVC {
    func onClickedConnectButton() {
        viewModel.enterFlow()
    }
}
