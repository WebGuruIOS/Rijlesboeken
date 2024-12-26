//
//  FAQViewController.swift
//  Rijlesboeken
//
//  Created by Prince on 26/05/22.
//

import UIKit

//struct answerTypeModel{
//    var
//}

class FAQViewController: UIViewController {
    
    @IBOutlet weak var tbl_Faq: UITableView!
    var expandedIndexSet : IndexSet = []
    
    var faqData = [faqResponse]()
    var questionArr = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_Faq.rowHeight = UITableView.automaticDimension
        tbl_Faq.estimatedRowHeight = 120
        self.tbl_Faq.layer.cornerRadius = 40
        
//        self.tbl_Faq.delegate = self
//        self.tbl_Faq.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        faqApi()
    }
    
    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
//    @IBAction func act_1stQuestion(_ sender: Any) {
//       if self.btn_1StQues.isSelected{
//        btn_1StQues.isSelected = false
//        self.vw_1stView.isHidden = true
//        }else{
//            self.vw_1stView.isHidden = false
//            btn_1StQues.isSelected = true
//        }
//    }
    
//    @IBAction func act_2ndQuestion(_ sender: Any) {
//        if btn_2ndQues.isSelected{
//            btn_2ndQues.isSelected = false
//            self.vw_2ndView.isHidden = true
//        }else{
//            self.vw_2ndView.isHidden = false
//            btn_2ndQues.isSelected = true
//        }
//    }
    
//    @IBAction func act_4thQuestion(_ sender: Any) {
//        if btn_3rdQues.isSelected{
//            btn_3rdQues.isSelected = false
//            self.vw_3rdView.isHidden = true
//        }else{
//            btn_3rdQues.isSelected = true
//            self.vw_3rdView.isHidden = false
//        }
//    }
    
//    @IBAction func act_4thQuestions(_ sender: Any) {
//        if btn_4thQues.isSelected{
//            btn_4thQues.isSelected = false
//            self.vw_4thView.isHidden = true
//        }else{
//            self.vw_4thView.isHidden = false
//            btn_4thQues.isSelected = true
//        }
//    }
    
    func faqApi(){
        let parameters:[String:Any] = [:]
        FaqDataResponce.AddUserData(api: "getFaq", parameters: parameters) {
            (data) in
            if data != nil {
                let responseCode = data?.responseCode
                let responseText = data?.responseText
                let respoceData = data?.responseData
                if let data = data?.responseData{
                    self.faqData = []
                    for i in 0..<data.count {
                        self.faqData.append(data[i])
                    }
                    debugPrint("FAQ DATA:",self.faqData)
                }
                self.tbl_Faq.reloadData()
                print(respoceData as Any)
                switch responseCode {
                case 1:
                    debugPrint(responseCode!)
//                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")")
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText ?? "")" )
                }
            }
        }
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_Faq.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! FaqTVCell
        let dict = faqData[indexPath.row]
        cell.lbl_Question.text = dict.question
        cell.lbl_Answer.text = dict.answer
        cell.selectionStyle = .none
        cell.vw_Question.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 20)
        
        cell.btn_Plus.tag = indexPath.row
        cell.btn_Plus.addTarget(self, action:#selector(clickedOnBook(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func clickedOnBook(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row:tag, section:0)
        let cell = tbl_Faq.cellForRow(at: indexPath) as! FaqTVCell
        if sender.isSelected{
            cell.vw_Answer.isHidden = true
            cell.img_Plus.isHidden = false
            cell.img_minus.isHidden = true
            sender.isSelected = false
        }else{
            cell.vw_Answer.isHidden = false
            cell.img_Plus.isHidden = true
            cell.img_minus.isHidden = false
            sender.isSelected = true
        }
       
        self.tbl_Faq.reloadData()

    }
}



