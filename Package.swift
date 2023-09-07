// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFPopup",
    products: [
        .library(name: "FFPopup", targets: ["FFPopup"])
    ],
    targets: [
        .target(
            name: "FFPopup",
            path: "FFPopup",
            publicHeadersPath: "",
            cSettings: [
                .headerSearchPath("")
            ]
        )
    ]
)
