# UpdateKit


## What is it?
UpdateKit is a framework to notify the users of your iOS application that an update is available, and offer them to install the update.  

The version number is automatically fetched from the AppStore.
When an update is available and the user accepts it, the AppStore application is opened on your application update page.

If you are still in beta and have not yet published your app on the AppStore, you can activate the manual mode. It allows you to set the version number and download url.


## Install:
Download the compiled library from the [Downloads tags](http://github.com/gcerquant/UpdateKit/downloads) of the UpdakeKit project. If you prefer, you can grab the source and compile it yourself. 

Drag and drop the folder to your project.

Import the header in your appDelegate file:

    #import "UpdateKit.h"
    
Then, wherever you want, call the checkForUpdate method.

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        // ...
        [self.window makeKeyAndVisible];

        [[[UpdateKit alloc] init] checkForUpdate];

        return YES;
    }
    
    
## State of the project

This project is still in beta. Let me know if you get any bug, or wanna help on the code.
    