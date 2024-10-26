//
//  NetworkRepository.swift
//  m3u8player
//
//  Created by Kaito Kitaya on 13.10.24.
//
import Foundation


protocol NetworkRepository {    
    func checkIsValidURL(url: URL) async  -> Result<HTTPURLResponse, Error>
}
