#!/usr/bin/env ruby

require 'osx/cocoa'
include OSX

class App < NSObject
  def applicationDidFinishLaunching(aNotification)
    
  end
end

NSApplication.sharedApplication
NSApp.setDelegate(App.alloc.init)
NSApp.run
