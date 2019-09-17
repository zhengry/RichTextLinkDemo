//
//  ViewController.swift
//  RichTextLinkDemo
//
//  Created by zry on 2019/9/17.
//  Copyright © 2019 ZRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "请阅读并同意《用户注册协议》和《用户隐私协议》，如有疑问，请打开百度官方网站或通过GitHub项目来寻找答案。"
        let mutableText = NSMutableAttributedString(string: text)
        let rangeOfBaidu = text.range(of: "百度官方网站")
        let rangeOfGithub = text.range(of: "GitHub项目")
        let rangeOfRegister = text.range(of: "《用户注册协议》")
        let rangePrivacy = text.range(of: "《用户隐私协议》")
        // 添加超链接属性方法1: 超链接属性值为要打开的超链接地址
        mutableText.addAttribute(NSAttributedString.Key.link, value: "https://www.baidu.com", range: NSRange(rangeOfBaidu!,in: text))
        mutableText.addAttribute(NSAttributedString.Key.link, value: "https://github.com/", range: NSRange(rangeOfGithub!,in:text))
        
        // 添加超链接属性方法2，超链接属性值设置为自定义的URL Scheme
        mutableText.addAttribute(NSAttributedString.Key.link, value: "register://", range: NSRange(rangeOfRegister!,in: text))
        mutableText.addAttribute(NSAttributedString.Key.link, value: "privacy://", range: NSRange(rangePrivacy!,in:text))
        textView.attributedText = mutableText;
        textView.isEditable = false//需要设置textView为非编辑状态
    }


}

extension ViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        // 根据range来获取点击位置
        let rangeOfBaidu = textView.text.range(of: "百度官方网站")
        let rangeOfGithub = textView.text.range(of: "GitHub项目")
        //设置了Scheme也可以直接通过range来获取超链接
//        let rangeOfRegister = textView.text.range(of: "《用户注册协议》")
//        let rangePrivacy = textView.text.range(of: "《用户隐私协议》")
        
        // 区分要响应的超链接方法1：获取字符串range进行对比
        if characterRange == NSRange(rangeOfBaidu!,in: textView.text) {
            print("通过Safari打开百度网站")
            return true // return true：使用Safari打开超链接，前提是超链接属性的值是url
        }else if characterRange == NSRange(rangeOfGithub!,in: textView.text){
            print("通过Safari打开GitHub网站")
            return true
        }
        
        // 区分要响应的超链接方法2：根据设置的URL Scheme来响应不同的超链接
        if let scheme = URL.scheme {
            // 根据Scheme来区分点击位置
            if scheme == "register" {
                // 添加自定义操作
                print("点击了《用户注册协议》")
            }else if scheme == "privacy" {
                print("点击了《用户隐私协议》")
            }
        }
        return false// 不做外部跳转，所以return false
    }
}



