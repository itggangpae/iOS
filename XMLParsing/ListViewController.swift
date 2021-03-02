//
//  ListViewController.swift
//  XMLParsing
//
//  Created by Adam on 2021/03/03.
//

import UIKit

class ListViewController: UITableViewController {
    var book : Book!
    var currentElementValue : String!
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        let xmlParser = XMLParser(contentsOf: url!)
        xmlParser?.delegate = self
        let success = xmlParser?.parse()
       
        if success == true {
            let alert = UIAlertController(title:"XML 파싱", message: "파싱 완료.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            // 메시지창 실행
            self.present(alert, animated: true, completion: nil)
            self.title = "파싱 성공"
        }
        else {
            let alert = UIAlertController(title:"XML 파싱", message: "파싱 실패", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            // 메시지창 실행
            self.present(alert, animated: false)
            self.title = "파싱 실패"
        }
        
    }
    override func tableView(_ tableView: UITableView,
                                didSelectRowAt indexPath: IndexPath){
            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailViewController.book = books[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Potentially incomplete method implementation.
            // Return the number of sections.
            return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return books.count
    }

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:UITableViewCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = books[indexPath.row].title
            cell.accessoryType = .disclosureIndicator
               return cell
    }
    
}

extension ListViewController:XMLParserDelegate{
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Book"
        {
            book = Book()
            let dic = attributeDict as Dictionary
            book?.bookId = dic["id"]
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Books"{
            return
        }
        if elementName == "Book"
        {
            books.append(book!)
            book = nil
        }
        else{
            if elementName == "title"{
                book?.title = currentElementValue
            }
            else if elementName == "author"{
                book?.author = currentElementValue
            }
            else if elementName == "summary"{
                book?.summary = currentElementValue
            }
            currentElementValue = nil
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //처음 호출되는 것이라면  currentElementValue에 메모리 할당하고 string대입
        if currentElementValue == nil{
            currentElementValue = string
        }
        //처음 호출되는 경우가 아니라면 이전 데이터에 이어 붙이기
        else{
            currentElementValue = "\(currentElementValue!)\(string)"
        }
    }
}
