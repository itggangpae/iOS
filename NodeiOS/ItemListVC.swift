import UIKit
import Alamofire

class ItemListVC: UITableViewController {
    //AppDelegate 클래스의 인스턴스에 대한 참조를 저장할 프로퍼티
    var appDelegate : AppDelegate! = nil
    
    
    //다운로드 받을 데이터를 저장할 배열
    var itemList = Array<Item>()
    
    //페이지 번호와 페이지 당 데이터 개수를 저장할 프로퍼티
    var pageno = 1
    var count = 15
    
    //테이블 뷰의 가장 하단에 데이터가 출력되었는지 확인
    var flag = false;
    
    
    //마지막 업데이트 한 시간을 가져와서 리턴하는 메소드
    func checkUpdateTime(){
        //업데이트 한 시간 저장하기
        let updateurl = "http://172.30.30.93:5000/item/updatetime"
        //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
        let updaterequest = AF.request(updateurl, method: .get, encoding: JSONEncoding.default, headers:[:])
        updaterequest.responseJSON{
            response in
            if let jsonObject = response.value as? [String : Any]{
                let serverUpdateTime = jsonObject["result"] as! String
                if(self.appDelegate.updateTime != nil){
                    print("로컬의 업데이트 시간:" + self.appDelegate.updateTime! )
                }
                print("서버의 업데이트 시간:" + serverUpdateTime)
                var msg : String? = nil
                if(self.appDelegate.updateTime == nil){
                    msg = "데이터가 없어서 서버에서 다운로드"
                    self.appDelegate.updateTime = serverUpdateTime
                    self.pageno = 1
                    let alert = UIAlertController(title: "데이터 조회", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel){(_ action) in self.downloadData()})
                    self.present(alert, animated: false)
                }
                else if(self.appDelegate.updateTime != serverUpdateTime){
                    msg = "데이터가 업데이트되서 서버에서 다운로드"
                    self.appDelegate.updateTime = serverUpdateTime
                    self.pageno = 1
                    let alert = UIAlertController(title: "데이터 조회", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel){(_ action) in
                                        self.itemList.removeAll()
                                        self.downloadData()})
                    self.present(alert, animated: false)
                }
                else{
                    msg = "현재 저장된 데이터에서 변경된 내용이 없어서 저장된 내용 출력"
                    let alert = UIAlertController(title: "데이터 조회", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                    self.present(alert, animated: false)
                }
                
            }
        }
    }
    
    //데이터를 가져와서 저장하는 메소드
    func downloadData(){
        //다운로드 받을 URL 만들기
        let url = "http://172.30.30.93:5000/item/list?pageno=\(pageno)&count=\(count)"
        
        //데이터 가져오기
        //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
        request.responseJSON{
            response in
            NSLog("\(response.value!)")
            if let jsonObject = response.value as? [String : Any]{
                let list = jsonObject["list"] as! NSArray
                for index in 0...(list.count-1){
                    //하나의 객체 가져오기
                    let itemDict = list[index] as! NSDictionary
                    var item = Item()
                    //Item 배열의 각 데이터를 가져와서 Item 객체의 프로퍼티에 대입
                    item.itemid = ((itemDict["itemid"] as! NSNumber).intValue)
                    item.itemname = itemDict["itemname"] as? String
                    item.price = ((itemDict["price"] as! NSNumber).intValue)
                    item.description = itemDict["description"] as? String
                    item.pictureurl = itemDict["pictureurl"] as? String
                    item.updatedate = itemDict["updatedate"] as? String
                    //웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                    let imageurl: URL! = URL(string: "http://172.30.30.93:5000/img/\(item.pictureurl!)")
                    let imageData = try! Data(contentsOf: imageurl!)
                    item.image = UIImage(data:imageData)
                    
                    //배열에 데이터 저장
                    self.itemList.append(item)
                }
                NSLog("데이터 저장 성공")
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        checkUpdateTime()
    }
    
    //검색바 객체 생성
    let searchController = UISearchController(searchResultsController: nil)
    
    //검색된 결과를 저장할 리스트 생성
    var filteredItems = [Item]()
    
    //검색 입력 란에 아무 내용도 없는지 확인할 메소드
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //검색 입력 란에 내용을 입력하면 호출되는 메소드
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = itemList.filter({(item : Item) -> Bool in
            return item.itemname!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    //검색 입력 란의 상태를 리턴하는 메소드
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    @objc func add(_ sender:UIBarButtonItem){
        let itemAddVC = self.storyboard?.instantiateViewController(identifier: "ItemAddVC") as! ItemAddVC
        self.navigationController?.pushViewController(itemAddVC, animated: true)
    }
    
    var addBtn:UIBarButtonItem! = nil
    var loginBtn:UIBarButtonItem! = nil

    @objc func login(_ sender:UIBarButtonItem){
        if sender.title == "로그인"{
            let alert = UIAlertController(title: "로그인",
                                          message: "아이디와 비밀번호를 입력하세요",
                                          preferredStyle: .alert)
            alert.addTextField() { (tf) in tf.placeholder = "아이디를 입력하세요!" }
            alert.addTextField() { (tf) in tf.placeholder = "비밀번호를 입력하세요!"
                tf.isSecureTextEntry = true
            }
            
            alert.addAction(UIAlertAction(title: "취소", style: .cancel)) // 취소 버튼
            alert.addAction(UIAlertAction(title: "로그인", style: .default) {
                (_) in // 확인 버튼
                
                let id = alert.textFields?[0].text
                let pw = alert.textFields?[1].text
                
                let parameters = ["memberid" : id!, "memberpw":pw!]
                
                let request = AF.request("http://172.30.30.93:5000/member/login", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
                request.responseJSON{
                    response in
                    if let jsonObject = response.value as? [String : Any]{
                        let result = jsonObject["result"] as! Bool
                        var msg : String!
                        if result == true{
                            msg = "로그인 성공"
                            sender.title = "로그아웃"
                            
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let member = jsonObject["member"] as! [String:Any]
                            appDelegate.id = member["memberid"] as? String
                            appDelegate.nickname = member["membernickname"] as? String
                            self.title = appDelegate.nickname
                        }else{
                            msg = "로그인 실패:아이디나 비밀번호가 틀렸습니다."
                        }
                        
                        let alert = UIAlertController(title: "로그인",
                                                      message: msg,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alert, animated: false)
                    }
                }
                
            })
            self.present(alert, animated: false)
            
        }else{
            let alert = UIAlertController(title: "로그인",
                                          message: "로그아웃 하셨습니다.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
            sender.title = "로그인"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //타이틀 설정
        title = "아이템"
        //AppDelegate 인스턴스에 대한 참조 가져오기
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action:#selector(handleRefresh(_:)),
            for:.valueChanged)
        refreshControl?.tintColor = UIColor.red
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Item"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
//        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
//        self.navigationItem.rightBarButtonItem = addBtn
        
        addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        loginBtn = UIBarButtonItem(title: "로그인", style: .done, target: self, action: #selector(login(_:)))

        self.navigationItem.rightBarButtonItems = [addBtn, loginBtn]


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUpdateTime()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return itemList.count
        if isFiltering(){
            return filteredItems.count
        }
        
        if(pageno * count >= itemList.count){
            return itemList.count
        }else{
            return pageno * count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if isFiltering() {
            // 주어진 행에 맞는 데이터 소스를 읽어온다.
            let item = self.filteredItems[indexPath.row]
            cell!.textLabel!.text = item.itemname
            cell!.detailTextLabel!.text = item.description
            cell!.imageView!.image = item.image
        }
        else{
            let item = self.itemList[indexPath.row]
            cell!.textLabel!.text = item.itemname
            cell!.detailTextLabel!.text = item.description
            cell!.imageView!.image = item.image
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if (flag == false && indexPath.row == self.pageno * count - 1 ) {
            flag = true
        }else if(flag == true && indexPath.row == self.pageno * count - 1){
            self.pageno = self.pageno + 1
            downloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailVC = self.storyboard?.instantiateViewController(identifier: "ItemDetailVC") as! ItemDetailVC
        if isFiltering() {
            itemDetailVC.item = self.filteredItems[indexPath.row]
        }else{
            itemDetailVC.item = self.itemList[indexPath.row]
        }
    
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1.삭제할 행의 itemid를 구한다.
        let itemid = itemList[indexPath.row].itemid
        
        // 2.그리고 테이블 뷰에서 차례대로 삭제한다.
        self.itemList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        // 3. 서버에서 데이터 삭제
        let parameters = ["itemid" : "\(itemid!)"]
        NSLog(parameters.description)
        
        let request = AF.request("http://172.30.30.93:5000/item/delete", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
        request.responseJSON{
            response in
            //print(response.result.value!)
            if let jsonObject = response.value as? [String : Any]{
                let result = jsonObject["result"] as! Int32
                
                var msg : String!
                if result == 1{
                    msg = "성공"
                }else{
                    msg = "실패:\(jsonObject["error"] as! String)"
                }
                
                let alert = UIAlertController(title: "데이터 삭제",
                                              message: msg,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
            }
        }
    }
}

extension ItemListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
