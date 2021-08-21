import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SignUpViewAttributes {
    func setUI()
}

class SignUp1View: UIViewController {
    
    var vm = SignUpViewModel()
    var disposebag = DisposeBag()
    
    let backgroundView = UIImageView(image: UIImage(named: "background"))
    
    let chooseLabel = UILabel().then {
        $0.text = "가입 유형을 선택해주세요"
        $0.textColor = UIColor.mainColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let artistButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "profile_image"), for: .normal)
        $0.setTitle("Artist", for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceLeftToRight
        $0.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    
    let peopleButton =  UIButton(type: .system).then {
        $0.setImage(UIImage(named: "profile_image"), for: .normal)
        $0.setTitle("People", for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = .boldSystemFont(ofSize: 12)
        $0.contentHorizontalAlignment = .center
        $0.semanticContentAttribute = .forceLeftToRight
        $0.imageEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    

}

extension SignUp1View: SignUpViewAttributes {
    
    func setUI() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        makeStackView()
    }
    
    func makeStackView() {
        let buttonStackView = UIStackView(arrangedSubviews: [artistButton, peopleButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually
        
        let mainStackView = UIStackView(arrangedSubviews: [chooseLabel, buttonStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 15
        mainStackView.distribution = .fillEqually
        
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.centerX.centerY.equalToSuperview()
        }

    }
    
    func bind() {
        Observable.merge(
            artistButton.rx.tap.map { true },
            peopleButton.rx.tap.map { false }
        )
        .bind(to: vm.stepOne.tap)
        .disposed(by: disposebag)
        
        vm.stepOne.tap.bind { _ in
            let vc = SignUp2View(vm: self.vm)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        .disposed(by: disposebag)
    }
    
}