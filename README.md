![SwiftCache.png]()

# Lightweight Swift Cache

Just literally something I threw up. I think you'll like it because it is so simple to work with (and tested on XCode 6.3.1 and Swift 1.2)

### Installation

Just copy the contents of `SwiftCache.swift` and insert it into your XCode. Nothing else necessary.

### Example

```swift

// The above will save it for 60 seconds before expiring the cache
var names = SwiftCache(name: "friendsNames", expiresIn: 60)

// Want to clear the cache? Run this.
// names.expireCache()

names.respond { data in
  if names.isCached() {
    println("Saved in cache: \(data)")
    println("Expires from cache in \(names.secondsLeftInCache()) seconds")
  } else {
    println("Written to cache: \(data)")
  }
}.request { _ in
  // Saved to cache
  names.saveToCache(["Mike", "Jon", "Aziz", "Tim", "Joe", "Syeef", "Hamer", "Li", "Gregor"])
}

```

Released under the [MIT License](http://bih.mit-license.org)