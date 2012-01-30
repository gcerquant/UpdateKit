# UpdateKit


## What is it?
UpdateKit is a framework to notify the users of your iOS application that an update is available, and offer them to install the update.  

The version number is automatically fetched from the AppStore.
When an update is available and the user accepts it, the AppStore application is opened on your application update page.

If you are still in beta and have not yet published your app on the AppStore, you can activate the manual mode. It allows you to set the version number and download url.


## Add the UpdateKit framework to your project
Download the compiled library from the [Downloads](http://github.com/gcerquant/UpdateKit/downloads) tags of the UpdakeKit project. If you prefer, you can grab the source and compile them yourself. 

Drag and drop the UpdateKit folder to your project.

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


## Create your application on updateKit.com

The library communicates with a webservice at updatekit.com to know about the lastest version published on the AppStore. This webservice does all the work of getting the version number of the latest app on the AppStore. This is great, because once it is set-up, you don't have to remember to update it at each update. But for that, you have to create an instance of your application.  

Simply run your application, in the Simulator on or on your device, and look for the following message in the console:  

    Error while getting update information: No application found for identifier com.updateKit.demo. Go to http://updatekit.com/ios_applications/bundle_identifier/com.updateKit.demo to create it.

Copy and paste the url in your browser, then fill and submit the form.

That's it.

## Protect your application

If you don't want anyone but you to edit the settings of your application, create yourself an account using the sign-up link. Then, visit your application page, and click on the "Protect this Application" link.
    
## State of the project

This framework has been built for iOS 5.0 and more. It is compatible with iPhone and iPad.

This project is still in beta. Let me know if you get any bug, or wanna help on the code.
    