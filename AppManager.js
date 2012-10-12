//
//  AppManager.js
//  
// Created by KC Reaney on 12/05/2011.
//
// Copyright 2011 KC Reaney. All rights reserved.
// MIT Licensed

(function() {
 
  var cordovaRef = window.PhoneGap || window.Cordova || window.cordova;

  function AppManager(){
  }

  AppManager.prototype.listApps = function(callback) {
    cordovaRef.exec(callback, null, "AppManager", "listApps", []);
  };

  cordovaRef.addConstructor(function() {
    if(!window.plugins){
      window.plugins = {};
    }
    window.plugins.appManager = new AppManager();
  });

})();