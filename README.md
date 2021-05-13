# Happin Barcode Scanner
## Purpose
To provide a working code sample as a demonstration of Swift and clean coding ability, but potentially also as a functional service application for Happin.

## Demo video
https://www.dropbox.com/s/1giilgek1alagkb/rpreplay_final1620873645.mov?dl=0

After successful scan, the camera dismisses itself and the entry is displayed.

## Documentation
Rather than wait for access to the Linea Pro SDK, and due to limitations of not having the physical Lineapro hardware, I decided to implement an open source camera based barcode scanner, and wrote an adapter class around it.

```
protocol ScannerAdapterDelegate {
    func scanner(didCaptureCode barcode: Barcode)
    func scanner(didReceiveError error: Error)
}
```

Since the protcol is fairly simple, swapping out the camera scanner for the hardware scanner code should be fairly limited to the ```ScannerAdapter``` codebase, allowing me to design and develop everything else in the meanwhile.

A barcode scan gets parsed into a ```Barcode``` model object, which is a simple ```struct```.

I've also implemented a mock networking manager in ```APIHelper```:
```
class func checkTicketStatus(_ barcode: Barcode, completion:  @escaping (SomeResponseModel?, Error?) -> Void)
```
This takes a Barcode object, makes a call to our mock web API, and parses the returned JSON into a ```SomeResponseModel``` or ```Error```

## Installation

This project uses  ```Cocoapods```, a dependency package manager. If you don't have it, run in terminal:

```bash
$ sudo gem install cocoapods
```

Install dependencies by navigating to the root project folder where Podfile is located, running:
```bash
$ pod install
```

## Open Workspace
Open and use the ```HappinScanner.xcworkspace```, rather than ```HappinScanner.xcodeproj```. You can now edit code and run the application on iOS simulators or test devices.



