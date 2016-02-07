//
//  Calculations.swift
//  SportsTracker
//
//  Created by Venelin Petkov on 2/8/16.
//  Copyright © 2016 Venelin Petkov. All rights reserved.
//

import Foundation

let isMetric: Bool = true;
let metersInKM: Float = 1000;
let metersInMile: Float = 1609.344;

public func stringifyDistance(inMeters meters: Float) -> String {
    var unitDivider: Float;
    var unitName: String;
    
    // metric
    if (isMetric) {
        unitName = "km";
        // to get from meters to kilometers divide by this
        unitDivider = metersInKM;
        // U.S.
    } else {
        unitName = "mi";
        // to get from meters to miles divide by this
        unitDivider = metersInMile;
    }
    let result = String(format:"%.2f %@",meters/unitDivider,unitName);
    return result;
    }

public func stringifySecondCount(withSeconds seconds: Int, andLongFormat longFormat: Bool) -> String {
    var  remainingSeconds: Int = seconds;
    let hours: Int = remainingSeconds / 3600;
    remainingSeconds = remainingSeconds - hours * 3600;
    let minutes: Int = remainingSeconds / 60;
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if (longFormat) {
        if (hours > 0) {
            return String(format: "%ihr %imin %isec", hours, minutes, remainingSeconds);
        }
        else if (minutes > 0) {
            return String(format:"%imin %isec", minutes, remainingSeconds);
        } else {
            return String(format:"%isec", remainingSeconds);
        }
    }
    else {
        if (hours > 0) {
            return String(format:"%02i:%02i:%02i", hours, minutes, remainingSeconds);
        }
        else if (minutes > 0) {
            return String(format:"%02i:%02i", minutes, remainingSeconds);
        }
        else {
            return String(format:"00:%02i", remainingSeconds);
        }
    }
    }
    
public func stringifyAvgPaceFromDist(inMeters meters: Float, andSeconds seconds: Int) ->String{
    if (seconds == 0 || meters == 0) {
        return "0";
    }
    
    let avgPaceSecMeters: Float  = Float(seconds)/meters;
    
    var unitMultiplier: Float;
    var unitName: String;
    
    // metric
    if (isMetric) {
        unitName = "min/km";
        unitMultiplier = metersInKM;
        // U.S.
    }
    else {
        unitName = "min/mi";
        unitMultiplier = metersInMile;
    }
    
    let paceMin: Int = (Int) ((avgPaceSecMeters * unitMultiplier) / 60);
    let paceSec: Int = (Int) (avgPaceSecMeters * unitMultiplier - Float(paceMin*60));
    
    return String(format:"%i:%02i %@", paceMin, paceSec, unitName);
}