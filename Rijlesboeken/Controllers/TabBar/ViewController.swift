//
//  ViewController.swift
//  Rijlesboeken
//
//  Created by Prince on 21/04/22.
//

 import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var viewForTab: UIView!
    @IBOutlet weak var img_Home: UIImageView!
    @IBOutlet weak var img_Plaast: UIImageView!
    @IBOutlet weak var img_Lespakk: UIImageView!
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var img_More: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.designableTabBar()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {
            (Timer) in  self.forHome()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
//    override var overrideUserInterfaceStyle: UIUserInterfaceStyle {
//        return.light
//    }
    
    func designableTabBar(){
        viewForTab.layer.cornerRadius = 10
    }
    
    func forHome(){
        guard let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController  else { return }
        contentView.addSubview(home.view)
        home.didMove(toParent: self)
    }

    @IBAction func act_TabBar(_ sender: Any) {
        let tag = (sender as AnyObject).tag
        print(tag ?? "")
        
        if tag == 1 {
            //HomeViewController
            self.forHome()
        }else if tag == 2{
            //PlaatsViewController
            guard let Plaats = self.storyboard?.instantiateViewController(withIdentifier: "PlaastenVC") as? PlaastenVC  else { return }
            contentView.addSubview(Plaats.view)
            Plaats.didMove(toParent: self)
        }else if tag == 3{
            //LespakketteVC
            guard let Lespakkette = self.storyboard?.instantiateViewController(withIdentifier: "LespakketteViewController") as? LespakketteViewController  else { return }
            contentView.addSubview(Lespakkette.view)
            Lespakkette.didMove(toParent: self)
        }else if tag == 4{
            //ProfileViewController
            guard let Profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC  else { return }
            contentView.addSubview(Profile.view)
            Profile.didMove(toParent: self)
        }else{
            //MoreViewController
            guard let more = self.storyboard?.instantiateViewController(withIdentifier: "MoreVC") as? MoreVC  else { return }
            contentView.addSubview(more.view)
            more.didMove(toParent: self)
            
        }
        
    }
    
}

