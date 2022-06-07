/*
* Copyright (C) 2022 Application library engineering group.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import systemGeolocation from '@system.geolocation';
import geolocation from '@ohos.geolocation';
import ability_featureAbility from '@ohos.ability.featureAbility'

export class LocationUtils {
  mYLocationListener: myLocationListener = null ;
  mListener: OnLocationChangeListener = null;
  constructor() {
    console.info(` u can't instantiate me...`)
  }

  isGpsEnabled() {
    this.requestPermission('ohos.permission.LOCATION')
    this.requestPermission('ohos.permission.LOCATION_IN_BACKGROUND')
    if (geolocation.isGeoServiceAvailable()) {
      console.log('GPS is enabled !')
      return true
    } else {
      console.log('Gps is Not available ')
      return false
    }
  }

  isLocationEnabled() {
    this.requestPermission('ohos.permission.LOCATION')
    this.requestPermission('ohos.permission.LOCATION_IN_BACKGROUND')
    if (geolocation.isLocationEnabled()) {
      console.log('Location is enabled !')
      return true
    } else {
      console.log('Location is not enabled !')
      return false
    }
  }

  register(minTime, minDistance, listener) {
    this.requestPermission('ohos.permission.LOCATION')
    this.requestPermission('ohos.permission.LOCATION_IN_BACKGROUND')
    if (listener == null) return false;
    var locationEnable = false
    if (geolocation.isLocationEnabled()) {
      locationEnable = true;
      console.log('success get location type');
    } else {
      locationEnable = false;
      console.log('failed to get location type location not enabled');
      return false
    }
    if (locationEnable && geolocation.isGeoServiceAvailable()) {
      console.log("LocationUtils 无法定位，请打开定位服务");
      return true;
    }
    var location
    geolocation.getLastLocation((err, data) => {
      console.log('getLastLocation: ');
      location = data
    });
    if (this.mYLocationListener == null) {
      systemGeolocation.getLocation({
        success: function (data) {
          this.mYLocationListener = data
          return true
        },
        fail: function (data, code) {
          return false
        },
      });
    }
  }

  unregister() {
    if (geolocation.isLocationEnabled()) {
      if (this.mYLocationListener != null) {
        this.mYLocationListener = null;
      }
      geolocation.off('locationServiceState')
      geolocation.off('locationChange');
      systemGeolocation.unsubscribe()
      console.log("geolocation off from change in state to location change")
    }
    if (this.mListener != null) {
      this.mListener = null;
    }
  }

  getCountryName(latitude: number, longitude: number) {
    var geoCode = {
      "latitude": latitude,
      "longitude": longitude,
      "maxItems": 1
    }
    geolocation.getAddressesFromLocation(geoCode, (err, data) => {
      return data[0].countryName == null ? "unknown" : data[0].countryName
    });
  }

  getLocality(latitude, longitude) {
    var geoCode = {
      "latitude": latitude,
      "longitude": longitude,
      "maxItems": 1
    }
    var locality
    geolocation.getAddressesFromLocation(geoCode, (err, data) => {
      return data[0].locality == null ? "unknown" : data[0].locality
    });
  }

  getAddress(latitude: number, longitude: number) {
    var geoCode = {
      "latitude": latitude,
      "longitude": longitude,
      "maxItems": 1
    }
    geolocation.getAddressesFromLocation(geoCode, (err, data) => {
      return data == null ? "unknown" : data
    });
  }

  getStreet(latitude, longitude) {
    let geoCode = {
      "latitude": latitude,
      "longitude": longitude,
      "maxItems": 1
    }
    geolocation.getAddressesFromLocation(geoCode, (err, data) => {
      return data[0].roadName == null ? "unknown" : data[0].roadName
    });
  }

  isBetterLocation(newLocation, currentBestLocation) {
    if (currentBestLocation == null) {
      console.log('is better location');
      return true
    }
    var timeDelta = newLocation.timeStamp - currentBestLocation.timeStamp;
    var isSignificantlyNewer
    var isSignificantlyOlder
    if (timeDelta > 10) {
      isSignificantlyNewer = true;
      isSignificantlyOlder = false;
    } else {
      isSignificantlyOlder = true;
      isSignificantlyNewer = false;
    }
    var isNewer = timeDelta > 0;
    if (isSignificantlyNewer) {
      console.log('is better location');
      return true;
    } else if (isSignificantlyOlder) {
      console.log('is not a better location');
      return false;
    }
    var accuracyDelta = (newLocation.accuracy - currentBestLocation.accuracy);
    var isLessAccurate = accuracyDelta > 10;
    var isMoreAccurate = accuracyDelta < 10;
    var isSignificantlyLessAccurate = accuracyDelta > 200;
    if (isMoreAccurate) {
      console.log('is better location');
      return true;
    } else if (isNewer && !isLessAccurate) {
      console.log('is better location');
      return true;
    } else if (isNewer && !isSignificantlyLessAccurate) {
      console.log('is better location');
      return true;
    }
    console.log('is not a better location');
    return false;
  }

  isSameProvider(provider0, provider1) {
    if (provider0 == null) {
      console.log('is not Same provider');
      return provider1 == null;
    }
    console.log('is same provider');
    return provider0.equals(provider1);
  }

  requestPermission(request: string) {
    var context = ability_featureAbility.getContext();
    let permission = request;
    let options = {
      "pid": 12,
      "uid": 0,
    };
    context.verifyPermission(permission, options)
      .then((data) => {
        console.info('permission is granted ');
      }).catch((error) => {
      console.error('permission is not granted ');
      let permissions = [request];
      let requestCode = 123
      context.requestPermissionsFromUser(permissions, requestCode)
        .then((data) => {
          console.info('permission granted by user ');
        }).catch((error) => {
        console.error('permission not granted by user');
      })
    })
  }
}

export class myLocationListener implements OnLocationChangeListener {
  onLocationChanged(location) {
    var requestInfo = {
      'priority': 0x203,
      'scenario': 0x301,
      'timeInterval': 2000,
      'distanceInterval': 5,
      'maxAccuracy': 5
    }
    var locationChange = (location) => {
      console.log('locationChanger: ');
      return location;
    };
    geolocation.on('locationChange', requestInfo, locationChange);
  }

  onStatusChanged() {
    var requestInfo = {
      'priority': 0x203,
      'scenario': 0x301,
      'timeInterval': 2000,
      'distanceInterval': 5,
      'maxAccuracy': 5
    };
    var locationServiceState = (state) => {
      switch (state) {
        case 800:
          console.log("LocationUtils", "Gps is out of Service");
          break;
        case 801:
          console.log("LocationUtils", "Gps is Unavailable");
          break;
      }
      return state
    }
    geolocation.on('locationServiceState', locationServiceState);
  }

  onProviderEnabled(provider) {
  }

  onProviderDisabled(provider) {
  }

  getLastKnownLocation(location) {
  }
}

export interface OnLocationChangeListener {

  getLastKnownLocation(location);

  onLocationChanged(location);

  onStatusChanged();
}