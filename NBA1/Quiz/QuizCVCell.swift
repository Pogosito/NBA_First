//
//  QuizCVCell.swift
//  NBA1
//
//  Created by Погос  on 10.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit

protocol QuizCVCellDelegate: class {
    func didChooseAnswer(btnIndex: Int)
}

class QuizCVCell: UICollectionViewCell {
    
    var btn1: UIButton!
    var btn2: UIButton!
    var btn3: UIButton!
    var btn4: UIButton!
    var btnsArray = [UIButton]()
    
    weak var delegate: QuizCVCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        btnsArray = [btn1, btn2, btn3, btn4]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imgView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let lblQue: UILabel = {
        let lbl = UILabel()
        //lbl.text = "This is a question and you have to answer it?"
        lbl.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 4
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
     }()
    
    var question: Question? {
        didSet {
            guard let unwrappedQue = question else { return }
            imgView.image = UIImage(named: unwrappedQue.imgName)
            lblQue.text = unwrappedQue.questionText
            btn1.setTitle(unwrappedQue.options[0], for: .normal)
            btn2.setTitle(unwrappedQue.options[1], for: .normal)
            btn3.setTitle(unwrappedQue.options[2], for: .normal)
            btn4.setTitle(unwrappedQue.options[3], for: .normal)
            
            if unwrappedQue.isAnswered {
                btnsArray[unwrappedQue.correctAns].backgroundColor=UIColor.green
                if unwrappedQue.wrongAns >= 0 {
                    btnsArray[unwrappedQue.wrongAns].backgroundColor=UIColor.red
                }
            }
        }
    }
    
    func getButton(tag: Int) -> UIButton {
        let btn = UIButton()
        btn.tag = tag
        btn.setTitle("Option", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }
    
    override func prepareForReuse() {
        btn1.backgroundColor = UIColor.white
        btn2.backgroundColor = UIColor.white
        btn3.backgroundColor = UIColor.white
        btn4.backgroundColor = UIColor.white
    }
    
    func setupViews() {
        addSubview(imgView)
        //imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: screenHeight / 7.5).isActive = true
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: screenWidth * 0.7).isActive = true
        imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive = true
        
        addSubview(lblQue)
        lblQue.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10).isActive = true
        lblQue.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.8).isActive = true
        lblQue.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let btnWidth: CGFloat = 160
        let btnHeight: CGFloat = 50
        btn1 = getButton(tag: 0)
        addSubview(btn1)
        NSLayoutConstraint.activate([btn1.topAnchor.constraint(equalTo: lblQue.bottomAnchor, constant: 10), btn1.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), btn1.widthAnchor.constraint(equalToConstant: btnWidth), btn1.heightAnchor.constraint(equalToConstant: btnHeight)])
        btn1.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        btn2 = getButton(tag: 1)
        addSubview(btn2)
        NSLayoutConstraint.activate([btn2.topAnchor.constraint(equalTo: btn1.topAnchor), btn2.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), btn2.widthAnchor.constraint(equalToConstant: btnWidth), btn2.heightAnchor.constraint(equalToConstant: btnHeight)])
        btn2.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        btn3 = getButton(tag: 2)
        addSubview(btn3)
        NSLayoutConstraint.activate([btn3.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: 10), btn3.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), btn3.widthAnchor.constraint(equalToConstant: btnWidth), btn3.heightAnchor.constraint(equalToConstant: btnHeight)])
        btn3.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        btn4 = getButton(tag: 3)
        addSubview(btn4)
        NSLayoutConstraint.activate([btn4.topAnchor.constraint(equalTo: btn3.topAnchor), btn4.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), btn4.widthAnchor.constraint(equalToConstant: btnWidth), btn4.heightAnchor.constraint(equalToConstant: btnHeight)])
        btn4.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
    }
    
    @objc func btnOptionAction(sender: UIButton) {
        guard let unwrappedQue = question else { return }
        if !unwrappedQue.isAnswered {
            delegate?.didChooseAnswer(btnIndex: sender.tag)
        }
    }
}
