//
//  AppDelegate.swift
//  Kurinder
//
//  Created by Максим Ефимов on 09/10/2018.
//  Copyright © 2018 hapsidra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FUIAuthDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let user = Auth.auth().currentUser {
            print(user)
            let editVC = NameEditController()
            window?.rootViewController = UINavigationController(rootViewController: editVC)
        }
        else {
            let authUI = FUIAuth.defaultAuthUI()
            // You need to adopt a FUIAuthDelegate protocol to receive callback
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [
                FUIPhoneAuth(authUI: authUI!)
            ]
            authUI?.isSignInWithEmailHidden = true
            authUI?.shouldHideCancelButton = true
            authUI?.providers = providers
            
            let authViewController = authUI!.authViewController()
            let authVCView = authViewController.view!
            authViewController.topViewController?.view.backgroundColor = .white
            authViewController.isNavigationBarHidden = true
            
            let mainLabel = UILabel(frame: CGRect())
            mainLabel.font = UIFont(name: "GothamRounded-Book", size: 20.8)
            mainLabel.translatesAutoresizingMaskIntoConstraints = false
            mainLabel.text = "Discover new and interesting people nearby."
            mainLabel.textColor = UIColor.darkGray
            mainLabel.numberOfLines = 0
            mainLabel.textAlignment = .center
            authVCView.addSubview(mainLabel)
            mainLabel.leftAnchor.constraint(equalTo: authVCView.leftAnchor, constant: 20).isActive = true
            mainLabel.rightAnchor.constraint(equalTo: authVCView.rightAnchor, constant: -20).isActive = true
            mainLabel.topAnchor.constraint(equalTo: authVCView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            
            let image = UIImageView(frame: CGRect())
            image.backgroundColor = .red
            image.translatesAutoresizingMaskIntoConstraints = false
            authVCView.addSubview(image)
            image.leftAnchor.constraint(equalTo: authVCView.leftAnchor, constant: 65).isActive = true
            image.rightAnchor.constraint(equalTo: authVCView.rightAnchor, constant: -65).isActive = true
            image.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20).isActive = true
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 4 / 2.8).isActive = true
            image.layer.cornerRadius = 10
            image.layer.masksToBounds = true
            image.image = UIImage(named: "HelloImage")
            
            image.layer.shadowColor = UIColor.black.cgColor
            image.layer.shadowOpacity = 0.5
            image.layer.shadowOffset = CGSize(width: -1, height: 1)
            image.layer.shadowRadius = 1
            image.layer.shadowPath = UIBezierPath(rect: image.bounds).cgPath
            image.layer.shouldRasterize = true
            image.layer.rasterizationScale = UIScreen.main.scale
            image.backgroundColor = .blue
            image.contentMode = .scaleAspectFill
            
            window?.rootViewController = authViewController
        }
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // handle user (`authDataResult.user`) and error as necessary
        if let error = error {
            print(error.localizedDescription)
        }
        else if let user = authDataResult?.user {
            print(user.phoneNumber!)
            let editVC = NameEditController()
            window?.rootViewController = UINavigationController(rootViewController: editVC)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

