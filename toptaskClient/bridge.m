//
//  bridge.m
//  toptaskClient
//
//  Created by Thomas Spiesser on 16.09.14.
//  Copyright (c) 2014 Thomas Spiesser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeteorClient.h"
#import "ObjectiveDDP.h"
#import <ObjectiveDDP/MeteorClient.h>

MeteorClient* initialiseMeteor(NSString* version, NSString* endpoint) {
    MeteorClient *meteorClient = [[MeteorClient alloc] initWithDDPVersion:version];
    ObjectiveDDP *ddp = [[ObjectiveDDP alloc] initWithURLString:endpoint delegate:meteorClient];
    meteorClient.ddp = ddp;
    [meteorClient.ddp connectWebSocket];
    return meteorClient;
}