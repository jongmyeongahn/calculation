//
//  ViewController.swift
//  AppProject
//
//  Created by arthur on 6/22/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel()
    var expression = String()
    
    var userIsIntheMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        stackView()
    }
        private func configView() {
            view.backgroundColor = .black
            label.text = "0"
            label.textColor = .white
            label.textAlignment = .right
            label.font = .boldSystemFont(ofSize: 60)
    
            [label]
                .forEach { view.addSubview($0)}
            
            label.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(30)
                $0.trailing.equalToSuperview().inset(30)
                $0.top.equalToSuperview().offset(200)
                $0.height.equalTo(100)
    
            }
        }
    private func stackView() {
        
        let keypadStructure = [["7","8","9","+"],
                               ["4", "5", "6", "-"],
                               ["1", "2", "3", "*"],
                               ["AC", "0", "=", "/"]]
        
        let verticalStackView = UIStackView(/*arrangedSubviews: [label]*/)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 10
        
        keypadStructure.forEach { (keypadNames) in
            /// 계산기의 한줄을 맡는 Stackview
            let horizentalstackView = UIStackView()
            horizentalstackView.axis = .horizontal
            horizentalstackView.distribution = .fillEqually
            horizentalstackView.spacing = 10
            
            keypadNames.forEach { (keypadName) in
                let button = UIButton()
                button.setTitle(keypadName, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.frame.size.height = 80
                button.frame.size.width = 80
                button.layer.cornerRadius = 40
                button.titleLabel?.font = .boldSystemFont(ofSize: 30)
                
                if ( keypadName == "-" ||  keypadName == "+" || keypadName == "/" || keypadName == "*") {
                    button.backgroundColor = .orange
                    button.addTarget(self, action: #selector(numButtonClick(_:)), for: .touchUpInside)
                }
                else if keypadName == "AC" {
                    button.backgroundColor = .orange
                    button.addTarget(self, action: #selector(performOperator(_:)), for: .touchUpInside)
                } else if keypadName == "=" {
                    button.backgroundColor = .orange
                    button.addTarget(self, action: #selector(performOperator(_:)), for: .touchUpInside)
                } else {
                    button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
                    button.addTarget(self, action: #selector(numButtonClick(_:)), for: .touchUpInside)
                }
                
                horizentalstackView.addArrangedSubview(button)
                horizentalstackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
                
            }
            verticalStackView.addArrangedSubview(horizentalstackView)
        }
        
        view.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints {make in 
            make.top.equalTo(label.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func numButtonClick(_ button: UIButton) {
        //        guard let sender = button.currentTitle else { return numButtonClick(button) }
        //        self.currentNumber.append(button)
        //        label.text = currentNumber
        let digit = button.titleLabel?.text   //버튼의 현재 title
        //버튼을 누르게 되면 기존에 있던 0이 사라지고 버튼이 입력 됨
        if userIsIntheMiddleOfTyping {
            if let textCurrentlyInDisplay = label.text {
                label.text = textCurrentlyInDisplay + digit!
                expression = textCurrentlyInDisplay + digit!
            }
        } else {
            label.text = digit
             
        }
        
        userIsIntheMiddleOfTyping = true
    }
    
    @objc func performOperator(_ sender: UIButton) {
        // false로 만들어서 숫자입력시 새롭게 입력받음
        userIsIntheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            if mathematicalSymbol == "AC" {
                label.text = "0"
            } else if mathematicalSymbol == "=" {
                if let answer = calculate(expression: expression) {
                    label.text = String(answer)
                }
            }
        }
    }
    
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }

//    @objc func calculate(_ expression: String) {
//        let expression = NSExpression(format: expression)
//        label.text = "\(expression)"
//    }

}


//이전 코드 ////////////////////////////////////////////////////////////////////////////////////////////
//
//class ViewController: UIViewController {
//    
//    //    var currentNumber = "0"
//    
//    private var userIsInTheMiddleOfTyping: Bool = false
//    
//    let label = UILabel()
//    
//    //버튼 기본 설정
//    func button(title: String , color: UIColor) -> UIButton {
//        let bt = UIButton()
//        bt.titleLabel?.font = .boldSystemFont(ofSize: 30)
//        bt.backgroundColor = color
//        bt.setTitle(title, for: .normal)
//        bt.setTitleColor(.white, for: .normal)
//        bt.frame.size.height = 80
//        bt.frame.size.width = 80
//        bt.layer.cornerRadius = 40
//        return bt
//    }
//    
//    // 스택뷰 설정
//    var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .red
//        stackView.alignment = .center
//        stackView.distribution = .fillEqually
//        stackView.spacing = 10
//        return stackView
//    }()
//    
//    //    var verticalStacView: UIStackView = {
//    //        let verticalStackView = UIStackView()
//    //        verticalStackView.axis = .vertical
//    //        verticalStackView.backgroundColor = .purple
//    //        verticalStackView.alignment = .center
//    //        verticalStackView.distribution = .fillEqually
//    //        verticalStackView.spacing = 10
//    //        return verticalStackView
//    //    }()
//    //
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        configView()
//        firstStackView()
//        //        verFirstStackView()
//        buttonColor(titleSet: row1, stack: &stackView)
//        createUIView()
//        
//        
//    }
//    // 라벨
//    private func configView() {
//        view.backgroundColor = .black
//        label.text = "0"
//        label.textColor = .white
//        label.textAlignment = .right
//        label.font = .boldSystemFont(ofSize: 60)
//        
//        [label]
//            .forEach { view.addSubview($0)}
//        
//        label.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(30)
//            $0.trailing.equalToSuperview().inset(30)
//            $0.top.equalToSuperview().offset(200)
//            $0.height.equalTo(100)
//            
//        }
//    }
//    // 스택뷰
//    private func firstStackView() {
//        
//        self.view.addSubview(stackView)
//        
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(label.snp.bottom).offset(60)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(80)
//            make.width.equalTo(350)
//        }
//    }
//    
//    //    private func verFirstStackView() {
//    //
//    //        self.view.addSubview(verticalStacView)
//    //
//    //        verticalStacView.snp.makeConstraints { make in
//    //            make.top.equalTo(stackView.snp.bottom).offset(10)
//    //            make.leading.equalTo(stackView.snp.leading)
//    //            make.width.equalTo(80)
//    //            make.height.equalTo(350/4 * 3)
//    //
//    //        }
//    //    }
//    
//    let row1 = ["7","8","9","+"]
//    
//    
//    // 버튼 스택뷰에 구현
//    private func buttonColor(titleSet: [String], stack: inout UIStackView) {
//        for text in titleSet{
//            var color = UIColor()
//            if text == titleSet[3]{
//                color = UIColor.orange
//            }else{
//                color = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
//            }
//            
//            let bt = button(title: text, color: color)
//            
//            stack.addArrangedSubview(bt)
//            bt.translatesAutoresizingMaskIntoConstraints = false
//            bt.heightAnchor.constraint(equalToConstant: 80).isActive = true
//            bt.addTarget(self, action: #selector(numButtonClick), for: .touchDown)
//        }
//        
//    }
//    @objc private func numButtonClick(_ button: UIButton) {
//        //        guard let sender = button.currentTitle else { return numButtonClick(button) }
//        //        self.currentNumber.append(sender)
//        //        label.text = currentNumber
//        let digit = button.titleLabel?.text   //버튼의 현재 title
//        //버튼을 누르게 되면 기존에 있던 0이 사라지고 버튼이 입력 됨
//        if userIsInTheMiddleOfTyping {
//            if let textCurrentlyInDisplay = label.text {
//                label.text = textCurrentlyInDisplay + digit!
//            }
//        } else {
//            label.text = digit
//        }
//        userIsInTheMiddleOfTyping = true
//    }
//    /// displaydhk keypad 버튼을 stackView로 생성하는 함수
//    func createUIView() {
//        let keypadStructure = [["4", "5", "6", "-"],
//                               ["1", "2", "3", "*"],
//                               ["AC", "0", "=", "/"]]
//        
        /// 전체적인 스택뷰
//        let fullOfCalculatorView = UIStackView(arrangedSubviews: [label])
//        fullOfCalculatorView.axis = .vertical
//        fullOfCalculatorView.distribution = .fillEqually
//        fullOfCalculatorView.spacing = 10
//
//        self.view.addSubview(fullOfCalculatorView)
        
        
//        keypadStructure.forEach { (keypadNames) in
//            /// 계산기의 한줄을 맡는 Stackview
//            let oneOfRowView = UIStackView()
//            oneOfRowView.axis = .horizontal
//            oneOfRowView.spacing = 10
//            oneOfRowView.distribution = .fillEqually
            
            //            keypadNames.forEach { (keypadName) in
            //                let button = UIButton()
            //                button.setTitle(keypadName, for: .normal)
            //                button.setTitleColor(.white, for: .normal)
            //                button.frame.size.height = 80
            //                button.frame.size.width = 80
            //                button.layer.cornerRadius = 40
            //                button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            //
            //                if (keypadName == "AC" || keypadName == "-" || keypadName == "=" ||  keypadName == "+" || keypadName == "/") {
            //                    button.backgroundColor = .orange
            //                    button.addTarget(self, action: #selector(performOperator(_:)), for: .touchUpInside)
            //                }
            //                else {
            //                    button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            //                    button.addTarget(self, action: #selector(keypadButtonTapped(_:)), for: .touchUpInside)
            //                }
            //
            //                oneOfRowView.addArrangedSubview(button)
            //            }
            //            fullOfCalculatorView.addArrangedSubview(oneOfRowView)
            //        }
            //
            //        view.addSubview(fullOfCalculatorView)
            
            //        fullOfCalculatorView.snp.makeConstraints { make in
            //            make.top.equalTo(stackView.snp.bottom).offset(10)
            //            make.centerX.equalToSuperview()
            //            make.height.equalTo(350/4 * 3)
            //            make.width.equalTo(350)
            //        }
            
            
            //        fullOfCalculatorView.translatesAutoresizingMaskIntoConstraints = false
            //
            //        fullOfCalculatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
            //        fullOfCalculatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
            //        fullOfCalculatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
            //        fullOfCalculatorView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
//    }
//}
//    
    // Selector
//    var userIsIntheMiddleOfTyping = false
//
//    /// keypad 클릭시 동작하는 함수
//    @objc func keypadButtonTapped(_ sender: UIButton) {
//        let digit = sender.currentTitle!
//
//        if userIsIntheMiddleOfTyping {
//            let textCurrentlyInDisplay = label.text!
//            label.text = textCurrentlyInDisplay + digit
//        } else {
//            label.text = digit
//        }
//
//        userIsIntheMiddleOfTyping = true
//    }
//
//    @objc func performOperator(_ sender: UIButton) {
//        // false로 만들어서 숫자입력시 새롭게 입력받음
//        userIsIntheMiddleOfTyping = false
//        if let mathematicalSymbol = sender.currentTitle {
//            if mathematicalSymbol == "𝝿" {
//                label.text = String(M_PI)
//            }
//        }
//    }
//}
