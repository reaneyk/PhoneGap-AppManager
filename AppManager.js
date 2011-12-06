//
//  AppManager.js
//  
// Created by KC Reaney on 12/05/2011.
//
// Copyright 2011 KC Reaney. All rights reserved.
// MIT Licensed

function AppManager(){
}

AppManager.prototype.listApps = function(callback) {
  PhoneGap.exec(callback, null, "AppManager", "listApps", []);
};

PhoneGap.addConstructor(function() {
  if(!window.plugins){
    window.plugins = {};
  }
  window.plugins.appManager = new AppManager();
});
