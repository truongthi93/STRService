//
//  ViewController.swift
//  STRServiceExample
//
//  Created by Quyen Nguyen The on 2/26/19.
//  Copyright © 2019 Quyen Nguyen The. All rights reserved.
//

import UIKit
import STRService
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGesture()
    }
    func testLoginService() {
        LoginService().execute(onSuccess: { (any) in
            print(any)
        }) { (error) in
            print(error)
        }
    }
    func setTapGesture() {
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGest)
    }
    func testListChargeService() {
//        ListChargeService().execute(onSuccess: { (dic) in
//            print(dic)
//        }) { (error) in
//            print(error)
//        }
    }
    @objc func tapped() {
        testLoginService()
    }
    @IBAction func abtnListPaymens(_ sender: Any) {
        testListChargeService()
    }
    @IBAction func abtnUsers(_ sender: Any) {
        testLoginService()
    }
    
}

