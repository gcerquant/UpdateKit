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

        [UpdateKit checkForUpdate];

        return YES;
    }


## Create your application on updateKit.com

The library communicates with a webservice at updatekit.com to know about the lastest version published on the AppStore. This webservice does all the work of getting the version number of the latest app on the AppStore. This is great, because once it is set-up, you don't have to remember to update it at each update.

When you ask the webservice if there is an update for an application it does not know, it creates it.
By default, an application is in automatic mode: it fetches the information from the AppStore.

If you have not yet published your application, you might want to go to www.updatekit.com and set your application to manual mode.

## Protect your application

If you want no one but you to edit the settings of your application, you must protect it. To do that, simply log in and on your application page, click on the "Protect this Application" link.
    
## State of the project

This framework has been built for iOS 5.0 and more. It is compatible with iPhone and iPad.

This project is still in beta. Let me know if you get any bug, or wanna help on the code. You can look at the ticket lists of the framework ([here](http://github.com/gcerquant/UpdateKit/issues)) and the webservice ([here](http://github.com/gcerquant/UpdateKit.com/issues)). 
    