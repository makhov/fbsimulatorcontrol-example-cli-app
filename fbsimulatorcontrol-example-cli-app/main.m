//
//  main.m
//  fbsimulatorcontrol-example-cli-app
//
//  Created by amakhov on 16.10.15.
//  Copyright (c) 2015 Avito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSimulatorControl/FBSimulatorControl.h>
#import <FBSimulatorControl/FBProcessLaunchConfiguration.h>
#import <FBSimulatorControl/FBSimulator.h>
#import <FBSimulatorControl/FBSimulatorApplication.h>
#import <FBSimulatorControl/FBSimulatorConfiguration.h>
#import <FBSimulatorControl/FBSimulatorControl+Private.h>
#import <FBSimulatorControl/FBSimulatorControl.h>
#import <FBSimulatorControl/FBSimulatorControlConfiguration.h>
#import <FBSimulatorControl/FBSimulatorSession.h>
#import <FBSimulatorControl/FBSimulatorSessionInteraction.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, Simulator!");
        FBSimulatorManagementOptions options =
        FBSimulatorManagementOptionsDeleteManagedSimulatorsOnFirstStart |
        FBSimulatorManagementOptionsKillUnmanagedSimulatorsOnFirstStart |
        FBSimulatorManagementOptionsDeleteOnFree;
        
        FBSimulatorControlConfiguration *configuration = [FBSimulatorControlConfiguration
                                                          configurationWithSimulatorApplication:[FBSimulatorApplication simulatorApplicationWithError:nil]
                                                          deviceSetPath:nil
                                                          namePrefix:nil
                                                          bucket:0
                                                          options:options];
        
        FBSimulatorControl *control = [[FBSimulatorControl alloc] initWithConfiguration:configuration];
        
        NSError *error = nil;
        FBSimulatorSession *session = [control createSessionForSimulatorConfiguration:FBSimulatorConfiguration.iPhone5 error:&error];
        
        FBApplicationLaunchConfiguration *appLaunch = [FBApplicationLaunchConfiguration
                                                       configurationWithApplication:[FBSimulatorApplication systemApplicationNamed: @"MobileSafari"]
                                                       arguments:@[]
                                                       environment:@{}];
        
        // System Applications can be launched directly, User applications must be installed first with `installSimulator:`
        BOOL success = [[[session.interact
                          bootSimulator]
                         launchApplication:appLaunch]
                        performInteractionWithError:&error];
    }

    return 0;
}