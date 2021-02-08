//
//  LLSpinner.swift
//  MyWeather
//
//  Created by Ali Hassan on 08/02/2021.
//

import UIKit

open class LLSpinner {
    internal static var spinnerView: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .large
    public static var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.6)
    
    internal static var touchHandler: (() -> Void)?
    
    public static func spin(style: UIActivityIndicatorView.Style = style, backgroundColor: UIColor = backgroundColor, touchHandler: (() -> Void)? = nil) {
        if spinnerView == nil,
           let window = UIWindow.key {
            let frame = UIScreen.main.bounds
            spinnerView = UIActivityIndicatorView(frame: frame)
            spinnerView!.backgroundColor = backgroundColor
            spinnerView!.style = style
            spinnerView!.color = .white
            window.addSubview(spinnerView!)
            spinnerView!.startAnimating()
        }
        
        if touchHandler != nil {
            self.touchHandler = touchHandler
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runTouchHandler))
            spinnerView!.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc internal static func runTouchHandler() {
        if touchHandler != nil {
            touchHandler!()
        }
    }
    
    public static func stop() {
        if let _ = spinnerView {
            spinnerView!.stopAnimating()
            spinnerView!.removeFromSuperview()
            spinnerView = nil
        }
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

