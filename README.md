![](SwiftCache.png)

A beautifully lightweight cache written for **Swift**. It has been tested on iOS and OS X. I wrote it over an hour because I couldn't find something good enough and I think you'll like it.

When I wrote it, I tested it on XCode 6.3.1 with Swift 1.2

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