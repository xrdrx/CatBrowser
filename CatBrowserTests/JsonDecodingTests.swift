//
//  JsonDecodingTests.swift
//  CatBrowserTests
//
//  Created by Aleksandr Svetilov on 10.02.2021.
//

import XCTest
@testable import CatBrowser

class JsonDecodingTests: XCTestCase {

    let decoder = JSONDecoder()
    let rawJson = """
    [{"breeds":[],"id":"MTYwNzk5MA","url":"https://cdn2.thecatapi.com/images/MTYwNzk5MA.jpg","width":3872,"height":2592},{"breeds":[],"id":"MTYzNzQwMA","url":"https://cdn2.thecatapi.com/images/MTYzNzQwMA.gif","width":245,"height":138},{"breeds":[{"weight":{"imperial":"7 - 15","metric":"3 - 7"},"id":"ocic","name":"Ocicat","cfa_url":"http://cfa.org/Breeds/BreedsKthruR/Ocicat.aspx","vetstreet_url":"http://www.vetstreet.com/cats/ocicat","vcahospitals_url":"https://vcahospitals.com/know-your-pet/cat-breeds/ocicat","temperament":"Active, Agile, Curious, Demanding, Friendly, Gentle, Lively, Playful, Social","origin":"United States","country_codes":"US","country_code":"US","description":"Loyal and devoted to their owners, the Ocicat is intelligent, confident, outgoing, and seems to have many dog traits. They can be trained to fetch toys, walk on a lead, taught to 'speak', come when called, and follow other commands. ","life_span":"12 - 14","indoor":0,"alt_names":"","adaptability":5,"affection_level":5,"child_friendly":4,"dog_friendly":5,"energy_level":5,"grooming":1,"health_issues":3,"intelligence":5,"shedding_level":3,"social_needs":5,"stranger_friendly":5,"vocalisation":3,"experimental":0,"hairless":0,"natural":0,"rare":0,"rex":0,"suppressed_tail":0,"short_legs":0,"wikipedia_url":"https://en.wikipedia.org/wiki/Ocicat","hypoallergenic":1,"reference_image_id":"JAx-08Y0n"}],"id":"TboUiIDUO","url":"https://cdn2.thecatapi.com/images/TboUiIDUO.jpg","width":1200,"height":804},{"breeds":[{"weight":{"imperial":"8 - 20","metric":"4 - 9"},"id":"raga","name":"Ragamuffin","cfa_url":"http://cfa.org/Breeds/BreedsKthruR/Ragamuffin.aspx","vetstreet_url":"http://www.vetstreet.com/cats/ragamuffin","vcahospitals_url":"https://vcahospitals.com/know-your-pet/cat-breeds/ragamuffin","temperament":"Affectionate, Friendly, Gentle, Calm","origin":"United States","country_codes":"US","country_code":"US","description":"The Ragamuffin is calm, even tempered and gets along well with all family members. Changes in routine generally do not upset her. She is an ideal companion for those in apartments, and with children due to her patient nature.","life_span":"12 - 16","indoor":0,"lap":1,"alt_names":"","adaptability":5,"affection_level":5,"child_friendly":4,"dog_friendly":5,"energy_level":3,"grooming":3,"health_issues":3,"intelligence":5,"shedding_level":3,"social_needs":3,"stranger_friendly":5,"vocalisation":1,"experimental":0,"hairless":0,"natural":0,"rare":0,"rex":0,"suppressed_tail":0,"short_legs":0,"wikipedia_url":"https://en.wikipedia.org/wiki/Ragamuffin_cat","hypoallergenic":0,"reference_image_id":"SMuZx-bFM"}],"id":"jI2dXfp26","url":"https://cdn2.thecatapi.com/images/jI2dXfp26.png","width":1259,"height":630},{"breeds":[],"id":"she0LOHH2","url":"https://cdn2.thecatapi.com/images/she0LOHH2.jpg","width":735,"height":490}]
    """
    
    func testJsonCanBeDecoded() {
        XCTAssertNoThrow(try decoder.decode([CatImageData].self, from: Data(rawJson.utf8)))
    }
    
    func testCorrectDecodeCatImageData() {
        let expected = CatImageData(breeds: [], id: "MTYwNzk5MA", url: "https://cdn2.thecatapi.com/images/MTYwNzk5MA.jpg", width: 3872, height: 2592)
        let result = try! decoder.decode([CatImageData].self, from: Data(rawJson.utf8))[0]
        XCTAssertEqual(expected, result)
    }
    
    func testCorrectDecodeCatInfo() {
        let expected = CatInfo(id: "ocic", name: "Ocicat")
        let result = try! decoder.decode([CatImageData].self, from: Data(rawJson.utf8))[2].breeds[0]
        XCTAssertEqual(expected, result)
    }

}
