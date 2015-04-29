![](SwiftCache.png)

A beautifully lightweight cache written for **Swift**. It has been tested on iOS and OS X. I wrote it over an hour because I couldn't find something good enough and I think you'll like it.

When I wrote it, I tested it on XCode 6.3.1 with Swift 1.2. It even works with [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) and [Alamofire](https://github.com/alamofire/alamofire), I know right!

### Installation

Just copy the contents of `SwiftCache.swift` and insert it into your XCode. Nothing else necessary.

### Example

```swift

// The above will save it for 60 seconds before expiring the cache
var names = SwiftCache(name: "friendsNames", expiresIn: 60)

// Want to clear the cache? Run this.
// names.expireCache()

names.respond { (data : [String]) in
  if names.isCached() {
    println("Saved in cache: \(data)")
    println("Expires from cache in \(names.secondsLeftInCache()) seconds")
  } else {
    println("Written to cache: \(data)")
  }
}.request { in
  // Save to cache (it'll accept any datatype)
  // In this case, it's a String Array (which is denoted in Swift as [String])
  names.saveToCache(["Mike", "Jon", "Aziz", "Tim", "Joe", "Syeef", "Hamer", "Li", "Gregor"])
}

```

### Another Example

```swift

// Let's remember where a user said they're from (setting expiresIn to -1 means forever)
var currentUserCity = SwiftCache(name: "currentUserCity", expiresIn: -1)

// Want to clear the cache? Run this.
// currentUserCity.expireCache()

names.respond { (currentCity : String) in
  // This will always be ran, but may be from the cache or directly from the block in .request
  println("Hi there stranger from the wonderful city of \(currentCity)")
}.request { in
  // Here, if the cache is empty or expired, you can show a UIView to ask for their location
  let aLocationTheUserSelected : String = "Manchester, United Kingdom"
  names.saveToCache(aLocationTheUserSelected)
}

```

Released under the [MIT License](http://bih.mit-license.org)

