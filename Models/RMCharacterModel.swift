//
//  RMCharacterModel.swift
//  Demo
//
//  Created by Rahul Acharya on 22/10/24.
//
import Foundation

class RMInfo: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }

    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        count = try? container?.decodeIfPresent(Int.self, forKey: .count)
        pages = try? container?.decodeIfPresent(Int.self, forKey: .pages)
        next = try? container?.decodeIfPresent(String.self, forKey: .next)
        prev = try? container?.decodeIfPresent(String.self, forKey: .prev)
    }
}

class RMCharacter: Codable {
    var info: RMInfo?
    var results: [RMResults]?

    enum CodingKeys: String, CodingKey {
        case info = "info"
        case results = "results"
    }

    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        info = try? container?.decodeIfPresent(RMInfo.self, forKey: .info)
        results = try? container?.decodeIfPresent([RMResults].self, forKey: .results)
    }
}

class RMResults: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: RMGeneral?
    var location: RMGeneral?
    var episode: [String]?
    var url: String?
    var image: String?
    var created: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case episode = "episode"
        case url = "url"
        case image = "image"
        case created = "created"
    }

    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? container?.decodeIfPresent(Int.self, forKey: .id)
        name = try? container?.decodeIfPresent(String.self, forKey: .name)
        status = try? container?.decodeIfPresent(String.self, forKey: .status)
        species = try? container?.decodeIfPresent(String.self, forKey: .species)
        type = try? container?.decodeIfPresent(String.self, forKey: .type)
        gender = try? container?.decodeIfPresent(String.self, forKey: .gender)
        origin = try? container?.decodeIfPresent(RMGeneral.self, forKey: .origin)
        location = try? container?.decodeIfPresent(RMGeneral.self, forKey: .location)
        episode = try? container?.decodeIfPresent([String].self, forKey: .episode)
        url = try? container?.decodeIfPresent(String.self, forKey: .url)
        image = try? container?.decodeIfPresent(String.self, forKey: .image)
        created = try? container?.decodeIfPresent(String.self, forKey: .created)
    }
}

class RMGeneral: Codable {
    var name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }

    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        name = try? container?.decodeIfPresent(String.self, forKey: .name)
        url = try? container?.decodeIfPresent(String.self, forKey: .url)
    }
}
