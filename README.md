#  2048 Game (SwiftUI app)

This is a simple game to demonstrate the new SwiftUI framework.

> Note that the game algorithm may have issues, and this is still WIP.

![Screenshot](Screenshot.png)

## Notes about "UIKit for Mac"

This demo has adopted "UIKit for Mac" and uses a dynamic-loaded bundle to enable the full macOS abilities (like the accessing to AppKit, which is used in the demo to handle keyboard events). Specially, this is done by just using Swift. To learn more about it, take a look at the source code of `AppKitSupports`, there is a lot of detailed comments.  

## License

MIT
