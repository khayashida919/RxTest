//
//  ViewController.swift
//  RxTest
//
//  Created by khayashida on 2019/04/02.
//  Copyright © 2019 khayashida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol Interface {
    var input: BehaviorRelay<String> { get }
    
    var output: PublishRelay<String> { get }
    
    func tapAction()
}

extension Interface {
    
    func tapAction() {
        var components = URLComponents(string: "http://zipcloud.ibsnet.co.jp/api/search")!
        components.queryItems = [URLQueryItem(name: "zipcode", value: input.value)]
        URLSession.shared.dataTask(with: components.url!) { (data, request, error) in
            
            let string = String(bytes: data!, encoding: .utf8)
            self.output.accept(string!)
            }.resume()
    }
}

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let viewModel: Interface = ViewModel()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infomationTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty
            .map { $0.count == 7 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.input)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .map { $0.count == 7 ? "OK" : "7文字で入力してください"}
            .bind(to: infomationTextView.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { (_) in
                self.viewModel.tapAction()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.asSignal()
            .emit(to: resultTextView.rx.text)
            .disposed(by: disposeBag)
    }
}

class ViewModel: Interface {
    var input = BehaviorRelay(value: "")
    var output = PublishRelay<String>()
}

