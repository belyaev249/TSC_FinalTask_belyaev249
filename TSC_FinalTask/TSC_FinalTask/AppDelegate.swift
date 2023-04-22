//
//  AppDelegate.swift
//  TSC_FinalTask
//
//  Created by Egor on 22.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = MainModuleViewController(viewModel: MainModuleViewModel())
        
        window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

